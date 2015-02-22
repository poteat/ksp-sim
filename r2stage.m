
function vacuum_deltav = r2stage(eng1,twr1,eng2,twr2)
    
global engine_names engine_thrusts engine_masses engine_atm_isps engine_vac_isps;

    G = 9.82;
    M_d = .05; % Mass of disconnector
    M_p = 5; % Mass of payload
   
    E1_T = engine_thrusts(eng1);
    E1_M = engine_masses(eng1);
    E1_Isp = engine_vac_isps(eng1);
    
    E2_T = engine_thrusts(eng2);
    E2_M = engine_masses(eng2);
    E2_Isp = engine_vac_isps(eng2);
    
    S1_MI = E1_T./(twr1*G);
    S2_MI = E2_T./(twr2*G);
    
    S1_M_fuel = 9/10 * (S1_MI - S2_MI - E1_M - M_d);
    S2_M_fuel = 9/10 * (S2_MI - E2_M - M_p);
    
    S1_MF = S1_MI - S1_M_fuel;
    S2_MF = S2_MI - S2_M_fuel;
    
    S1_deltav = E1_Isp*G*log(S1_MI./S1_MF);
    S2_deltav = E2_Isp*G*log(S2_MI./S2_MF);
    
    vacuum_deltav = S1_deltav+S2_deltav;
    
end