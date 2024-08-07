function [X,Y] = loadData(filename)
% Load data from .mat file.
S = load(filename);

if nargout == 1
    % return a table
    X = array2table([S.Y.' S.X.'], ...
        VariableNames=["SOC" "Voltage" "Current" ...
        "Temp." "Avg. volt." "Avg. curr."]);
else
    % return two arrays
    X = S.X.';
    Y = S.Y.';
end
end