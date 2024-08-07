function ds = prepareDatastore(X,Y)
% Setup in-memory datastore for interactive training
    ds = arrayDatastore([num2cell(X.',1).' ...
        num2cell(Y,2)],OutputType="same");
end