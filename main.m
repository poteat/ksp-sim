   
function main

    clear all
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
        TI = 100E3; % height of initial gravity turn
        TF = 45E3; % height of end gravity turn
        TS = .33; % turn shape
        AF = 0; % final angle
        OT = 75E3; % orbital height target
    global TARGET
    TARGET = [TI,TF,TS,AF,OT];
    
    vertical_ascent_options = odeset('Events',@vertical_ascent_events,...
                                     'NonNegative',5); % mass > 0
                                 
    vertical_ascent_init = [0, R, RS, 0, MI];

    [vertical_ascent_time,...
        vertical_ascent_states,...
        vertical_ascent_event_time,...
        vertical_ascent_event_state,...
        vertical_ascent_event_type] = ode45(@vertical_ascent, [0 1000],...
                                             vertical_ascent_init,...
                                             vertical_ascent_options);

    if (numel(vertical_ascent_event_type)~=0)
        switch vertical_ascent_event_type(1)
            case 1
                fprintf('Success, vertical ascent height reached\n');
            case 2
                fprintf('Out of fuel\n');
            case 3
                fprintf('Surface collision\n');
            case 4
                fprintf('Atmosphere exited\n');
        end
    else
        fprintf('Simulation timed out\n');
    end
    
    t = vertical_ascent_time;
    
    x  = vertical_ascent_states(:,1);
    y  = vertical_ascent_states(:,2);
    vx = vertical_ascent_states(:,3);
    vy = vertical_ascent_states(:,4);
    m  = vertical_ascent_states(:,5);
    p = [x,y];
    d = hypot(x,y);
    h = d-R;
    s = hypot(vx,vy);
    v = [vx,vy];
    pvang = acosd(dot(v,p,2)./(s.*d));
    hv = s.*cosd(pvang);
    tv = s.*sind(pvang);
    
    ex =  vertical_ascent_event_state(1);
    ey =  vertical_ascent_event_state(2);
    evx = vertical_ascent_event_state(3);
    evy = vertical_ascent_event_state(4);
    em =  vertical_ascent_event_state(5);
    
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
    plot(x,y)
    rectangle('Position',[ -R, - R, R*2, R*2],...
              'Curvature',[1,1])
    hold off
    axis square
    axis([-7e5, 7e5, -7e5, 7e5])
    title('Ascent trajectory')
    
end