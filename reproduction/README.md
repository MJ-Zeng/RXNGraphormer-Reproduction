# RXNGraphormer Reproduction

This repository provides a structured reproduction of RXNGraphormer, covering core functionalities, task performance validation, and chemical interpretability analysis. Key components include:

---

## 📁 Directory Structure

```
reproduction/
├── 1_basic_usage.ipynb           # Core model functionality verification  
├── 2_Reaction_Type_Visual.ipynb  # Reaction type discrimination & clustering (part new work)  
├── 3_regression.sh               # Regression task training script  
├── 4_USPTO.sh                    # USPTO-style dataset training for sequence generation  
├── 5_SPR.ipynb                   # Structure-performance relationship analysis  
├── 6_test.ipynb                  # External validation on literature datasets (new work)  
└── README.md                     # Documentation
```

---

## ✅ Core Functionalities

**1. Basic Usage**  
Verifies fundamental operations including:  
- Data preprocessing  
- Embedding generation  
- Forward inference  
- Output interpretation  
Ensures alignment with the original architecture.

---

## 🔬 Model Analysis

**2. Reaction-Type Visualization**  
- Reproduces supervised pre-training for 10-class reaction type classification  
- Explores unsupervised clustering to investigate latent reaction space organization (new work)  
> 🔧 **Dependency update**: Requires `hdbscan`. Install via:  
> ```bash
> pip install hdbscan
> ```
> Used for density-based clustering of reaction embeddings to identify chemically meaningful groupings in the latent space.

**3. Regression Tasks**  
Evaluates prediction of:  
- Reactivity (yield)  
- Regioselectivity  
- Enantioselectivity  
Using `3_regression.sh` with MAE/RMSE/R² metrics.


**4. USPTO Training Script**  
- Modified `rxngraphormer/train.py` with `try_resume()` function  
- Enables checkpoint resumption for model, optimizer, scheduler  
- Maintains training state and best validation score  
Using `4_USPTO.sh` for sequence generation tasks (synthesis planning) on USPTO-style datasets.  
> 🔧 **Code update**: Added `try_resume()` with `\_strip_module_prefix` to support DDP-trained checkpoint loading; enables automatic training resumption from saved state.



**5. Structure-Performance Relationships (SPR)**  
Analyzes fine-tuned models via:  
- Attention weight visualization  
- Gradient-based feature attribution (e.g., Integrated Gradients)  
Demonstrates enhanced ability to identify chemically relevant motifs.

---


## 📊 External Validation (New Work)

**6. Literature Dataset Evaluation**  
Validates generalizability across:  
1. **Sulfoxonium Ylide Dataset** [Lin et al., Sci. China Chem. 2025]  
   - Ru-catalyzed P(O)O-H insertion reactions  
2. **Meta-C–H Functionalization** [Chem 2022]  
   - Sterically challenging C–H bond activation  
3. **Amide Coupling (HTE)** [Zhang et al., Sci. China Chem, 16, 11809-11822]  
   - Machine-guided high-throughput experimentation  
4. **Amide Coupling (Literature)**  
   - Recent 3-year literature compilation  

> ⚠️ Note: Intermediate generation analysis omitted due to dataset limitations (marked **no mech**).  
> 🔧 **Code update**: `eval_regression_performance` in `rxngraphormer/eval.py` was enhanced to support four evaluation modes via `specific_val` and `use_mid_inf` flags for flexible and systematic validation.
---

## 📚 Acknowledgments

Built upon the original RXNGraphormer framework and open-source datasets. 


