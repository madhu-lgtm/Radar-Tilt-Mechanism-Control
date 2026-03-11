

-- Functions For yaw 
--ahrs:get_yaw() -- WORKING heading
--vehicle:get_wp_bearing_deg() -- WORKING
--vehicle:get_steering_and_throttle()
--follow:get_target_heading_deg() 


local heading_deg
local bearing_deg
local curr_yaw_deg
local curr_yaw_rad
local pi = 3.14159265359


function update()

    bearing_deg = vehicle:get_wp_bearing_deg()
    if bearing_deg then 
    gcs:send_text(4,"bearing_deg = "..bearing_deg)
    else 
    gcs:send_text(4,"No bearing data")   
    end
       
    curr_yaw_rad = ahrs:get_yaw()
    curr_yaw_deg = curr_yaw_rad*(180/pi)
    if curr_yaw_deg then 
        gcs:send_text(4,"curr_yaw_deg = "..curr_yaw_deg)
    else
        gcs:send_text(4,"no curr_yaw_deg")
    end

    return update, 1000
end 
 return update, 2000


