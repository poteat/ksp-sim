function main
    
    global engine sas % Global part data (input)
    global STAGE % Global stage data (output)
    part_data();
    
    TWR = 1.1;
    G = 9.82;
    
    E = engine(8);
    SAS = sas(2);
    
    MI = E.T/(TWR*G);
    
    M_fuel = (9/10)*(MI - E.M - SAS.M);
    
    MF = MI - M_fuel;
    
    
    STAGE(1).MI = MI;
    STAGE(1).MF = MF;
    STAGE(1).E = E;
    
    simulate(10000,45000,.5,0);
    
end