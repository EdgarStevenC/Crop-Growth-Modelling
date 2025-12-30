# 3. Similarity Analysis

Genetic similarity analysis between optimized ideotypes and 21 field-validated cultivars.

## Quick Start
```matlab
main_similarity_analysis
```

Generates Figures 9-10 and similarity statistics.

## Required Input Files

| File | Description |
|------|-------------|
| `Ideotype.xlsx` | Optimized ideotypes from GA (generated in Step 2) |
| `CULTIVARS.csv` | 21 field-validated cultivars with genetic coefficients |

## Distance Metrics

Three distance metrics are computed and averaged for robust similarity:

| Metric | Description | Sensitivity |
|--------|-------------|-------------|
| Euclidean | Magnitude of differences | Overall distance |
| Manhattan | Sum of absolute differences | Outlier-robust |
| Cosine | Angular difference | Proportional patterns |

## Similarity Formula
```
Similarity = 1 - (d̄_ij / max(d̄)) × 100%

where:
  d̄_ij = average distance across all metrics
  max(d̄) = maximum distance in dataset (global normalization)
```

Higher values indicate greater similarity between ideotype and cultivar.

## Genetic Coefficients Compared

| Parameter | Description |
|-----------|-------------|
| P1 | Vegetative phase duration (GDD) |
| P5 | Grain filling duration (GDD) |
| P2R | Photoperiod sensitivity (GDD) |
| PHINT | Phyllochron interval (GDD) |
| P2O | Critical photoperiod (h) |
| G1 | Spikelet number coefficient |
| G2 | Single grain weight (g) |
| G3 | Tillering coefficient |

## Outputs

### Figures
- `Fig_Combined_Similarity.png/pdf/fig` - Figure 9 (PCA + Top matches)
- `Similarity_Heatmap.png/pdf/fig` - Figure 10 (Similarity matrix)
- `PCA_3D_Ideotypes_Cultivars.png/pdf/fig` - 3D PCA visualization
- `Similarity_TopMatches.png/pdf/fig` - Top cultivar matches per ideotype

### Tables
- `Similarity_Results.csv` - Top 5 matches per ideotype with similarity scores

## Key Results

### Global Best Matches

| Rank | Cultivar | Avg Similarity |
|------|----------|----------------|
| 1 | WAB56-50 | 70.7% |
| 2 | DKAP2 | 67.2% |
| 3 | NERICA17 | 66.6% |
| 4 | WABC165 | 64.1% |
| 5 | RD 23 | 63.4% |

### Genetic Gap

The 22-30% genetic gap between current cultivars and computational optima defines breeding priorities:
- **Large adjustment needed:** P1 (+29%), P2R (+56%), P5 (+21%)
- **Near-optimal:** G1 (+4%), G3 (+1%), P2O (+3%)

## Cultivar Database

21 field-validated cultivars from three genetic groups:
- **Indica:** NERICA1, NERICA4, NERICA6, NERICA8, NERICA11, NERICA12, NERICA14
- **Japonica:** WAB56-50, WAB189, WAB181, WABC165
- **Hybrid:** DKAP2, DKAP3, DKAP17, ITA150, RD 23, others

## Reference

Correa, E.S. (2025). Decoding Living Systems: Reassessing Crop Model Frontiers via Biological Dynamics and Optimized Phenotype. *PLOS ONE*.