# Dam_Model_FLAC2D_Runner

## About

Generic MATLAB–FLAC2D automation framework for dam modeling, uncertainty analysis, and factor-of-safety (FoS) simulations.

This repository provides a reusable workflow for running large batches of FLAC2D simulations using MATLAB automation scripts and FISH utilities. The framework was generalized from research-scale dam simulations and refactored to remove project-specific dependencies and hardcoded paths.

---

## Features

- MATLAB automation for FLAC2D simulations
- Batch processing of random-variable realizations
- Generic FLAC2D project structure
- Static simulation workflow
- Factor-of-Safety (FoS) workflow
- Automated result archiving
- FISH utility integration
- Reusable folder structure
- GitHub-ready organization

---

## Repository Structure

```text
dam_model_flac2d_runner/
│
├── matlab/
│   ├── run_static_models.m
│   ├── run_fos_models.m
│   └── utils/
│       └── fileRename.m
│
├── flac_templates/
│   ├── Dam.dat
│   ├── Dam_FoS.dat
│   ├── history/
│   │   ├── dam_motion.his
│   │   └── dam_motion_raw.his
│   └── fis/
│       ├── material_properties.fis
│       ├── RVs_calc.fis
│       ├── RV_template.fis
│       ├── initialization.fis
│       ├── initial_inverse.fis
│       └── tabtofile.fis
│
├── examples/
│
├── docs/
│
├── .gitignore
├── LICENSE
├── CITATION.cff
└── README.md
```

---

## Requirements

### Software

- MATLAB
- FLAC2D / FLAC 8.x
- Windows environment

### Tested With

- MATLAB R2021+
- FLAC 8.1

---

## Configuration

The framework uses a generic project root:

```text
D:\Flac_project
```

Example directory structure:

```text
D:\Flac_project\
│
├── Samples\
├── RVs_fis\
├── Models\
├── Outputs\
└── Templates\
```

Update paths in the MATLAB runner scripts as needed.

---

## Workflows

### 1. Static Simulations

Run batch FLAC2D static analyses using randomized parameter sets:

```matlab
run_static_models
```

Main steps:
1. Read random variables
2. Prepare FLAC2D input files
3. Launch FLAC2D
4. Wait for completion
5. Archive outputs

---

### 2. Factor-of-Safety (FoS) Simulations

Run FoS analyses using previously generated model states:

```matlab
run_fos_models
```

Main steps:
1. Load saved model state
2. Launch FoS simulation
3. Save FoS outputs
4. Archive results

---

## Random Variable Workflow

The framework supports Monte Carlo / uncertainty-analysis workflows through:
- MATLAB preprocessing
- FISH parameter injection
- Automated realization handling

Typical workflow:
1. Generate random-variable samples
2. Export realization-specific FISH files
3. Execute FLAC2D runs
4. Collect outputs for post-processing

---

## Notes

- FLAC2D executable paths may differ by installation.
- Large output files are intentionally excluded via `.gitignore`.
- This repository focuses on workflow automation rather than a specific dam case study.

---

## Future Extensions

Potential future developments:
- Dynamic earthquake simulations
- Parallel execution
- Surrogate-model coupling
- Machine-learning integration
- Reliability analysis
- Automatic post-processing
- HPC support

---

## Citation

If you use this framework in academic work, please cite the repository and associated publications using the included `CITATION.cff`.

Shakouri, B., Mohammadi, M., Safari, M. J. S., & Hariri-Ardebili, M. A. (2023). A collaborative numerical simulation-soft computing approach for earth dams first impoundment modeling. Computers and Geotechnics, 164, 105814. https://doi.org/10.1016/j.compgeo.2023.105814

Shakouri, B., Mohammadi, M., Safari, M. J. S., & Hariri-Ardebili, M. A. (2022). First Impoundment Response Analysis of an Earth Dam using Coupled Numerical-Soft Computing technique. In IWA World Water Congress & Exhibition.

Shakouri, B., Mohammadi, M., & Safari, M. J. S. (2024). Sensitivity analysis for uncertainty quantification in earth dams modeling (Case study: Maku dam). Water and Irrigation Management, 14(1), 75–90. https://doi.org/10.22059/jwim.2023.360452.1084

### Google Scholar records

- [A collaborative numerical simulation-soft computing approach for earth dams first impoundment modeling](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=0lTtuMoAAAAJ&citation_for_view=0lTtuMoAAAAJ:qxL8FJ1GzNcC)
- [First Impoundment Response Analysis of an Earth Dam using Coupled Numerical-Soft Computing technique](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=0lTtuMoAAAAJ&citation_for_view=0lTtuMoAAAAJ:_kc_bZDykSQC)
- [Sensitivity analysis for uncertainty quantification in earth dams modeling (Case study: Maku dam)](https://scholar.google.com/citations?view_op=view_citation&hl=en&user=0lTtuMoAAAAJ&citation_for_view=0lTtuMoAAAAJ:mVmsd5A6BfQC)

### Related reproducibility software

For the paper-specific first-impoundment and seismic-response surrogate-modeling workflows, reference metrics, tests, and reproducibility records, see and cite:

Shakouri, B. (2026). *EarthDam-FLAC2D-SoftComputing* (Version 1.0.0) [Computer software]. GitHub. https://github.com/behzadshakouri/EarthDam-FLAC2D-SoftComputing

---

## License

This project is distributed under the MIT License unless otherwise specified.

---

## Author

Behzad Shakouri  
Postdoctoral Research Associate  
Department of Civil & Environmental Engineering  
The Catholic University of America
