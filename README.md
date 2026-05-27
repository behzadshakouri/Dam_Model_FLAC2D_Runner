# dam_model_flac2d_runner

Generic MATLAB automation framework for running multiple FLAC2D dam realizations, archiving static results, and launching factor-of-safety (FoS) analyses from saved static states.

This repository was generalized from an older project-specific MATLAB→FLAC workflow. Project-specific names and hardcoded paths were removed so the workflow can be reused for other dam models.

## Main features

- MATLAB-controlled batch execution of FLAC2D models.
- Generic project root, defaulting to `D:\Flac_project`.
- Generic model prefix, defaulting to `Dam`.
- No duplicated names such as `Dam_Dam`; realization folders are `Dam_1`, `Dam_2`, etc.
- Static realization runner.
- FoS runner that starts from archived static save files.
- Logging for every run batch.
- Configurable FLAC executable path.
- Original legacy files retained in `legacy/` for traceability.

## Recommended project layout

```text
D:\Flac_project\
├── Samples\
│   └── RVs.xlsx
├── RVs_fis\
│   ├── RVs1.fis
│   ├── RVs2.fis
│   └── ...
├── Templates\
│   ├── Dam.dat
│   ├── Dam_FoS.dat
│   ├── Dam.prj
│   ├── flac.ini
│   ├── material_properties.fis
│   ├── RVs_calc.fis
│   ├── tabtofile.fis
│   ├── dam_motion.his
│   └── ...
├── Models\
│   ├── Dam_1\
│   ├── Dam_2\
│   └── ...
└── Logs\
```

## Quick start

1. Clone or download this repository.
2. In MATLAB, add the runner to your path:

```matlab
addpath(genpath('path\to\dam_model_flac2d_runner\matlab'));
```

3. Create the example structure:

```matlab
run('path\to\dam_model_flac2d_runner\examples\setup_example_project.m')
```

4. Copy your FLAC files into `D:\Flac_project\Templates`:

- `Dam.prj`
- `flac.ini`
- edited `Dam.dat`
- edited `Dam_FoS.dat`
- required `.fis` files
- required `.his` files

5. Run static realizations:

```matlab
run_static_models('ProjectRoot','D:\Flac_project', 'RunIndices', 1:10);
```

6. Run FoS analyses after static runs finish:

```matlab
run_fos_models('ProjectRoot','D:\Flac_project', 'RunIndices', 1:10);
```

## Configuration

All major paths and options are controlled by `matlab/configureDamFlacRunner.m`.

Example:

```matlab
cfg = configureDamFlacRunner( ...
    'ProjectRoot', 'D:\Flac_project', ...
    'FlacBase', 'C:\Program Files\Itasca\FLAC810\exe64', ...
    'ModelPrefix', 'Dam', ...
    'RunIndices', 1:50, ...
    'PollSeconds', 10);
```

## FLAC template token

The static data file `Dam.dat` should contain this token where the realization-specific FISH file is called:

```text
RV_PLACEHOLDER.fis
```

At runtime, MATLAB replaces it with:

```text
RVs1.fis, RVs2.fis, ...
```

## Notes

- This repository does not include a FLAC license or FLAC executable.
- Large generated outputs, save files, and result folders are ignored by Git by default.
- The included FLAC/FISH templates may still require project-specific calibration before use in a new dam model.

## Author

Behzad Shakouri

