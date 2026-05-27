function ensureFolder(folderPath)
%ENSUREFOLDER Create folder if it does not exist.
if ~isfolder(folderPath)
    mkdir(folderPath);
end
end
