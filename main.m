function dv = main(TWR,TI,TF,TS)
    
    global DEBUG % Enables or disables debug output
    global engine % Global part data (input)
    global STAGE % Global stage data (output)
    part_data();
    
    DEBUG = 0;
    
    G = 9.82;
    
    
    E(1) = engine(8); % One engine only
    
    T = sum(cat(1,E.T));
    
    MI = T/(TWR*G);
    
    M_fuel = (9/10)*(MI - sum(cat(1,E.M)));
    
    MF = MI - M_fuel;

    
    STAGE(1).MI = 18.175;
    STAGE(1).MF = 3.175;
    STAGE(1).E = E;
    
    dv = simulate(TI,TF,TS,0);
end