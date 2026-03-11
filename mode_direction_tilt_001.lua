--FUNCTIONS USED
--SRV_Channels:set_output_pwm_chan(11,y)

-- Corresponding Angle and PWM 
-- -45 = 1005
-- +45 = 1695
-- 0 = 1350

local mode_num
local rngfnd_cm
local teta
local set_pwm
local servo1 = 11
local pi = 3.14159265359

function update()

     mode_num = vehicle:get_mode() 
     teta_rad = ahrs:get_pitch()
     teta_deg = teta_rad*(180/pi)

     gcs:send_text(5,"teta_deg = "..teta_deg)

    if mode_num == 16 then --16 = Poshold
        set_pwm = 1350 -- 0deg
    elseif mode_num == 5 and teta_deg >= 0 then --5 = Loiter
        set_pwm = 1005 -- +ve 45deg
    elseif mode_num == 5 and teta_deg < 0 then 
        set_pwm = 1695 -- -ve 45deg
    else
        set_pwm = 1350 -- 0deg
    end 

    SRV_Channels:set_output_pwm_chan(servo1,set_pwm)

    -- rngfnd_cm = rangefinder:distance_cm_orient(25) -- 25 is facing down
    -- gcs:send_text(4,"mode_num = "..mode_num)
    -- gcs:send_text(4,"rngfnd_cm = "..rngfnd_cm)
    return update, 50 --50ms Update time
end
return update, 2000 --2000ms