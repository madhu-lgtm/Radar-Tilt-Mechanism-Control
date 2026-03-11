-- Function rc:get_pwm(chan_num) retrieves the PWM value for a given channel
-- Function RangeFinder_State_ud:distance() retrieves the current distance
-- Function RangeFinder_State_ud:distance(value) sets a new distance value (if applicable)

local radar_dist

function update()
    if vehicle:get_mode() == 5 then -- Loiter Mode
        local distance = RangeFinder_State_ud:distance()
        if distance then
            radar_dist = distance
            gcs:send_text(3, "radar_dist = " .. radar_dist)
        end
    end
    return update, 50 -- Update interval set to 50 ms
end

return update, 50 -- Consistent update interval
