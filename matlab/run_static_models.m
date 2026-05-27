function run_static_models(varargin)
%RUN_STATIC_MODELS Run static FLAC2D dam realizations from MATLAB.
%
% Example:
%   run_static_models('ProjectRoot','D:\Flac_project', 'RunIndices', 1:10)
%
% The FLAC data template must contain the token RV_PLACEHOLDER.fis. For each
% realization, the runner replaces this token with RVs<i>.fis.

cfg = configureDamFlacRunner(varargin{:});
ensureFolder(cfg.ModelsDir);
ensureFolder(cfg.LogDir);

validateProjectStructure(cfg, 'static');
runIds = resolveRunIndices(cfg);

logFile = fullfile(cfg.LogDir, ['static_run_' datestr(now,'yyyymmdd_HHMMSS') '.log']);
logger(logFile, 'Starting static FLAC2D dam runs.');
logger(logFile, 'ProjectRoot: %s', cfg.ProjectRoot);
logger(logFile, 'Number of runs: %d', numel(runIds));

for k = 1:numel(runIds)
    runId = runIds(k);
    runName = sprintf('%s_%d', cfg.ModelPrefix, runId);
    runFolder = fullfile(cfg.ModelsDir, runName);

    logger(logFile, '[%d/%d] Preparing %s', k, numel(runIds), runName);
    prepareStaticWorkingDirectory(cfg, runId);

    logger(logFile, '[%d/%d] Running FLAC for %s', k, numel(runIds), runName);
    runFlacAndWait(cfg, cfg.StaticDoneFile, logFile);

    logger(logFile, '[%d/%d] Archiving %s', k, numel(runIds), runName);
    archiveRunFiles(cfg, runFolder, cfg.StaticFilesToArchive, runId, 'static', logFile);
end

logger(logFile, 'Completed static FLAC2D dam runs.');
end

function prepareStaticWorkingDirectory(cfg, runId)
cleanKnownWorkingFiles(cfg, [cfg.StaticFilesToArchive; {sprintf('RVs%d.fis',runId)}]);

copyIfExists(cfg.ProjectFile, cfg.FlacBase, true);
copyIfExists(cfg.FlacIniFile, cfg.FlacBase, true);
copyTemplateSupportFiles(cfg, cfg.FlacBase);

% Create realization-specific .dat file from generic template.
datText = fileread(cfg.StaticTemplateDat);
rvFile = sprintf('RVs%d.fis', runId);
datText = strrep(datText, 'RV_PLACEHOLDER.fis', rvFile);
writeTextFile(fullfile(cfg.FlacBase, [cfg.ModelPrefix '.dat']), datText);

% Copy realization-specific FISH file if available.
copyIfExists(fullfile(cfg.RVsFisDir, rvFile), cfg.FlacBase, true);
end

function copyTemplateSupportFiles(cfg, dst)
items = dir(cfg.TemplatesDir);
for n = 1:numel(items)
    if items(n).isdir, continue; end
    [~,~,ext] = fileparts(items(n).name);
    if ismember(lower(ext), {'.fis','.his','.ini'})
        copyIfExists(fullfile(cfg.TemplatesDir, items(n).name), dst, false);
    end
end
fisDir = fullfile(cfg.TemplatesDir, 'fis');
if isfolder(fisDir)
    items = dir(fullfile(fisDir, '*.fis'));
    for n = 1:numel(items)
        copyIfExists(fullfile(fisDir, items(n).name), dst, false);
    end
end
histDir = fullfile(cfg.TemplatesDir, 'history');
if isfolder(histDir)
    items = dir(fullfile(histDir, '*.his'));
    for n = 1:numel(items)
        copyIfExists(fullfile(histDir, items(n).name), dst, false);
    end
end
end
