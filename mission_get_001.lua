local mission_item_1

function update()
    mission_item_1 = mission:get_item(2)
    if mission_item_1 then 
        local mission_altitude = mission_item_1:z()
        gcs:send_text(4,"mission_alt = "..mission_altitude)
    end
    return update, 1000
end 
return update, 2000