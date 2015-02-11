
global engine_names engine_thrusts engine_masses engine_atm_isps engine_vac_isps;

engine_names = ['LV-1 Liquid Fuel Engine'... % 1
    'Rockomax 48-7S'... % 2
    'LV-909 Liquid Fuel Engine'... % 3
    'LV-N Atomic Rocket Motor'... % 4
    'R.A.P.I.E.R. Engine'... % 5
    'Toroidal Aerospike Rocket'... % 6
    'LV-T45 Liquid Fuel Engine'... % 7
    'LV-T30 Liquid Fuel Engine'... % 8
    'Rockomax "Poodle" Liquid Engine'... % 9
    'Rockomax "Skipper" Liquid Engine'... % 10
    'Rockomax "Mainsail" Liquid Engine'... % 11
    'Kerbodyne KR-2L Advanced Engine'... % 12
    'S3 KS-25x4 Engine Cluster']; % 13

engine_thrusts = [4 30 50 60 175 175 200 215 220 650 1500 2500 3200];

engine_masses = [.03 .1 .5 2.25 1.2 1.5 1.5 1.25 2 3 6 6.5 9.75];

engine_atm_isps = [220 300 300 220 320 388 320 320 270 320 320 280 320];

engine_vac_isps = [290 350 390 800 360 390 370 370 390 370 360 380 360];

fuel_names = ['Kerbodyne S3-14400 Tank'...
    'Kerbodyne S3-7200 Tank'...
    'Rockomax Jumbo-64 Fuel Tank'...
    'Kerbodyne S3-3600 Tank'...
    'Rockomax X200-32 Fuel Tank'...
    'Rockomax X200-16 Fuel Tank'...
    'FL-T800 Fuel Tank'...
    'Rockomax X200-8 Fuel Tank'...
    'FL-T400 Fuel Tank'...
    'FL-T200 Fuel Tank'...
    'FL-T100 Fuel Tank'...
    'ROUND-8 Toroidal Fuel Tank'...
    'Oscar-B Fuel Tank'];

fuel_full_mass = [82 41 36 20.5 18 9 4.5 4.5 2.25 1.125 0.5625 0.136 0.078675];

fuel_empty_mass = [10 5 4 2.5 2 1 0.5 0.5 0.25 0.125 0.0625 0.025 0.015];

