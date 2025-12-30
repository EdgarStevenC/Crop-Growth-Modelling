# **Crop-Growth-Modelling**

<p align="center">
<img src="./media/MCM2.png" alt="drawing" width="1000"/>  
</p>

**Mechanistic crop models (MCMs)** are multidisciplinary tools that integrate expertise in dynamic systems modeling, computational techniques, and plant biology. They capture both the internal mechanisms driving plant growth and the external interactions of these mechanisms within dynamic cropping systems [1][2].

The goal of MCM is to simulate plant growth as the product of a series of interactions among the plant and environment. The model functions as an integrated system of reduced algorithms, each describing a different interaction and cohesively linking all model components [1]. Notable and widely-used crop growth models include DSSAT (USA), APSIM (Australia), STICS (France), and AquaCrop (Italy) [3]. 

[1] https://doi.org/10.1007/s13593-022-00854-9  
[2] https://doi.org/10.1093/jxb/erp375  
[3] https://doi.org/10.1093/jxb/erz175

<p align="center">
<img src="./media/MCM_CERES-Rice_ML.png" alt="drawing" width="1000"/>  
</p>

---

## 🔬 Replicate PLOS ONE (2025) Results

📁 **[PLOS2025_Crop_Growth_Modelling](./PLOS2025_Crop_Growth_Modelling/)**

This folder contains organized, documented code to **replicate all results** from:

> **Correa, E.S. (2025).** Decoding Living Systems: Reassessing Crop Model Frontiers via Biological Dynamics and Optimized Phenotype. *PLOS ONE*.

### Quick Start (< 1 minute total)
```matlab
% Step 1: Sensitivity Analysis
cd PLOS2025_Crop_Growth_Modelling/1_Sensitivity_Analysis/replicate_results
main_replicate_results

% Step 2: Genetic Algorithm
cd ../../2_Genetic_Algorithm/replicate_results
main_replicate_results

% Step 3: Similarity Analysis
cd ../../3_Similarity_Analysis
main_similarity_analysis
```

### Key Results
| Metric | Value |
|--------|-------|
| Virtual cultivars evaluated | 5,364 |
| Environments analyzed | 4 |
| Best breeding candidate | WAB56-50 (70.7% similarity) |
| Genetic gap to optima | 22-30% |

---

## Derived Publications

The following publications are derived from this study:

- Edgar S. Correa, Francisco C. Calderon, Julian D. Colorado et al. AI-driven remote sensing for environmental characterization and rice crop modeling in water-limited regions, 16 April 2025, PREPRINT (V1) available at Research Square [https://doi.org/10.21203/rs.3.rs-6440110/v1]

- Edgar S. Correa. Mechanistic crop modelling for ideotype optimization: Regional strategies to enhance yield and water use efficiency [https://doi.org/10.1101/2025.05.15.652350]

---

## Software and Tools Used

- **MATLAB**: MathWorks (2024). Version 2024b  
- **R**: Version 4.4.2  
- **DSSAT**: Version 4.8 (Decision Support System for Agrotechnology Transfer)

---

## Code Structure

### PLOS2025_Crop_Growth_Modelling/ (Recommended)

Organized pipeline to replicate paper results:

| Folder | Description | Time |
|--------|-------------|------|
| `1_Sensitivity_Analysis/` | Morris method sensitivity analysis | ~10 sec |
| `2_Genetic_Algorithm/` | GA optimization across 4 environments | ~30 sec |
| `3_Similarity_Analysis/` | Ideotype-cultivar similarity | ~20 sec |

Each folder contains `replicate_results/` (fast) and `run_from_scratch/` (requires DSSAT) options.

---

### Legacy Code Structure

#### 1. Environment Characterization
- **Main Code**: `MAIN_CLUSTER.m`
- **Functions**: `SOILcluster.m`, `CLIMcluster.m`, `graphicENVIRONMENTS.m`
- **Output**: `Results/CLIM_CLUSTER_GMM`, `Results/SOIL_CLUSTER_GMM`, `Results/SOIL(1-2-3)`

#### 1_. Environment Representation - Convex Hull
- **Main Code**: `MAIN1_Environment_representation.m`
- **Functions**: `convhullMAP.m`, `POPULATION_READ.m`, `graphicENVIRONMENTS.m`
- **Output**: `Results/Environment`

#### 2. Sensitivity Analysis
- **Main Code**: `MAIN_sensitivity.m`
- **Functions**: `sensitivity.m`, `MECHANISTIC.m`, `SENgraph2.m`, `generateRSITable.m`
- **Output**: `RelativeSensitivityIndex.xlsx`

#### 3. Genetic Algorithm Optimization - Ideotype Design
- **Main Code**: `MAIN_2.m`
- **Functions**: `Pop_ini.m`, `eval_fitness_csm.m`, `CERES_Rice.m`, `Select_parents.m`, `Crossover_parents.m`, `Mutation.m`, `Visual_Ind.m`
- **Output**: `Ideotype.xlsx`

#### 4. Ideotype Similarity Analysis
- **Main Code**: `MAIN_2_INTEGRATE.m`
- **Functions**: `POPULATION_READ.m`, `Visual_Ind2.m`
- **Output**: `Results/Genotypic_similarity_with_progeny`

#### 4_. Ideotype Visualization - "HI-WUE" Analysis
- **Main Code**: `MAIN_2RESULTS.m`
- **Output**: `Results/Regressor`

#### GA Optimization for Model Calibration
- **Main Code**: `MAIN_GA.m`
- **Functions**: `Pop_ini.m`, `eval_fitness_csm.m`, `CERES_Rice.m`, `Select_parents.m`, `Crossover_parents.m`, `Mutation.m`, `Visual_Ind.m`
- **Output**: `AG3.mat (AG3.ind_best)`, `Results/`

---

## Data Availability

- **Code**: This repository (CC BY 4.0)
- **Data**: [Zenodo DOI pending]

DB → https://drive.google.com/drive/folders/1FMZphGQxX_SC0YSaqXBsj5B0FJr4Vhov?hl=fr

---

## Notes

- All outputs are organized inside the `Results/` folder.
- Ensure that required toolboxes for clustering, optimization, and statistics are available in MATLAB 2024b.
- For any environment-specific data inputs (climate or soil), please follow the provided input data format guidelines.

---

## License

This work is licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

## Contact

**Edgar S. Correa**  
Pontificia Universidad Javeriana  
Email: e_correa@javeriana.edu.co  
GitHub: [@EdgarStevenC](https://github.com/EdgarStevenC)
