
function part_data

    global engine decoupler sas
    
    engine(1).name = 'LV-1 Liquid Fuel Engine';
    engine(1).size = 'Tiny';
    engine(1).cost = 350;
    engine(1).M = .03;
    engine(1).T = 4;
    engine(1).II = 220;
    engine(1).IF = 290;
    
    engine(2).name = 'Rockomax 48-7S';
    engine(2).size = 'Tiny';
    engine(2).cost = 300;
    engine(2).M = .1;
    engine(2).T = 30;
    engine(2).II = 300;
    engine(2).IF = 350;

    engine(3).name = 'LV-909 Liquid Fuel Engine';
    engine(3).size = 'Small';
    engine(3).cost = 750;
    engine(3).M = .5;
    engine(3).T = 50;
    engine(3).II = 300;
    engine(3).IF = 390;
    
    engine(4).name = 'LV-N Atomic Rocket Motor';
    engine(4).size = 'Small';
    engine(4).cost = 8700;
    engine(4).M = 2.25;
    engine(4).T = 60;
    engine(4).II = 220;
    engine(4).IF = 800;
    
    engine(5).name = 'R.A.P.I.E.R. Engine';
    engine(5).size = 'Small';
    engine(5).cost = 3600;
    engine(5).M = 1.2;
    engine(5).T = 175;
    engine(5).II = 320;
    engine(5).IF = 360;
    
    engine(6).name = 'Toroidal Aerospike Rocket';
    engine(6).size = 'Small';
    engine(6).cost = 3850;
    engine(6).M =  1.5;
    engine(6).T = 175;
    engine(6).II = 388;
    engine(6).IF = 390;
    
    engine(7).name = 'LV-T45 Liquid Fuel Engine';
    engine(7).size = 'Small';
    engine(7).cost = 950;
    engine(7).M =  1.5;
    engine(7).T = 200;
    engine(7).II = 320;
    engine(7).IF = 370;
    
    engine(8).name = 'LV-T30 Liquid Fuel Engine';
    engine(8).size = 'Small';
    engine(8).cost = 850;
    engine(8).M = 1.25;
    engine(8).T = 215;
    engine(8).II = 320;
    engine(8).IF = 370;
    
    engine(9).name = 'Rockomax "Poodle" Liquid Engine';
    engine(9).size = 'Large';
    engine(9).cost = 1600;
    engine(9).M = 2;
    engine(9).T = 220;
    engine(9).II = 270;
    engine(9).IF = 390;
    
    engine(10).name = 'Rockomax "Skipper" Liquid Engine';
    engine(10).size = 'Large';
    engine(10).cost = 2850;
    engine(10).M =  3;
    engine(10).T = 650;
    engine(10).II = 320;
    engine(10).IF = 370;
    
    engine(11).name = 'Rockomax "Mainsail" Liquid Engine';
    engine(11).size = 'Large';
    engine(11).cost = 5650;
    engine(11).M =  6;
    engine(11).T = 1500;
    engine(11).II = 320;
    engine(11).IF = 360;
    
    engine(12).name = 'Kerbodyne KR-2L Advanced Engine';
    engine(12).size = 'Extra large';
    engine(12).cost = 20850;
    engine(12).M =  6.5;
    engine(12).T = 2500;
    engine(12).II = 280;
    engine(12).IF = 380;
    
    engine(13).name = 'S3 KS-25x4 Engine Cluster';
    engine(13).size = 'Extra large';
    engine(13).cost = 32400;
    engine(13).M =  9.75;
    engine(13).T = 3200;
    engine(13).II = 320;
    engine(13).IF = 360;
    
    decoupler(1).name = 'TT-38K Radial Decoupler';
    decoupler(1).size = 'Radial mounted';
    decoupler(1).cost = 600;
    decoupler(1).M = .025;
    decoupler(1).impulse = 2500;
    
    decoupler(2).name = 'Structural Pylon';
    decoupler(2).size = 'Radial mounted';
    decoupler(2).cost = 1275;
    decoupler(2).M = 0.2;
    decoupler(2).impulse = 2500;
    
    decoupler(3).name = 'TT-70 Radial Decoupler';
    decoupler(3).size = 'Radial mounted';
    decoupler(3).cost = 700;
    decoupler(3).M = 0.05;
    decoupler(3).impulse = 2500;
   
    decoupler(4).name = 'Hydraulic Detachment Manifold';
    decoupler(4).size = 'Radial mounted';
    decoupler(4).cost = 770;
    decoupler(4).M = 0.4;
    decoupler(4).impulse = 2500;
       
    decoupler(5).name = 'TR-2V Stack Decoupler';
    decoupler(5).size = 'Tiny';
    decoupler(5).cost = 200;
    decoupler(5).M = 0.015;
    decoupler(5).impulse = 2500;
       
    decoupler(6).name = 'TR-2C Stack Separator';
    decoupler(6).size = 'Tiny';
    decoupler(6).cost = 200;
    decoupler(6).M = 0.02;
    decoupler(6).impulse = 2500;
       
    decoupler(7).name = 'TR-18A Stack Decoupler';
    decoupler(7).size = 'Small';
    decoupler(7).cost = 975;
    decoupler(7).M = 0.05;
    decoupler(7).impulse = 2500;
       
    decoupler(8).name = 'TR-18D Stack Separator';
    decoupler(8).size = 'Small';
    decoupler(8).cost = 600;
    decoupler(8).M = 0.075;
    decoupler(8).impulse = 2500;
       
    decoupler(9).name = 'Rockomax Brand Decoupler';
    decoupler(9).size = 'Large';
    decoupler(9).cost = 200;
    decoupler(9).M = 0.4;
    decoupler(9).impulse = 2500;
       
    decoupler(10).name = 'TR-XL Stack Separator';
    decoupler(10).size = 'Large';
    decoupler(10).cost = 900;
    decoupler(10).M = .45;
    decoupler(10).impulse = 2500;
       
    decoupler(11).name = 'TR-38-D';
    decoupler(11).size = 'Extra large';
    decoupler(11).cost = 600;
    decoupler(11).M = .8;
    decoupler(11).impulse = 2500;
    
    sas(1).name = 'Small Inline Reaction Wheel';
    sas(1).size = 'Tiny';
    sas(1).cost = 600;
    sas(1).M = .05;
    sas(1).torque = 5;
    
    sas(2).name = 'Advanced Inline Stabilizer';
    sas(2).size = 'Small';
    sas(2).cost = 1200;
    sas(2).M = .1;
    sas(2).torque = 15;
    
    sas(3).name = 'Advanced S.A.S Module, Large';
    sas(3).size = 'Large';
    sas(3).cost = 2100;
    sas(3).M = .2;
    sas(3).torque = 30;
    
end