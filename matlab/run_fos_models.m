function run_fos_models(varargin)
%RUN_FOS_MODELS Run factor-of-safety FLAC2D dam analyses from static saves.
%
% Example:
%   run_fos_models('ProjectRoot','D:\Flac_project', 'RunIndices', 1:10)
%
% Each run expects the static-result folder Models\Dam_<i> to contain the save
% file specified by cfg.FoSInputSaveFile, usually 9lc_watermech_t.sav.

cfg = configureDamFlacRunner(varargin{:});
ensureFolder(cfg.ModelsDir);
ensureFolder(cfg.LogDir);

validateProjectStructure(cfg, 'fos');
runIds = resolveRunIndices(cfg);

logFile = fullfile(cfg.LogDir, ['fos_run_' datestr(now,'yyyymmdd_HHMMSS') '.log']);
logger(logFile, 'Starting FoS FLAC2D dam runs.');
logger(logFile, 'ProjectRoot: %s', cfg.ProjectRoot);
logger(logFile, 'Number of runs: %d', numel(runIds));

for k = 1:numel(runIds)
    runId = runIds(k);
    runName = sprintf('%s_%d', cfg.ModelPrefix, runId);
    runFolder = fullfile(cfg.ModelsDir, runName);
    inputSave = fullfile(runFolder, cfg.FoSInputSaveFile);

    if ~isfile(inputSave)
        logger(logFile, '[%d/%d] SKIP %s: missing %s', k, numel(runIds), runName, cfg.FoSInputSaveFile);
        continue;
    end

    logger(logFile, '[%d/%d] Preparing FoS for %s', k, numel(runIds), runName);
    prepareFoSWorkingDirectory(cfg, inputSave);

    logger(logFile, '[%d/%d] Running FLAC FoS for %s', k, numel(runIds), runName);
    runFlacAndWait(cfg, cfg.FoSDoneFile, logFile);

    logger(logFile, '[%d/%d] Archiving FoS for %s', k, numel(runIds), runName);
    archiveRunFiles(cfg, runFolder, cfg.FoSFilesToArchive, runId, 'fos', logFile);
end

logger(logFile, 'Completed FoS FLAC2D dam runs.');
end

function prepareFoSWorkingDirectory(cfg, inputSave)
cleanKnownWorkingFiles(cfg, cfg.FoSFilesToArchive);
copyIfExists(cfg.ProjectFile, cfg.FlacBase, true);
copyIfExists(cfg.FoSTemplateDat, cfg.FlacBase, true);
copyIfExists(cfg.FlacIniFile, cfg.FlacBase, true);
copyIfExists(inputSave, cfg.FlacBase, true);
end
