# Crop Growth Modelling: AI-Driven Ideotype Optimization

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2024b-blue.svg)](https://www.mathworks.com/)
[![DSSAT](https://img.shields.io/badge/DSSAT-v4.8-green.svg)](https://dssat.net/)

Inverse engineering framework for crop ideotype optimization using process-based modeling (CERES-Rice) coupled with genetic algorithm optimization.

## Overview

This repository contains the complete code and data to replicate the analysis presented in:

> **Correa, E.S. (2025).** Decoding Living Systems: Reassessing Crop Model Frontiers via Biological Dynamics and Optimized Phenotype. *PLOS ONE*.

The framework integrates three analytical layers:
1. **Sensitivity Analysis** - Morris method to identify influential genetic coefficients
2. **Genetic Algorithm** - Optimization of virtual phenotypes across environments
3. **Similarity Analysis** - Mapping computational ideotypes to field-validated cultivars

## Key Results

| Metric | Value |
|--------|-------|
| Virtual cultivars evaluated | 5,364 |
| Environments analyzed | 4 |
| Field-validated cultivars | 21 |
| Best breeding candidate | WAB56-50 (70.7% similarity) |
| Genetic gap to optima | 22-30% |

## Repository Structure
```
Crop-Growth-Modelling/
│
├── 1_Sensitivity_Analysis/
│   ├── replicate_results/     # Fast: ~10 seconds
│   ├── run_from_scratch/      # Slow: ~4-8 hours
│   └── functions/
│
├── 2_Genetic_Algorithm/
│   ├── replicate_results/     # Fast: ~30 seconds
│   ├── run_from_scratch/      # Slow: ~4-8 hours per environment
│   └── functions/
│
├── 3_Similarity_Analysis/
│   ├── main_similarity_analysis.m
│   └── data/
│
└── Data/
    ├── environment/           # Climate and soil inputs
    └── cultivars/             # Genetic coefficients
```

## Quick Start

### Option A: Replicate Paper Results (Recommended)
```matlab
% Step 1: Sensitivity Analysis (~10 seconds)
cd 1_Sensitivity_Analysis/replicate_results
main_replicate_results

% Step 2: Genetic Algorithm (~30 seconds)
cd ../../2_Genetic_Algorithm/replicate_results
main_replicate_results

% Step 3: Similarity Analysis (~20 seconds)
cd ../../3_Similarity_Analysis
main_similarity_analysis
```

### Option B: Run From Scratch

Requires DSSAT v4.8 installation and several hours of computation.
```matlab
% Step 1: Sensitivity Analysis (~4-8 hours)
cd 1_Sensitivity_Analysis/run_from_scratch
main_run_sensitivity

% Step 2: Genetic Algorithm (~4-8 hours per environment)
cd ../../2_Genetic_Algorithm/run_from_scratch
main_run_optimization  % Change ENV variable for each environment

% Step 3: Similarity Analysis
cd ../../3_Similarity_Analysis
main_similarity_analysis
```

## Requirements

### Software
- MATLAB R2024b or later
- Statistics and Machine Learning Toolbox
- DSSAT v4.8 (for run_from_scratch only)
- R v4.4.2 with DSSAT-R package (for run_from_scratch only)

### Hardware
- Windows 11 (tested on Build 26100.7171)
- Intel i7-12700H or equivalent
- 32 GB RAM recommended

## Methodology

### 1. Sensitivity Analysis (Morris Method)

Identifies which genetic coefficients most influence model outputs.

| Parameter | Value |
|-----------|-------|
| Parameters (k) | 11 |
| Levels (p) | 4 |
| Replications (r) | 20 |
| Total evaluations | 240 per replication |

**Output:** Parameter rankings with 95% confidence intervals (mean CI width = 0.04)

### 2. Genetic Algorithm Optimization

Explores phenotypic landscape to identify optimal genetic configurations.

| Parameter | Value |
|-----------|-------|
| Generations | 40 |
| Population size | 15 |
| Mutation rate | 70% |
| Fitness function | HI + WUE_norm |

**Fitness Function:**
```
Fitness = HI + WUE_norm
WUE_norm = (WUE - 2) / (15 - 2)
```

### 3. Similarity Analysis

Maps computational ideotypes to existing germplasm using multiple distance metrics.

| Metric | Purpose |
|--------|---------|
| Euclidean | Overall magnitude |
| Manhattan | Outlier-robust |
| Cosine | Proportional patterns |

**Similarity Formula:**
```
Similarity = (1 - d̄_ij / max(d̄)) × 100%
```

## Genetic Coefficients

| Parameter | Range | Description |
|-----------|-------|-------------|
| P1 | 150-800 GDD | Vegetative phase duration |
| P2O | 11-13 h | Critical photoperiod |
| P2R | 5-300 GDD | Photoperiod sensitivity |
| P5 | 150-850 GDD | Grain filling duration |
| G1 | 50-75 | Spikelet number coefficient |
| G2 | 0.015-0.030 g | Single grain weight |
| G3 | 0.7-1.3 | Tillering coefficient |
| PHINT | 55-90 GDD | Phyllochron interval |

## Environments

| Env | Precipitation | Soil (SDUL) | Strategy | Area |
|-----|---------------|-------------|----------|------|
| 1 | 815 mm | 0.30 cm³/cm³ | Extended growth | 30% |
| 2 | 540 mm | 0.28 cm³/cm³ | Drought escape | 27% |
| 3 | 815 mm | 0.25 cm³/cm³ | Drought escape | 11% |
| 4 | 540 mm | 0.23 cm³/cm³ | Drought escape | 21% |

## Outputs

### Figures
| Figure | Description | Location |
|--------|-------------|----------|
| Figure 6 | Sensitivity Taylor diagrams | `1_Sensitivity_Analysis/RESULTS/` |
| Figure 7 | Phenotypic landscape | `2_Genetic_Algorithm/RESULTS/` |
| Figure S1 | GA convergence | `2_Genetic_Algorithm/RESULTS/` |
| Figure 9 | PCA + similarity | `3_Similarity_Analysis/RESULTS/` |
| Figure 10 | Similarity heatmap | `3_Similarity_Analysis/RESULTS/` |

### Tables
| Table | Description | Location |
|-------|-------------|----------|
| Table S1 | RSI statistics | `1_Sensitivity_Analysis/RESULTS/` |
| Table S2 | Correlation statistics | `2_Genetic_Algorithm/RESULTS/` |
| Table S3 | Optimal coefficients | `2_Genetic_Algorithm/RESULTS/` |

## Citation

If you use this code, please cite:
```bibtex
@article{Correa2025,
  author = {Correa, Edgar S.},
  title = {Decoding Living Systems: Reassessing Crop Model Frontiers via Biological Dynamics and Optimized Phenotype},
  journal = {PLOS ONE},
  year = {2025},
}
```

## Data Availability

- **Code:** This repository (CC BY 4.0)
- **Data:** [Zenodo DOI pending]

## Related Publications

1. Correa, E.S. et al. (2025). Ml-enhanced mechanistic crop modeling to address noise-induced uncertainty for drought environmental monitoring in rice. *Discover Food*. 5, 312 (2025). https://doi.org/10.1007/s44187-025-00611-3
2. Correa, E.S. (2025). Runoff potential index (RPI): 3D modelling of surface-driven hydrological dynamics for drought resilience. *Scientific Reports*. 

## Acknowledgements

- Agropolis Fondation (CropModAdapt project, Contract No. 2201-026)
- ClimBeR initiative – France–CGIAR Action Plan on Climate Change (ICARDA Agreement No. 200303)
- Pontificia Universidad Javeriana (Ph.D. scholarship)
- UMR AGAP Institut, CIRAD

## License

This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

## Contact

**Edgar S. Correa**  
Pontificia Universidad Javeriana  
Email: e_correa@javeriana.edu.co  
GitHub: [@EdgarStevenC](https://github.com/EdgarStevenC)
