function [X,Y] = setupDataLSTM(filename,chunkSize,numFeatures)
% setup data for LSTM training
    S = load(filename);
    nSamples = length(S.Y);
    nElems = floor(nSamples/chunkSize);
    X = cell(nElems+1,1);
    Y = cell(nElems+1,1);

    for ii = 1:nElems
        idxStart = 1+(ii-1)*chunkSize;
        idxEnd = ii*chunkSize;
        X{ii} = S.X(1:numFeatures,idxStart:idxEnd);
        Y{ii} = S.Y(idxStart:idxEnd);
    end
    X{end} = S.X(1:numFeatures,idxEnd+1:end);
    Y{end} = S.Y(idxEnd+1:end);

end
