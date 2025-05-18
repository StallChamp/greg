local component = require("component")
local meController = component.proxy(component.me_controller.address)
local gpu = component.gpu

package.loaded["aItems"] = nil
local items = require("aItems")
print("loaded item count", #items)

loopDelay = 60 -- Seconds between runs

function getMeContent ()
    return meController.getItemsInNetwork({
            name = CurName,
            damage = CurDamage
        })
end

while true do
    for curIdx = 1, #items do
        CurName = items[curIdx][1]
        CurDamage = items[curIdx][2]
        CurMinValue = items[curIdx][3]
        CurMaxRequest = items[curIdx][4]

        -- io.write("Checking for " .. curMinValue .. " of " .. curName .. "\n")
        
        if pcall(getMeContent()) then
            local storedItem = getMeContent()
        else
            goto continue
        end
        io.write("Network contains ")
        gpu.setForeground(0xCC24C0) -- Purple-ish
        io.write(storedItem[1].size)
        gpu.setForeground(0xFFFFFF) -- White
        io.write(" items with label ")
        gpu.setForeground(0x00FF00) -- Green
        io.write(storedItem[1].label .. "\n")
        gpu.setForeground(0xFFFFFF) -- White
        if storedItem[1].size < CurMinValue then
            local delta = CurMinValue - storedItem[1].size
            local craftAmount = delta
            if delta > curMaxRequest then
                craftAmount = curMaxRequest
            end

            io.write("  Need to craft ")
            gpu.setForeground(0xFF0000) -- Red
            io.write(delta)
            gpu.setForeground(0xFFFFFF) -- White
            io.write(", requesting ")
            gpu.setForeground(0xCC24C0) -- Purple-ish
            io.write(craftAmount .. "... ")
            gpu.setForeground(0xFFFFFF) -- White

            local craftables = meController.getCraftables({
                name = CurName,
                damage = CurDamage
            })
            if #craftables >= 1 then
                local cItem = craftables[1]
                local requestSuccess, retval = pcall(cItem.request(craftAmount))
                if requestSuccess then
                    gpu.setForeground(0x00FF00) -- Green
                io.write("OK\n")
                else
                    gpu.setForeground(0xFF0000) -- Red
                    io.write("Request failed")
                end
                gpu.setForeground(0xFFFFFF) -- White
            else
                gpu.setForeground(0xFF0000) -- Red
                io.write("    Unable to locate craftable for " .. storedItem[1].name .. "\n")
                gpu.setForeground(0xFFFFFF) -- White
            end
        end
        ::continue::
    end
    io.write("Sleeping for " .. loopDelay .. " seconds...\n\n")
    os.sleep(loopDelay)
end
