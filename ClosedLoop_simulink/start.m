    rosinit;
    pwm_l_pub = rospublisher('/pwm_cmd_l', 'std_msgs/Int16');
    pwm_r_pub = rospublisher('/pwm_cmd_r', 'std_msgs/Int16');
    enco_pub = rospublisher('/enco_rst', 'std_msgs/Int16');
    scansub = rossubscriber('/scan');
    pause(1);
    scan = receive(scansub);
    encorst = rosmessage(enco_pub);
    encorst.Data = 0;
    send(enco_pub, encorst);