
launch = @(Z) -main(Z(1),Z(2),Z(3),Z(4));

result = fminsearch(launch,[1.5,30000,60000,.5])