# dam_model_flac2d_runner

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
│   ├── Dam.prj
│   ├── Dam.his
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

If you use this framework in academic work, please cite the repository using the included `CITATION.cff`.

---

## License

This project is distributed under the MIT License unless otherwise specified.

---

## Author

Behzad Shakouri  
Postdoctoral Research Associate  
Department of Civil & Environmental Engineering  
The Catholic University of America
