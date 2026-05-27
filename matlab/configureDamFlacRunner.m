function cfg = configureDamFlacRunner(varargin)
%CONFIGUREDAMFLACRUNNER Configuration for the generic FLAC2D dam runner.
%
% The defaults intentionally avoid user-specific paths. Edit the values below
% or override them with name-value pairs, for example:
%
%   cfg = configureDamFlacRunner('ProjectRoot','D:\Flac_project');
%
% Expected project folder layout:
%   D:\Flac_project\Samples\RVs.xlsx
%   D:\Flac_project\RVs_fis\RVs1.fis, RVs2.fis, ...
%   D:\Flac_project\Templates\Dam.dat, Dam_FoS.dat, Dam.prj, flac.ini, ...
%   D:\Flac_project\Models\Dam_1, Dam_2, ...

p = inputParser;
p.FunctionName = mfilename;

addParameter(p, 'ProjectRoot', 'D:\Flac_project', @(x)ischar(x)||isstring(x));
addParameter(p, 'FlacBase', 'C:\Program Files\Itasca\FLAC810\exe64', @(x)ischar(x)||isstring(x));
addParameter(p, 'FlacExecutable', 'FLAC810_64.exe', @(x)ischar(x)||isstring(x));
addParameter(p, 'ModelPrefix', 'Dam', @(x)ischar(x)||isstring(x));
addParameter(p, 'RunIndices', [], @(x)isnumeric(x));
addParameter(p, 'PollSeconds', 10, @(x)isnumeric(x)&&isscalar(x)&&x>0);
addParameter(p, 'MaxWaitSeconds', Inf, @(x)isnumeric(x)&&isscalar(x)&&x>0);
addParameter(p, 'KillAfterRun', true, @(x)islogical(x)||ismember(x,[0 1]));
addParameter(p, 'OverwriteExistingRunFolders', false, @(x)islogical(x)||ismember(x,[0 1]));
addParameter(p, 'Verbose', true, @(x)islogical(x)||ismember(x,[0 1]));

parse(p, varargin{:});
cfg = p.Results;

cfg.ProjectRoot = char(cfg.ProjectRoot);
cfg.FlacBase = char(cfg.FlacBase);
cfg.FlacExecutable = char(cfg.FlacExecutable);
cfg.ModelPrefix = char(cfg.ModelPrefix);

cfg.SamplesDir = fullfile(cfg.ProjectRoot, 'Samples');
cfg.RVsFisDir  = fullfile(cfg.ProjectRoot, 'RVs_fis');
cfg.TemplatesDir = fullfile(cfg.ProjectRoot, 'Templates');
cfg.ModelsDir = fullfile(cfg.ProjectRoot, 'Models');
cfg.LogDir = fullfile(cfg.ProjectRoot, 'Logs');

cfg.RVsFile = fullfile(cfg.SamplesDir, 'RVs.xlsx');
cfg.SelectionFile = fullfile(cfg.ProjectRoot, 'r.xlsx');

cfg.StaticTemplateDat = fullfile(cfg.TemplatesDir, [cfg.ModelPrefix '.dat']);
cfg.FoSTemplateDat = fullfile(cfg.TemplatesDir, [cfg.ModelPrefix '_FoS.dat']);
cfg.ProjectFile = fullfile(cfg.TemplatesDir, [cfg.ModelPrefix '.prj']);
cfg.FlacIniFile = fullfile(cfg.TemplatesDir, 'flac.ini');

cfg.RequiredTemplateFiles = {
    [cfg.ModelPrefix '.dat']
    [cfg.ModelPrefix '_FoS.dat']
    [cfg.ModelPrefix '.prj']
    'flac.ini'
    'material_properties.fis'
    'RVs_calc.fis'
    'tabtofile.fis'
    'dam_motion.his'
    'initial_inverse.fis'
    'initialization.fis'
    };

cfg.StaticDoneFile = 'watermech_t_sxx,syy.dat';
cfg.FoSDoneFile = '9lc_fos.sav';
cfg.FoSInputSaveFile = '9lc_watermech_t.sav';

cfg.StaticFilesToArchive = {
    [cfg.ModelPrefix '.dat']
    [cfg.ModelPrefix '.prj']
    'material_properties.fis'
    'getting_static_outputs.fis'
    'tabtofile.fis'
    'RVs_calc.fis'
    'dam_motion.his'
    'initial_inverse.fis'
    'initialization.fis'
    'filter.fis'
    'baseline.fis'
    'strain_hist.fis'
    'reldispx.fis'
    'inipp.fis'
    'excpp.fis'
    'grid.sav'
    'initial.sav'
    '9lc_layer1.sav'
    '9lc_layer2.sav'
    '9lc_layer3.sav'
    '9lc_layer4.sav'
    '9lc_layer5.sav'
    '9lc_layer6.sav'
    '9lc_layer7.sav'
    '9lc_layer8.sav'
    '9lc_layer9.sav'
    '9lc_impound.sav'
    '9lc_watermech.sav'
    '9lc_watermech_t.sav'
    '9lc_getting_static_outputs.sav'
    'gp_i,j.dat'
    'watermech_xdisp,ydisp.dat'
    'zones_k,l.dat'
    'watermech_sxx,syy.dat'
    'watermech_t_xdisp,ydisp.dat'
    'watermech_t_sxx,syy.dat'
    };

cfg.FoSFilesToArchive = {
    [cfg.ModelPrefix '_FoS.dat']
    cfg.FoSInputSaveFile
    cfg.FoSDoneFile
    'FoSmode.fsv'
    };
end
