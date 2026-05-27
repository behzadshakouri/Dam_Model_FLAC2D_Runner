function copied = copyIfExists(src, dstFolder, required)
%COPYIFEXISTS Copy file if present; error when required and missing.
if nargin < 3
    required = false;
end
copied = false;
if isfile(src)
    if ~isfolder(dstFolder)
        mkdir(dstFolder);
    end
    copyfile(src, dstFolder, 'f');
    copied = true;
elseif required
    error('Required file not found: %s', src);
end
end
