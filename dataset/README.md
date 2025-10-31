Please download the following files:  
`USPTO_STEREO.zip`, `USPTO_full.zip`, `USPTO_480k.zip`, `USPTO_50k.zip`, `Test.zip`, `OOS.zip`, `external_validation_dataset.zip`, and `50k_with_rxn_type.zip`.

- **For all datasets except `Test.zip`**: Download from the [original model's Figshare repository](https://figshare.com/s/decc64a868ab64a93099) 
    
  

- **For `Test.zip`**: Download from  [our Figshare repository](https://doi.org/10.6084/m9.figshare.30498368.v2) .

After downloading, unzip each file and place the extracted dataset folders under the `dataset/` directory, following the structure below:

```
dataset/
├── 50k_with_rxn_type/
├── benchmark/
├── external_validation_dataset/
├── OOS/
├── Test/
├── USPTO_50k/
├── USPTO_480k/
├── USPTO_full/
└── USPTO_STEREO/
```

> **Note**: The `benchmark/` folder should be created if it does not exist, and relevant benchmark data should be placed there as needed. Ensure all dataset directories are correctly named to match the expected structure.