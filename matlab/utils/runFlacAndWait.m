function runFlacAndWait(cfg, doneFile, logFile)
%RUNFLACANDWAIT Start FLAC and wait until a target output file appears.
oldDir = pwd;
cleanupObj = onCleanup(@() cd(oldDir));
cd(cfg.FlacBase);

if isfile(doneFile)
    delete(doneFile);
end

cmd = sprintf('start "" "%s"', fullfile(cfg.FlacBase, cfg.FlacExecutable));
[status, msg] = system(cmd);
if status ~= 0
    error('Failed to start FLAC executable: %s', msg);
end

tStart = tic;
while true
    if isfile(fullfile(cfg.FlacBase, doneFile))
        pause(1);
        break;
    end
    if toc(tStart) > cfg.MaxWaitSeconds
        error('Timed out waiting for FLAC output file: %s', doneFile);
    end
    pause(cfg.PollSeconds);
end

if cfg.KillAfterRun
    system(sprintf('taskkill /im %s /f', cfg.FlacExecutable));
    pause(1);
end

logger(logFile, 'Detected completion file: %s', doneFile);
end
