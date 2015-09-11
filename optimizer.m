
launch = @(Z) -main(Z(1),Z(3),Z(4),Z(5));

result = fminsearch(launch,[1.5,1.5,30000,60000,.5])