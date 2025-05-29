# PlantVillage-AugNoLeaves
This repository contains the code and data representing outcomes of the paper "A TinyMLOps-Based Edge AI Approach for Early Detection of Emerging Plant Diseases," accepted at [IEEE MetroInd4.0&amp;IoT 2025](https://www.metroind40iot.org/).

<p align="center">
  <img width="260" src="readme/metroindLogo.png">
</p>

## 📄 License

- 📦 **Code** is licensed under the [MIT License](./LICENSE.md).

- 🌱 **Augmented dataset** (**PlantVillage-AugNoLeaves**) is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
  Adapted from the original dataset (CC BY-SA 3.0 Unported) by increasing the *Background_without_leaves* class using [Albumentations](https://github.com/albumentations-team/albumentations). © 2025 by [OpenIoT Research Unit](https://creativecommons.org)

  <a href="https://creativecommons.org/licenses/by-sa/4.0/">
    <img src="https://mirrors.creativecommons.org/presskit/icons/cc.svg" style="max-width:1em; max-height:1em; margin-left:.2em;">
    <img src="https://mirrors.creativecommons.org/presskit/icons/by.svg" style="max-width:1em; max-height:1em; margin-left:.2em;">
    <img src="https://mirrors.creativecommons.org/presskit/icons/sa.svg" style="max-width:1em; max-height:1em; margin-left:.2em;">
  </a>

- 🗃️ **Original dataset** is available via [Mendeley Data](https://data.mendeley.com/datasets/tywbtsjrjv/1).
  While currently listed as [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/), the dataset was originally [published](https://arxiv.org/pdf/1511.08060) under [CC BY-SA 3.0 Unported](https://creativecommons.org/licenses/by-sa/3.0/), which this work adheres to.

## Abstract
This paper presents a computer vision-based system for early detection of plant leaf diseases, developed using TinyMLOps principles to enable deployment on resource-constrained embedded devices. The solution leverages the MobileNet architecture with a custom classification head that is properly trained using the PlantVillage dataset to distinguish between healthy, unhealthy, and no leaves images. Given the class imbalance of the relabeled dataset, we augmented the underrepresented classes (No leaves) using basic image transformations to improve model generalization. To ensure both high accuracy and computational feasibility, considering that the target device has limited resources, we apply a multi-objective hyperparameter optimization strategy using the Optuna framework, incorporating the NSGA-II algorithm to identify optimal trade-offs between model accuracy (measured by F1-score) and computational constraints (number of model parameters). The optimization process identifies a set of Pareto-optimal models, with the most promising configurations residing in the "knee region", offering strong classification performance with significantly reduced parameter counts. From the Pareto front, we selected a few models that were evaluated on a Raspberry Pi Zero 2W to assess their real-world performance in terms of inference latency, memory usage, and overall suitability for deployment in resource-constrained environments. This poses the basis for building a low-cost solution with commodity devices for early diseases detection in agriculture, including rural areas where computational resources and connectivity are limited.
Finally, the dataset we used for this work has been made public as an asset of the AgrifoodTEF Data Space.

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
- pandas
- Dataset in PlantVillage-AugNoLeaves.zip


### ⚙️ Project Setup
1. Clone the repository:
`It may take a few minutes.`

```bash
git clone https://github.com/FBK-OpenIoT/PlantVillage-AugNoLeaves.git
cd PlantVillage-AugNoLeaves
unzip PlantVillage-AugNoLeaves.zip
cd PlantVillage-AugNoLeaves-Dataset
```
2. Extract the dataset
```bash
./unzip_dataset.sh
```

3. Make sure your dataset is structured like this:
```bash
extracted_dataset/
├── Apple___Apple_scab/
├── Apple___Black_rot/
├── Apple___Cedar_apple_rust/
├── Apple___healthy/
├── Background_without_leaves/
├── Blueberry___healthy/
├── Cherry___healthy/
├── Cherry___Powdery_mildew/
├── Corn___Common_rust/
├── Corn___Northern_Leaf_Blight/
├── Corn___healthy/
├── Corn___Cercospora_leaf_spot Gray_leaf_spot/
├── Grape___Black_rot/
├── Grape___Esca_(Black_Measles)/
├── Grape___Leaf_blight_(Isariopsis_Leaf_Spot)/
├── Grape___healthy/
├── Orange___Haunglongbing_(Citrus_greening)/
├── Peach___Bacterial_spot/
├── Peach___healthy/
├── Pepper,_bell___Bacterial_spot/
├── Pepper,_bell___healthy/
├── Potato___Early_blight/
├── Potato___Late_blight/
├── Potato___healthy/
├── Raspberry___healthy/
├── Soybean___healthy/
├── Squash___Powdery_mildew/
├── Strawberry___healthy/
├── Strawberry___Leaf_scorch/
├── Tomato___Bacterial_spot/
├── Tomato___Early_blight/
├── Tomato___Late_blight/
├── Tomato___Leaf_Mold/
├── Tomato___Septoria_leaf_spot/
├── Tomato___Spider_mites Two-spotted_spider_mite/
├── Tomato___Target_Spot/
├── Tomato___Tomato_mosaic_virus/
├── Tomato___Tomato_Yellow_Leaf_Curl_Virus/
├── Tomato___healthy/
```

1. Set up a virtual environment:
```bash
python3 -m venv plantenv
source plantenv/bin/activate
```

1. Install Required Packages:
```bash
pip install --upgrade pip
pip install pandas
```


### 🌱 Dataset Preparation
5. Load the Dataset:
```bash
# Path to the dataset
dataset_path = './extracted_dataset'
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
df = collect_data(dataset_path)
```

7. Print class distribution in the dataset:
```bash
# Print class distribution in the dataset
print(f"📌 Total images found: {len(df)}")
print("📌 Class distribution:")
print(df['class'].value_counts())
```



## Aknowledgements and Citation
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
