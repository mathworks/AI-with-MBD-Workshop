function [] = ProjectStartUp()
%PROJECTSTARTUP Summary of this function goes here
%   Detailed explanation goes here
[ installationIsValid, failureMessage ] =  helper.validateInstallation( );
if( true == installationIsValid )
    % Great.
    disp('You are all set')
else
    warning( failureMessage );
end
end

