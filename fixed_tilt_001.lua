-- Y = m*(X-x1)+y1 -- Y is required PWM for For X deg
-- m = -7.666
-- y1 =  1350
-- y2 = 660
-- x1 = 0 
-- x2 = 90 
-- ahrs:get_pitch()
--  SRV_Channels:set_output_pwm_chan(servo_pin_num,set_pwm)

local slop_deg = -7.666
local zero_deg_pwm = 1350
local look_ahead_ang = -20 --Variable (0 to -30)
local look_ahead_pwm 
local pitch_rad
local pitch_deg
local pitch_deg_rev
local set_servo_pwm
local pi = 3.14159265359
local servo_pin = 11 -- Aux4
local max_pitch_deg_lmt = 25 --editable (10 to 30)
local min_pitch_deg_lmt = -25 --editable (-10 to -30)

function update()
    
    pitch_rad = ahrs:get_pitch()
    pitch_deg = pitch_rad*(180/pi)
    pitch_deg_rev = -pitch_deg

    look_ahead_pwm = slop_deg*(look_ahead_ang)+zero_deg_pwm
    set_servo_pwm = math.floor(slop_deg*(pitch_deg)+look_ahead_pwm)

    if(pitch_deg >= min_pitch_deg_lmt and pitch_deg <= max_pitch_deg_lmt) then 
        SRV_Channels:set_output_pwm_chan(servo_pin,set_servo_pwm)
    else 
        SRV_Channels:set_output_pwm_chan(servo_pin,zero_deg_pwm)
    end
    -- Avove if condition OR below one Instruction (use any One)
    --SRV_Channels:set_output_pwm_chan(servo_pin,zero_deg_pwm) -- Uncomment if required staic fixed mount for radar 



    return update, 50
end 
return update, 2000