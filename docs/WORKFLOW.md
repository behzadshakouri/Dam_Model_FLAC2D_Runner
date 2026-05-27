# Workflow

## Static analysis

1. Read realization IDs from `RunIndices`, `r.xlsx`, or `Samples/RVs.xlsx`.
2. Copy generic templates and support files into the FLAC working directory.
3. Create a realization-specific `Dam.dat` by replacing `RV_PLACEHOLDER.fis` with `RVs<i>.fis`.
4. Start `FLAC810_64.exe`.
5. Wait until the configured completion file appears, by default `watermech_t_sxx,syy.dat`.
6. Stop FLAC and archive outputs to `Models/Dam_<i>`.

## FoS analysis

1. Read the archived static save file from `Models/Dam_<i>/9lc_watermech_t.sav`.
2. Copy FoS template and save file to the FLAC working directory.
3. Start FLAC.
4. Wait until `9lc_fos.sav` appears.
5. Archive FoS outputs back into `Models/Dam_<i>`.
