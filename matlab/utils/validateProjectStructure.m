function validateProjectStructure(cfg, modeName)
%VALIDATEPROJECTSTRUCTURE Check required folders and files before running.
if ~isfolder(cfg.FlacBase)
    error('FLAC working folder not found: %s', cfg.FlacBase);
end
if ~isfolder(cfg.TemplatesDir)
    error('Templates folder not found: %s', cfg.TemplatesDir);
end
if strcmpi(modeName, 'static')
    mustExist = {cfg.StaticTemplateDat, cfg.ProjectFile, cfg.FlacIniFile};
else
    mustExist = {cfg.FoSTemplateDat, cfg.ProjectFile, cfg.FlacIniFile};
end
for n = 1:numel(mustExist)
    if ~isfile(mustExist{n})
        error('Required file not found: %s', mustExist{n});
    end
end
end
