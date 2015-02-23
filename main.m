function dv = main(TWR,TI,TF,TS)
    
    global engine sas % Global part data (input)
    global STAGE % Global stage data (output)
    part_data();
    
    G = 9.82;
    
    E = engine(13);
    E(2) = engine(13);
    E(3) = engine(13);
    SAS = sas(2);
    
    T = sum(cat(1,E.T));
    
    MI = T/(TWR*G);
    
    M_fuel = (9/10)*(MI - sum(cat(1,E.M)) - SAS.M);
    
    MF = MI - M_fuel;
    
    
    STAGE(1).MI = MI;
    STAGE(1).MF = MF;
    STAGE(1).E = E;
    
    dv = simulate(TI,TF,TS,0);
    
    numel(STAGE)
    
end