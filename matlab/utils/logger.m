function logger(logFile, fmt, varargin)
%LOGGER Print message to command window and append to log file.
msg = sprintf(fmt, varargin{:});
stamp = datestr(now, 'yyyy-mm-dd HH:MM:SS');
line = sprintf('[%s] %s', stamp, msg);
fprintf('%s\n', line);
[fid, err] = fopen(logFile, 'a');
if fid < 0
    warning('Could not open log file: %s', err);
    return;
end
fprintf(fid, '%s\n', line);
fclose(fid);
end
