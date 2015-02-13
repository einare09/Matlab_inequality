

for RunNumber = SimulationRunPar.RunNumbers %[832069]
    
    if isunix
        Pat = '../../runs/';
    else
        Pat = '..\..\runs\';
    end
    
    SimulationStartingDay = 12;
    SimulationDurationInQuarters = Simulation.DurationInQuarters;
    
    SimulationDay_final = SimulationStartingDay + SimulationDurationInQuarters*3*4;
    
    fprintf('\r Deleting RunNumber: %d',RunNumber)
    
    ii = 0;
    quarter = 0;
    for d = (SimulationStartingDay):(SimulationDay_final)
        
        Filename = ['ICEACE_run', num2str(RunNumber), '_day', num2str(d), '.mat'];
        delete([Pat, Filename])
    end
  
    
end