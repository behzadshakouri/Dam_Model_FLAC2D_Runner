function cleanKnownWorkingFiles(cfg, names)
%CLEANKNOWNWORKINGFILES Remove stale files from the FLAC working directory.
for n = 1:numel(names)
    f = fullfile(cfg.FlacBase, names{n});
    if isfile(f)
        try
            delete(f);
        catch
        end
    end
end
end
