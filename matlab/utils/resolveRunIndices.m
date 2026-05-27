function runIds = resolveRunIndices(cfg)
%RESOLVERUNINDICES Determine realization IDs to run.
if ~isempty(cfg.RunIndices)
    runIds = cfg.RunIndices(:)';
    return;
end

if isfile(cfg.SelectionFile)
    r = readmatrix(cfg.SelectionFile);
    runIds = r(:)';
    runIds = runIds(~isnan(runIds));
    return;
end

if isfile(cfg.RVsFile)
    RVs = readmatrix(cfg.RVsFile); %#ok<NASGU>
    runIds = 1:size(readmatrix(cfg.RVsFile), 1);
    return;
end

error('Cannot determine run indices. Provide RunIndices or add Samples/RVs.xlsx.');
end
