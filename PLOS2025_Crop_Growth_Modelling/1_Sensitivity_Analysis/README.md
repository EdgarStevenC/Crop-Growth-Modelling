# 1. Sensitivity Analysis

Morris method sensitivity analysis for CERES-Rice genetic coefficients.

## Quick Start

### Option A: Replicate Paper Results (Fast ~10 seconds)
```matlab
cd replicate_results
main_replicate_results
```
Uses pre-computed results to generate Figure 6 and Table S1.

### Option B: Run From Scratch (Slow ~4-8 hours)
```matlab
cd run_from_scratch
main_run_sensitivity
```
Executes complete Morris analysis. Requires DSSAT v4.8 installation.

## Morris Design Parameters

| Parameter | Value | Description |
|-----------|-------|-------------|
| k | 11 | Number of genetic coefficients |
| p | 4 | Number of levels per parameter |
| r | 20 | Number of replications |
| Evaluations | 240 | Per replication (r × (k+1)) |

## Genetic Coefficients Analyzed

**Phenological:** P1, P2O, P2R, P5  
**Reproductive:** G1, G2, G3, PHINT  
**Thermal:** THOT, TCLDP, TCLDF

## Outputs

- `sensitivity_stats.mat`: RSI statistics with 95% CI
- `RESULTS/Sensitivity_All_6panels.png`: Figure 6 (300 dpi)
- `RESULTS/Sensitivity_All_6panels.pdf`: Vector format

## Configuration Required

Before running `main_run_sensitivity.m`, update the R path in `functions/MECHANISTIC.m` (line 160):
```matlab
% Change this line to match your local installation:
[status,cmdout] = system('"C:\Program Files\R\R-4.4.2\bin\R.exe" CMD BATCH "YOUR_PATH\RdssatMATLAB21-2.R"');
```

**Example paths:**
- Windows: `"C:\Program Files\R\R-4.4.2\bin\R.exe"`


## Reference

Morris, M.D. (1991). Factorial sampling plans for preliminary computational experiments. *Technometrics*, 33(2), 161-174.