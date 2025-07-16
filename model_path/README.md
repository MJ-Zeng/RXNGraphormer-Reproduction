Put the model in specific folder like this:

```
RXNGraphormer
├── rxngraphormer
├── dataset
└── model_path
    ├── buchwald_hartwig
    ├── C_H_func
    ├── external_validation
    ├── pretrained_classification_model
    ├── suzuki_miyaura
    ├── Test
    ├── thiol_addition
    ├── USPTO_50k
    ├── USPTO_480k
    ├── USPTO_full
    └── USPTO_STEREO
```

> **Note**: The folders `seq-v2-USPTO_STEREO-20250423_044122_ft` and `seq-v2-USPTO_STEREO-20250509_070206_ft` are training checkpoints saved during the training process on the USPTO_STEREO dataset. They allow resuming training from a specific point if interrupted.  
> For inference or deployment, only the final trained model located in the `USPTO_STEREO` directory is needed. These checkpoint folders can be safely removed to save storage space without affecting model usage.