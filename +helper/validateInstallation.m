function [ installationIsValid, failureMessage ] =  validateInstallation( )

installationIsValid = true;
failureMessage = "";

%% Version:
[ versionValidity, versionFailureMessage ] = confirmMatlabVersion( );

if( true == versionValidity )
    % Don't add to the failure message.
else
    installationIsValid = false;
    failureMessage = versionFailureMessage;
end

%% Mex compiler:
[ mexCompilerValidity, mexFailureMessage ] = confirmMexCppCompiler( );

if( true == mexCompilerValidity )
    % Don't add to the failure message.
else
    installationIsValid = false;
    failureMessage = failureMessage + newline( ) + mexFailureMessage;
end

%% Product
[ allRequiredAddOnsAreInstalled, missingAddOnFailureMessage ] = ...
    confirmRequiredAddOnInstallation( );

if( true == allRequiredAddOnsAreInstalled )
    % Don't add to the failure message.
else
    installationIsValid = false;
    failureMessage = failureMessage + newline( ) + missingAddOnFailureMessage;
end

return;
end

function [ allRequiredAddOnsAreInstalled, missingAddOnFailureMessage ] = confirmRequiredAddOnInstallation( )

[ requiredProductNamesList ] = getRequiredProductNames( );

installedAddOnsTable = matlab.addons.installedAddons( );

requiredProductInstallationLogicalIndices = ....
    ismember( requiredProductNamesList, installedAddOnsTable.Name );

allRequiredAddOnsAreInstalled = ...
    all( requiredProductInstallationLogicalIndices, "all" );

if( true == allRequiredAddOnsAreInstalled )
    missingAddOnFailureMessage = "";
else
    missingProductLogicalIndices = ...
        ( ~requiredProductInstallationLogicalIndices );

    missingProductNamesList = ...
        requiredProductNamesList( missingProductLogicalIndices );

    missingAddOnFailureMessage = ...
        "The following products/AddOns are required, but not installed: " + strjoin( missingProductNamesList, ", " );
end

return;
end

function [ versionValidity, versionFailureMessage ] = confirmMatlabVersion( )
release = matlabRelease();
if( "R2024b" == release.Release )
    versionValidity = true;
    versionFailureMessage = "";
else
    versionValidity = false;
    versionFailureMessage = "Version R2024b is required.";
end
return
end

function [ mexCompilerValidity, mexFailureMessage ] = confirmMexCppCompiler( )

% There is more information in the compiler configuration, but it's not
% clear how strict we really want to be. If necessary, we could check which
% version of Visual Studio it is, but that might cause more trouble than
% good once we try to consider things like service packs.

cppCompilerConfiguration = mex.getCompilerConfigurations( "C++" );

if( true == isempty( cppCompilerConfiguration ) )
    mexCompilerValidity = false;
    mexFailureMessage = "There is no C++ '.mex' compiler configured.";
else
    if( "Microsoft" == cppCompilerConfiguration.Manufacturer )
        mexCompilerValidity = true;
        mexFailureMessage = "";
    elseif ("GNU" == cppCompilerConfiguration.Manufacturer )
        mexCompilerValidity = true;
        mexFailureMessage = "";
    else
        mexCompilerValidity = false;
        mexFailureMessage = "The C++ '.mex' compiler is not Microsoft nor GNU.";
    end
end
return;

end

function [ requiredProductNamesList ] = getRequiredProductNames( )

requiredProductNamesList = ...
    [ ...
    "Statistics and Machine Learning Toolbox"; ...
    "Deep Learning Toolbox"; ...
    % "Requirements Toolbox"; ...
    "MATLAB Report Generator"; ...
    % "MATLAB Test"; ...
    "MATLAB Coder"; ...
    "Embedded Coder"; ...
    "Simulink Coder"; ...
    % "Simulink Check"; ...
    % "Simulink Coverage"; ...
    % "Simulink Test"; ...
    % "Simulink Report Generator"; ...
    % "Stateflow";...
    % "Deep Learning Toolbox Verification Library"; ...
    "MATLAB Coder Interface for Deep Learning Libraries"; ...
    "Deep Learning Toolbox Converter for TensorFlow models"; ...
    "Deep Learning Toolbox Model Quantization Library"; ...
    ];

return;
end