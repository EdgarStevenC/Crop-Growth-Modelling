# 2. Genetic Algorithm Optimization

Genetic algorithm optimization for CERES-Rice ideotype identification across four contrasting environments.

## Quick Start

### Option A: Replicate Paper Results (Fast ~30 seconds)
```matlab
cd replicate_results
main_replicate_results
```
Uses pre-computed results (40 generations × 4 environments) to generate:
- Figure 7: Phenotypic landscape
- Figure S1: Convergence trajectories
- Table S2: Correlation statistics
- Table S3: Optimal genetic coefficients

### Option B: Run From Scratch (Slow ~4-8 hours per environment)
```matlab
cd run_from_scratch
main_run_optimization
```
Executes complete GA optimization. Requires DSSAT v4.8 installation.

**Note:** Change `ENV` variable (line 44) to select environment (1, 2, 3, or 4).

## GA Configuration

| Parameter | Value | Description |
|-----------|-------|-------------|
| Generations | 40 | Maximum iterations |
| Population | 15 | Individuals per generation |
| Mutation rate | 70% | Probability of mutation |
| Selection | Tournament | Parent selection method |
| Crossover | Single-point | Recombination operator |
| Elitism | Yes | Best individual preserved |

## Fitness Function
```
Fitness = HI + WUE_norm

where:
  HI = Harvest Index (dimensionless, 0-1)
  WUE_norm = (WUE - 2) / (15 - 2)
  WUE = Water Use Efficiency (kg ha⁻¹ mm⁻¹)
```

Normalization range (2-15 kg ha⁻¹ mm⁻¹) based on aerobic rice literature.

## Genetic Coefficients Optimized

| Parameter | Range | Description |
|-----------|-------|-------------|
| P1 | 150-800 GDD | Vegetative phase duration |
| P2R | 5-300 GDD | Photoperiod sensitivity |
| P5 | 150-850 GDD | Grain filling duration |
| P2O | 11-13 h | Critical photoperiod |
| G1 | 50-75 | Spikelet number coefficient |
| G2 | 0.015-0.030 g | Single grain weight |
| G3 | 0.7-1.3 | Tillering coefficient |
| PHINT | 55-90 GDD | Phyllochron interval |

## Environments

| Environment | Folder | Precipitation | Soil (SDUL) | Area Coverage |
|-------------|--------|---------------|-------------|---------------|
| 1 | 1. IND_761/ | 815 mm | 0.30 cm³/cm³ | 30% |
| 2 | 2. IND_846/ | 540 mm | 0.28 cm³/cm³ | 27% |
| 3 | 3. IND_256/ | 815 mm | 0.25 cm³/cm³ | 11% |
| 4 | 4. IND_686/ | 540 mm | 0.23 cm³/cm³ | 21% |

## Outputs

### Figures
- `GA_Results_4Environments.png/pdf/fig` - Figure 7 (phenotypic landscape)
- `GA_Convergence_ENV[1-4].png/pdf/fig` - Figure S1 (convergence)

### Tables
- `Table_S2_Correlation_Statistics.csv` - R² and p-values
- `Table_S3_Optimal_Coefficients.csv` - Best genetic coefficients per environment

### Data
- `Ideotype.xlsx` - All evaluated individuals (5,364 virtual cultivars)
- `Ideotype_ALL.mat` - MATLAB data file
- `AG_ENV[1-4].mat` - Complete optimization results per environment

## Key Results

| Environment | Convergence | Best Fitness | Strategy |
|-------------|-------------|--------------|----------|
| 1 | Gen 23 | 1.01 | Extended growth (116 days) |
| 2 | Gen 20 | 0.98 | Drought escape (103 days) |
| 3 | Gen 10 | 0.99 | Drought escape (100 days) |
| 4 | Gen 20 | 0.97 | Drought escape (100 days) |

## Required Functions

For `run_from_scratch`:
- `Pop_ini.m` - Initialize population
- `eval_fitness_csm.m` - Evaluate fitness via CERES-Rice
- `Select_parents.m` - Tournament selection
- `Crossover_parents.m` - Single-point crossover
- `Mutation.m` - Random mutation
- `Visual_Ind.m` - Visualization

## Reference

Correa, E.S. (2025). Decoding Living Systems: Reassessing Crop Model Frontiers via Biological Dynamics and Optimized Phenotype. *PLOS ONE*.