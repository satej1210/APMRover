    rosinit;
    pwm_l_pub = rospublisher('/pwm_cmd_l', 'std_msgs/Int16');
    pwm_r_pub = rospublisher('/pwm_cmd_r', 'std_msgs/Int16');
    enco_pub = rospublisher('/enco_rst', 'std_msgs/Int16');
    heading = rossubscriber('/mavros/global_position/local', 'std_msgs/Int16');
    
    c = receive(heading);
    w = c.Pose.Pose.Orientation.W;
    x = heading.Pose.Pose.Orientation.X;
    y = heading.Pose.Pose.Orientation.Y;
    z = heading.Pose.Pose.Orientation.Z;
    rotm = quat2rotm([w x y z]);
    
    thetaIC = 1*double(rotm(3,3)) * pi/180;
    %scansub = rossubscriber('/scan');
    pause(1);
    %scan = receive(scansub);
    encorst = rosmessage(enco_pub);
    encorst.Data = 0;
    send(enco_pub, encorst);
