-- Functions for Velocity and speed 
--gps:ground_course(instance) --instance = 0(GPS1)
--gps:ground_speed(instance) -- WORKING
--gps:velocity(instance)
--ahrs:get_velocity_NED()
--ahrs:groundspeed_vector() -- WORKING
--ahrs:airspeed_estimate()

local gps_ground_speed 
local ahrs_ground_speed
local ahrs_ground_speed_2
local gps_velocity 
local ahrs_velocity 


function update()

    gps_ground_speed = gps:ground_speed(0)
    if gps_ground_speed then 
    gcs:send_text(4,"gps_ground_speed = "..gps_ground_speed)
    else 
    gcs:send_text(4,"No gps_ground_speed")   
    end
       
    ahrs_ground_speed = ahrs:groundspeed_vector()
    if ahrs_ground_speed then 
        local ahrs_ground_speed_x = ahrs_ground_speed:x() -- North
        local ahrs_ground_speed_y = ahrs_ground_speed:y() -- East
        gcs:send_text(4,"ahrs_ground_speed_x = "..ahrs_ground_speed_x)
        gcs:send_text(4,"ahrs_ground_speed_y = "..ahrs_ground_speed_y)

    else
        gcs:send_text(4,"No ahrs_ground_speed")
    end

    return update, 1000
end 
 return update, 2000


