

for RunNumber = [3692721:3692723]
    
    if isunix
        Pat = '../../runs/';
    else
        Pat = '..\..\runs\';
    end
    
    SimulationStartingDay = 12;
    SimulationDurationInQuarters = 100;
    
    SimulationDay_final = SimulationStartingDay + SimulationDurationInQuarters*3*20;
    
    fprintf('\r Deleting RunNumber: %d',RunNumber)
    
    ii = 0;
    quarter = 0;
    for d = (SimulationStartingDay):(SimulationDay_final)
        
        Filename = ['ICEACE_run', num2str(RunNumber), '_day', num2str(d), '.mat'];
        delete([Pat, Filename])
    end
  
    
end