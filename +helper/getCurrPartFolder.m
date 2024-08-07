function partFolder = getCurrPartFolder(currPart)
    proj = currentProject;
    switch currPart
        case 'P1'
            partFolder = fullfile(proj.RootFolder,"Part_1_AI_modeling");
        case 'P2'
            partFolder = fullfile(proj.RootFolder,"Part_2_AI_import");
        case 'P3'
            partFolder = fullfile(proj.RootFolder,"Part_3_Code_Gen");
    end
end

