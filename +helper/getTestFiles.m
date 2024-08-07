function testFiles = getTestFiles(dataFolder,stages)
testFiles = {};
for ii = 1:numel(stages)
    fileInfo = dir(fullfile(dataFolder,stages(ii),"*.mat"));
    testFiles = [testFiles,{fileInfo.name}];
end
end