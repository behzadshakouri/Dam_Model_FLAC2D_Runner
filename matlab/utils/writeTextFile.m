function writeTextFile(filePath, txt)
%WRITETEXTFILE Write character vector/string to text file.
[fid, err] = fopen(filePath, 'wt');
if fid < 0
    error('Could not open %s for writing: %s', filePath, err);
end
cleanupObj = onCleanup(@() fclose(fid)); %#ok<NASGU>
fprintf(fid, '%s\n', char(txt));
end
