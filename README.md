# RXNGraphormer Reproduction

This repository provides a **reproduction** of [🔗 RXNGraphormer](https://github.com/licheng-xu-echo/RXNGraphormer), a unified pre-trained framework for reaction performance prediction and synthesis planning. The original work is by Xu et al.

This reproduction focuses on validating core functionalities, reaction-type analysis, and extending evaluation to external literature datasets.

---

## 📁 Directory Structure

```
RXNGraphormer/reproduction/
├── 1_basic_usage.ipynb           # Basic model usage and embedding generation
├── 2_Reaction_Type_Visual.ipynb  # Reaction type clustering and visualization (uses hdbscan)
├── 3_regression.sh               # Script for regression task training
├── 4_USPTO.sh                    # Script for USPTO-style sequence generation tasks
├── 5_SPR.ipynb                   # Structure-performance relationship analysis
├── 6_test.ipynb                  # External validation on real-world literature datasets
└── README.md
```

---

## 🗂️ Project Organization Update

For better reproducibility, the internal directory structures of `config`, `dataset`, and `model_path` have been reorganized compared to the original repository.

---

## ⚙️ Reproduction Setup

This reproduction uses the **original pre-trained model** weights; we only perform fine-tuning on downstream tasks (e.g., yield, selectivity prediction).  
For sequence generation tasks, models are fine-tuned on USPTO-50k and USPTO-480k, while the **USPTO-full model is evaluated without retraining**.  

All training logs and checkpoints are saved under corresponding subdirectories in `model_path/`.

```bash
# Install the additional dependency for reaction-type clustering
pip install hdbscan
```

> ✅ `hdbscan` is used in `2_Reaction_Type_Visual.ipynb` for unsupervised clustering of reaction embeddings.

---


## 📦 Datasets and Training Artifacts


- **For all datasets (`USPTO_STEREO`, `USPTO_full`, `USPTO_480k`, `USPTO_50k`, `OOS`, `external_validation_dataset`, and `50k_with_rxn_type`)**:  
  Download from the [original model's Figshare repository](https://figshare.com/s/decc64a868ab64a93099).  
  These preprocessed datasets are part of the original RXNGraphormer release.

- **For `Test.zip`**:  
  Download from [our Figshare repository](https://doi.org/10.6084/m9.figshare.30498368.v2).  
  This test set is newly introduced in our study.

> **Note**:  
> - All **model checkpoints, training logs, and evaluation results** are available in **our Figshare repository** and correspond to our independent reproduction runs.  
> - Please follow the dataset directory structure outlined below after extraction.
> - 💡 This ensures full reproducibility of all experiments presented in the `reproduction/` notebooks and scripts.

---

## 🧪 What This Reproduction Covers

- ✅ Basic inference and embedding generation  
- ✅ Reaction type classification and unsupervised clustering  
- ✅ Regression tasks (yield, regioselectivity, enantioselectivity)  
- ✅ Sequence generation (forward/retro-synthesis) on USPTO dataset   
- ✅ Structure-performance relationship (SPR) analysis  
- ✅ External validation on real-world literature datasets

---

## 📚 Acknowledgments

Thanks to the original authors for open-sourcing RXNGraphormer. This reproduction builds directly upon their codebase and methodology.

---

> 💡 **Note**: For full installation instructions and model details, please refer to the [original README](https://github.com/licheng-xu-echo/RXNGraphormer).

