%SETUP_EXAMPLE_PROJECT Create a minimal local project structure.
% Run this once after downloading the repository, then copy/edit your own
% project-specific Dam.prj, flac.ini, RVs.xlsx, and RVs*.fis files.

repoRoot = fileparts(fileparts(mfilename('fullpath')));
projectRoot = 'D:\Flac_project';

mkdir(projectRoot);
mkdir(fullfile(projectRoot, 'Samples'));
mkdir(fullfile(projectRoot, 'RVs_fis'));
mkdir(fullfile(projectRoot, 'Templates'));
mkdir(fullfile(projectRoot, 'Models'));
mkdir(fullfile(projectRoot, 'Logs'));

copyfile(fullfile(repoRoot, 'flac_templates', 'Dam.dat'), fullfile(projectRoot, 'Templates', 'Dam.dat'), 'f');
copyfile(fullfile(repoRoot, 'flac_templates', 'Dam_FoS.dat'), fullfile(projectRoot, 'Templates', 'Dam_FoS.dat'), 'f');
copyfile(fullfile(repoRoot, 'flac_templates', 'fis', '*.fis'), fullfile(projectRoot, 'Templates'), 'f');
copyfile(fullfile(repoRoot, 'flac_templates', 'history', '*.his'), fullfile(projectRoot, 'Templates'), 'f');

fprintf('Created example project folder: %s\n', projectRoot);
fprintf('Next: add Dam.prj, flac.ini, Samples/RVs.xlsx, and RVs_fis/RVs1.fis etc.\n');
