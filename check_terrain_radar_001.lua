-- function rc:get_pwm(chan_num) end
-- function RangeFinder_State_ud:distance() end
-- function RangeFinder_State_ud:distance(value) end
-- function RangeFinder_State() end
-- function Location_ud:terrain_alt() end
-- function rangefinder:ground_clearance_cm_orient(orientation) end
-- function rangefinder:distance_cm_orient(orientation) end -- WORKING
-- function sub:get_rangefinder_target_cm() end
-- function sub:set_rangefinder_target_cm(new_target_cm) end
-- function baro:get_altitude() end -- WORKING
-- function rangefinder:get_backend(rangefinder_instance) end
-- function sub:rangefinder_alt_ok() end
-- function Location_ud:alt() end

local radar_dist

function update()
    if vehicle:get_mode() == 5 then -- Loiter Mode
        -- local distance = RangeFinder_State_ud:distance()
        -- if distance then
        --   radar_dist = distance
        --   gcs:send_text(3,"radar_dist = "..radar_dist)
        -- end
        -- local rfnd_state = RangeFinder_State(0)
        -- gcs:send_text(3,"RangeFinder_State = "..rfnd_state)

        -- local distance = Location_ud:terrain_alt()
        -- if distance then
        --   radar_dist = distance
        --   gcs:send_text(3,"radar_dist = "..radar_dist)
        -- end
        rangefinder:get_backend(25)

        local orientation = 25
        radar_dist = rangefinder:distance_cm_orient(orientation)
        gcs:send_text(3,"radar_dist = "..radar_dist) 

    end
    return update, 50
end --function update
return update, 2000