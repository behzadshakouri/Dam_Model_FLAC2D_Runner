function archiveRunFiles(cfg, runFolder, filesToArchive, runId, modeName, logFile)
%ARCHIVERUNFILES Move/copy FLAC outputs from the working folder to run folder.
if isfolder(runFolder)
    if cfg.OverwriteExistingRunFolders
        rmdir(runFolder, 's');
    end
end
ensureFolder(runFolder);

for n = 1:numel(filesToArchive)
    name = filesToArchive{n};
    src = fullfile(cfg.FlacBase, name);
    if ~isfile(src)
        continue;
    end

    [~, baseName, ext] = fileparts(name);
    dstName = name;

    % Make the main model files realization-specific while avoiding Dam_Dam.
    if strcmpi(name, [cfg.ModelPrefix '.dat'])
        dstName = sprintf('%s_%d.dat', cfg.ModelPrefix, runId);
    elseif strcmpi(name, [cfg.ModelPrefix '.prj'])
        dstName = sprintf('%s_%d.prj', cfg.ModelPrefix, runId);
    elseif strcmpi(name, [cfg.ModelPrefix '_FoS.dat'])
        dstName = sprintf('%s_%d_FoS.dat', cfg.ModelPrefix, runId);
    elseif strcmpi(ext, '.fis') && startsWith(baseName, 'RVs', 'IgnoreCase', true)
        dstName = sprintf('RVs%d.fis', runId);
    end

    dst = fullfile(runFolder, dstName);
    try
        movefile(src, dst, 'f');
    catch
        copyfile(src, dst, 'f');
    end
end

logger(logFile, 'Archived %s run to: %s', modeName, runFolder);
end
