# PlantVillage-AugNoLeaves
This repository contains the code and data representing outcomes of the paper "A TinyMLOps-Based Edge AI Approach for Early Detection of Emerging Plant Diseases," accepted at [IEEE MetroInd4.0&amp;IoT 2025](https://www.metroind40iot.org/).

<p align="center">
  <img width="260" src="readme/metroindLogo.png">
</p>

## Abstract
To be put after final submission

## 📂 Dataset Overview

The dataset is a refined and augmented version of the PlantVillage dataset, extended to include a "no leaves" class representing background-only images. All data was processed into three broad categories for training an edge-AI model:

- **Unhealthy**: 43,875 images  
- **Healthy**: 16,468 images  
- **No Leaves (Background)**: 15,325 images  

📌 **Total images**: 75,668  
📌 **Number of original classes**: 39

Each original class was mapped into one of the following categories:

- `healthy`
- `unhealthy`
- `no leaves`

### 🌿 Sample Classes by Category

This table categorizes plant images into **Healthy**, **Unhealthy**, and **No Leaves** classes, commonly used for training classification models in plant pathology datasets.

| **Healthy**                | **Unhealthy**                                     | **No Leaves**                  |
|---------------------------|---------------------------------------------------|--------------------------------|
| Apple___healthy           | Apple___Apple_scab                                | Background_without_leaves      |
| Blueberry___healthy       | Apple___Black_rot                                 |                                |
| Cherry___healthy          | Apple___Cedar_apple_rust                          |                                |
| Corn___healthy            | Cherry___Powdery_mildew                           |                                |
| Grape___healthy           | Corn___Cercospora_leaf_spot Gray_leaf_spot       |                                |
| Peach___healthy           | Corn___Common_rust                                |                                |
| Pepper,_bell___healthy    | Corn___Northern_Leaf_Blight                       |                                |
| Potato___healthy          | Grape___Black_rot                                 |                                |
| Raspberry___healthy       | Grape___Esca_(Black_Measles)                      |                                |
| Soybean___healthy         | Grape___Leaf_blight_(Isariopsis_Leaf_Spot)       |                                |
| Strawberry___healthy      | Orange___Haunglongbing_(Citrus_greening)         |                                |
| Tomato___healthy          | Peach___Bacterial_spot                            |                                |
|                           | Pepper,_bell___Bacterial_spot                     |                                |
|                           | Potato___Early_blight                             |                                |
|                           | Potato___Late_blight                              |                                |
|                           | Squash___Powdery_mildew                           |                                |
|                           | Strawberry___Leaf_scorch                          |                                |
|                           | Tomato___Bacterial_spot                           |                                |
|                           | Tomato___Early_blight                             |                                |
|                           | Tomato___Late_blight                              |                                |
|                           | Tomato___Leaf_Mold                                |                                |
|                           | Tomato___Septoria_leaf_spot                       |                                |
|                           | Tomato___Spider_mites Two-spotted_spider_mite     |                                |
|                           | Tomato___Target_Spot                              |                                |
|                           | Tomato___Tomato_mosaic_virus                      |                                |
|                           | Tomato___Tomato_Yellow_Leaf_Curl_Virus           |                                |
| | | |
| **Classes:** 12           | **Classes:** 26                                   | **Classes:** 1                 |
| **Samples:** 16486    | **Samples:** 43875                            | **Samples:** 15325         |

---

## 🚀 Getting Started


### 📦 Prerequisites
- Python 3.7+ (`python --version`)
- pip package manager (`pip --version`)
- TensorFlow 2.x
- scikit-learn
- pandas
- numpy
- Dataset in PlantVillage-AugNoLeaves.zip


### ⚙️ Project Setup
1. Clone the repository:
`It may takes a few minutes.`

```bash
git clone https://github.com/FBK-OpenIoT/PlantVillage-AugNoLeaves.git
cd PlantVillage-AugNoLeaves
unzip PlantVillage-AugNoLeaves.zip
cd PlantVillage-AugNoLeaves-Dataset
```

2. Make sure your dataset is structured like this:
```bash
dataset_path/
├── Apple___healthy/
├── Apple___Black_rot/
├── Background_without_leaves/
├── ...
```

3. Set up a virtual environment:
```bash
python3 -m venv plantenv
source plantenv/bin/activate
```

4. Install Required Packages:
```bash
pip install --upgrade pip
pip install tensorflow scikit-learn pandas numpy pillow
```


### 🌱 Dataset Preparation
5. Load the Dataset:
```bash
# Path to the dataset
dataset_path = dataset_path = '/path/to/your/dataset/'
image_size = (128, 128)
batch_size = 8
valid_extensions = ('.png', '.jpg', '.jpeg')

# Define healthy and unhealthy plant classes
healthy_classes = [
    'Strawberry___healthy', 'Blueberry___healthy', 'Peach___healthy',
    'Apple___healthy', 'Tomato___healthy', 'Corn___healthy',
    'Soybean___healthy', 'Raspberry___healthy', 'Grape___healthy',
    'Pepper,_bell___healthy'
]
no_leaves_classes = ['Background_without_leaves']
all_classes = os.listdir(dataset_path)

# Create a mapping for labels: "healthy", "unhealthy", or "no leaves"
unhealthy_classes = [cls for cls in all_classes if cls not in healthy_classes + no_leaves_classes]
label_mapping = {cls: "healthy" for cls in healthy_classes}
label_mapping.update({cls: "unhealthy" for cls in unhealthy_classes})
label_mapping.update({cls: "no leaves" for cls in no_leaves_classes})
```

6. Function to collect data from the dataset directory:
```bash
def collect_data(dataset_path):
    file_paths = []
    labels = []
    
    for label_folder in all_classes:
        if label_folder in label_mapping:  # Only process folders in label_mapping
            class_label = label_mapping[label_folder]
            label_path = os.path.join(dataset_path, label_folder)

            if os.path.isdir(label_path):
                image_files = os.listdir(label_path)
                print(f"Processing {len(image_files)} images from class: {class_label}")

                for image_file in image_files:
 
                    if not image_file.startswith('.') and image_file.lower().endswith(valid_extensions):
                        image_path = os.path.join(label_path, image_file)
                        file_paths.append(image_path)
                        labels.append(class_label)
                    else:
                        print(f"Warning: Skipping non-image or hidden file {image_file}")
    
    return pd.DataFrame({'file_path': file_paths, 'class': labels})
```




7. Collect the dataset and split it into train, validation, and test sets:
```bash
df = collect_data(dataset_path)
train_df, test_df = train_test_split(df, test_size=0.2, random_state=1)
train_df, val_df = train_test_split(train_df, test_size=0.25, random_state=1)
```


6. Function to collect data from the dataset directory:
```bash
# Initialize ImageDataGenerator for image preprocessing
datagen = ImageDataGenerator(preprocessing_function=preprocess_input)

# Function to create data generator for feeding images into the model
def create_generator(df, shuffle=False):
    return datagen.flow_from_dataframe(
        dataframe=df,
        x_col='file_path',
        y_col='class',
        target_size=image_size,
        batch_size=batch_size,
        class_mode='categorical',
        shuffle=shuffle,
        color_mode='rgb'
    )

# Create train, validation, and test data generators
train_generator = create_generator(train_df, shuffle=True)
val_generator = create_generator(val_df)
test_generator = create_generator(test_df)
```


6. Print class distribution in the dataset:
```bash
# Print class distribution in the dataset
print(f"📌 Total images found: {len(df)}")
print("📌 Class distribution:")
print(df['class'].value_counts())
```



## Aknowledgements and Citation
Data contained in this repository has been developed within the FBK research institute. It's usage has been agreed with the owner.

Copyright on the material in this webpage has been transferred to IEEE for MetroInd4.0&IoT 2025: H. Aqasizade, M. Antonini, M. Vecchio and F. Antonelli, "A TinyMLOps-Based Edge AI Approach for Early Detection of Emerging Plant Diseases," 2025 IEEE International Workshop Metrology for Industry4.0 & IoT (MetroInd4.0&IoT), Castelldefels, Spain, 2025.

A final version for the citation with DOI will be provided after publication.

This work was partially supported by the Interconnected Nord-Est Innovation Ecosystem (iNEST), founded by European Union Next-GenerationEU (PNRR, Missione 4 Componente 2, Investimento 1.5 – D.D. 105823/06/2022, Ecs00000043), and the AgrifoodTEF project of the Digital Europe Programme (GA #101100622).


<p align="center">
  <img width="250" src="readme/fbkLogo.jpeg">
  <img width="170" src="readme/iotLogo.png">
</p>
<p align="center">
  <img width="170" src="readme/agrifoodtefLogo.png">
</p>
