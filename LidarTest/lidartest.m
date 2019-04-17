sub = rossubscriber('/scan');

while 1
    scan = receive(sub);
    
    ranges = scan.Ranges;
    angles = linspace(0,2*pi,numel(ranges));
    scan2 = lidarScan(ranges,angles);
    plot(scan);
    minRange = 0.1;
    maxRange = 7;
    scan3 = removeInvalidData(scan2,'RangeLimits',[minRange maxRange]);
    clf
    plot(scan)
    
    %plot(scan,'MaximumRange',10)
    
end