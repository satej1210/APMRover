
    pwmlmsg = rosmessage(pwm_l_pub);
    pwmrmsg = rosmessage(pwm_r_pub);
    pwm = 50;
    while pwm > 0
        pwmlmsg.Data = pwm;
        pwmrmsg.Data = pwm;
        send(pwm_l_pub,pwmlmsg);
        send(pwm_r_pub,pwmrmsg);
        pause(0.1);
        pwm=pwm-10;
    end
    rosshutdown;