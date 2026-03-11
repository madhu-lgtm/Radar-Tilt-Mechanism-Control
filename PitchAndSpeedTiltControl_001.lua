-- Reading Pitch and speed Values from FC and changing servo angle
--SRV_Channels:set_output_pwm_chan(chan, pwm)
--ahrs:get_pitch()
--arming:is_armed()
--gps:ground_speed(instance)
-- Deg to radian 
-- 2.5deg = 0.0436332
-- 5deg = 0.0872665
-- 7.5deg = 0.1309
-- 10deg = 0.174533
-- 12.5deg = 0.2181662
-- 15deg = 0.261799
-- 20deg = 0.349066
-- 25deg = 0.436332
-- 30deg = 0.523599

function update()
  local pit_ang --pitch from fc in rad (x)
  local spd_ang --Speed based Angle
  local pit_spd_ang

  local srv_slop = -439.2999 -- slop equation for RDS3115 Servo
  local pit_pwm -- Result pwm (y)
  local spd_pwm 
  local pit_spd_pwm
  local srv_mid_pos_pwm = 1350

  local lmt_ang -- limit angle (p)
  local mul_fact = 1 -- multiplying factor (q) 0.1 to 2 range

  local min_speed = 0
  local max_speed = 7
  local min_look_ahead = 0
  local max_look_ahead = 7
  local max_look_ahead_final = max_look_ahead * mul_fact
  local spd_slop = (max_look_ahead_final - min_look_ahead)/(max_speed - min_speed)
  local set_alt = 5
  local cal_look_ahead 
  local drone_speed

  pit_ang = ahrs:get_pitch() 
  pit_ang = -pit_ang --Negative for giving opposite angle
  gcs:send_text(3,"Drone Pitch = "..pit_ang)

  lmt_ang = 0.523599 -- (+-30deg Set limit)
   if (pit_ang >= -lmt_ang and pit_ang <= lmt_ang) then -- Min And Max angle limit Condition  
        if arming:is_armed() then 
            drone_speed = gps:ground_speed(0)

            if(drone_speed) then
                cal_look_ahead = (spd_slop*(drone_speed-min_speed))+min_look_ahead
                spd_ang = math.atan(cal_look_ahead/set_alt)

                pit_spd_ang = pit_ang+spd_ang
                pit_spd_pwm = math.floor((srv_slop * pit_spd_ang) + srv_mid_pos_pwm)
                
                gcs:send_text(3,"Radar Pitch = "..pit_ang)
                SRV_Channels:set_output_pwm_chan(11,pit_spd_pwm) -- 10 for AUX3, 11 for AUX4
            end
        else
            pit_spd_pwm = srv_mid_pos_pwm
            SRV_Channels:set_output_pwm_chan(11,pit_spd_pwm)
        end
    end 
  return update, 50 --50ms Update time
end

return update, 2000 --2000ms
