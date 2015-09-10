function dv = main(TWR,TI,TF,TS)
    
    global DEBUG % Enables or disables debug output
    global engine sas % Global part data (input)
    global STAGE % Global stage data (output)
    part_data();
    
    DEBUG = 0;
    
    G = 9.82;
    
    E = engine(8);
    E(2) = engine(8);
    E(3) = engine(8);
    SAS = sas(2);
    
    T = sum(cat(1,E.T));
    
    MI = T/(TWR*G);
    
    M_fuel = (9/10)*(MI - sum(cat(1,E.M)) - SAS.M);
    
    MF = MI - M_fuel;
    
    
    STAGE(1).MI = MI;
    STAGE(1).MF = MF;
    STAGE(1).E = E;
    
    dv = simulate(TI,TF,TS,0);
end