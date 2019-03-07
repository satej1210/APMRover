function [] = myStopFcnExperiment(xAct,yAct)

figure
plot(yAct.signals.values(:,1),xAct.signals.values(:,1),'b-')
legend('Actual Path')
grid
axis equal
vAxis = axis;
lengthX = vAxis(2) - vAxis(1);
lengthY = vAxis(4) - vAxis(3);
axis([vAxis(1)-0.1*lengthX vAxis(2)+0.1*lengthX vAxis(3)-0.1*lengthY vAxis(4)+0.1*lengthY])
