   
function remaining_dv = main(in_TI,in_TF,in_TS,in_AF)
%% Variable Initialization

    % Single-stage rocket parameters
        T = 50; % thrust
        II = 300; % isp initial
        IF = 390; % isp final
        MI = 2.8; % mass initial
        MF = 0.8; % mass final
    global CRAFT
    CRAFT = [T,II,IF,MI,MF];
    
    % Planetary constants
        G = 9.82;
        R = 6E5; % radius of kerbin
        RS = 174.53; % rotation speed
        S = 3.5316E12; % standard gravitational parameter
    global PLANET
    PLANET = [G,R,RS,S];
    
    % Atmospheric constants
        D = 9.784758844E-4; % drag constant
        AH = 69077.553; % atmospheric height
        H = 5E3; % scale height
    global ATMOSPHERE
    ATMOSPHERE = [D,AH,H];
    
    % Orbital ascent parameters
        TI = in_TI;%10E3; % height of initial gravity turn
        TF = in_TF;%45E3; % height of end gravity turn
        TS = in_TS;%.3; % turn shape
        AF = in_AF;%0; % final angle
        OT = 70E3; % orbital height target
    global TARGET 
    TARGET = [TI,TF,TS,AF,OT];

    global STATE TIME EVENT
    STATE = [0,0,0,0,0];
    TIME = [0];
    EVENT = [0,0,0,0,0,0];
    
    range = [0 1000];
    
%% Vertical Ascent
        opt = odeset('Events',@vertical_ascent_events);
        ini = [0, R, RS, 0, MI];
        [t,Z,~,~,evt] = ode45(@vertical_ascent,range,ini,opt);
    merge_results(t,Z);
    
    if (numel(evt)~=0)
        switch evt(1)
            case 1
                fprintf('Success, vertical ascent height reached\n');
            case 2
                fprintf('Out of fuel\n');
                remaining_dv = 0;
                return
            case 3
                fprintf('Surface collision\n');
                remaining_dv = 0;
                return
            case 4
                fprintf('Atmosphere exited\n');
                remaining_dv = 0;
                return
        end
    else
        fprintf('Simulation timed out\n');
        remaining_dv = 0;
        return
    end
%% Gravity Turn
        opt = odeset('Events',@gravity_turn_events);          
        ini = Z(end,:);                          
        [t,Z,~,~,evt] = ode45(@gravity_turn,range,ini,opt);
    merge_results(t,Z);
    
    if (numel(evt)~=0)
        switch evt(1)
            case 1
                fprintf('Gravity turn height limit reached\n')
            case 2
                fprintf('Out of fuel\n')
                remaining_dv = 0;
                return
            case 3
                fprintf('Surface collision\n')
                remaining_dv = 0;
                return
            case 4
                fprintf('Atmosphere exited\n')
                remaining_dv = 0;
                return
            case 5
                fprintf('Height dropped below gravity turn zone')
                remaining_dv = 0;
                return
            case 6
                fprintf('Projected apoapsis reached\n')
        end
    else
        fprintf('Simulation timed out\n')
        remaining_dv = 0;
        return
    end
%% Coasting to Edge of Atmosphere
        opt = odeset('Events',@coast_events,'MaxStep',50);
        ini = Z(end,:);
        [t,Z,~,~,evt] = ode45(@coast,range,ini,opt);
    merge_results(t,Z);
    
    if (numel(evt)~=0)
        switch evt(1)
            case 1
                fprintf('Atmosphere exited (success)\n')
            case 2
                fprintf('Out of fuel\n')
                remaining_dv = 0;
                return
            case 3
                fprintf('Surface collision\n')
                remaining_dv = 0;
                return
            case 4
                fprintf('Height dropped into gravity turn zone')
                remaining_dv = 0;
                return
        end
    else
        fprintf('Simulation timed out\n')
        remaining_dv = 0;
        return
    end
%% Coast to Circularization Burn (Analytical)
    Z = STATE;
    x =  Z(end,1);
    y =  Z(end,2);
    vx = Z(end,3);
    vy = Z(end,4);
    m =  Z(end,5);
    
    p = [x,y,0];
    v = [vx,vy,0];
    d = norm(p);
    s = norm(v);
    
    eng = s^2/2-S/d;
    h = cross(p,v);
    e = norm(cross(v,h)/S-p/d);
    a = -S/(2*eng);
    
    apo = a*(1+e);
    
    cdv = sqrt(S/apo)*(1-sqrt(1-e));
    final_mass = m/exp(cdv/IF/G);
    
    remaining_dv = IF*G*log(final_mass/MF);
    
    
if 1
    
%% Results Analysis
    Z = STATE;
    t = TIME;
            
            
    x  = Z(:,1);
    y  = Z(:,2);
    vx = Z(:,3);
    vy = Z(:,4);
    m =  Z(:,5);
    
    p = [x,y];
    d = hypot(x,y);
    h = d-R;
    s = hypot(vx,vy);
    v = [vx,vy];
    pvang = acosd(dot(v,p,2)./(s.*d));
    hv = s.*cosd(pvang);
    tv = s.*sind(pvang);
    
    figure(1)
    plot(t, h);
    xlabel('Time (s)');
    ylabel('Height from surface (meters)');
    title('Ascent height over time');
    
    figure(2)
    plot(t,hv)
    xlabel('Time (s)')
    ylabel('Velocity (m/s)')
    title('Vertical velocity wrt surface over time')
    
    figure(3)
    plot(t,s)
    xlabel('Time (s)')
    ylabel('Speed (m/s)')
    title('Absolute speed over time')
    
    figure(4)
    plot(t,tv)
    xlabel('Time (s)')
    ylabel('Tangential velocity (m/s)')
    title('Tangential velocity wrt surface over time')
    
    figure(5)
    hold on
    clf
    plot(x,y)
    rectangle('Position',[ -R, - R, R*2, R*2],...
              'Curvature',[1,1])
    hold off
    axis square
    axis([-7e5, 7e5, -7e5, 7e5])
    title('Ascent trajectory')
    
    figure(6)
    plot(t,m)
    xlabel('Time (s)')
    ylabel('Mass of rocket (tons)')
    title('Mass of rocket versus time')
    
end
    
%% Subfunctions
    function merge_results(t,Z)
        if (numel(STATE) && numel(TIME))
            STATE = vertcat(STATE,Z(2:end,:));
            TIME = vertcat(TIME,t(2:end,:)+TIME(end));
            EVENT = vertcat(EVENT,horzcat(TIME(end),Z(end,:)));
            
        else
            STATE = Z;
            TIME = t;
            EVENT = horzcat(TIME(end),Z(end,:));
        end
    end
end