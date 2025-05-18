local component = require("component")
local meController = component.proxy(component.me_controller.address)
local gpu = component.gpu

package.loaded["aItems"] = nil
local items = require("aItems")
print("loaded item count", #items)

loopDelay = 60 -- Seconds between runs

while true do
    for curIdx = 1, #items do
        curName = items[curIdx][1]
        curDamage = items[curIdx][2]
        curMinValue = items[curIdx][3]
        curMaxRequest = items[curIdx][4]

        -- io.write("Checking for " .. curMinValue .. " of " .. curName .. "\n")
        storedItem = meController.getItemsInNetwork({
            name = curName,
            damage = curDamage
        })
        io.write("Network contains ")
        gpu.setForeground(0xCC24C0) -- Purple-ish
        io.write(storedItem[1].size)
        gpu.setForeground(0xFFFFFF) -- White
        io.write(" items with label ")
        gpu.setForeground(0x00FF00) -- Green
        io.write(storedItem[1].label .. "\n")
        gpu.setForeground(0xFFFFFF) -- White
        if storedItem[1].size < curMinValue then
            delta = curMinValue - storedItem[1].size
            craftAmount = delta
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

            craftables = meController.getCraftables({
                name = curName,
                damage = curDamage
            })
            if #craftables >= 1 then
                cItem = craftables[1]
                retval = cItem.request(craftAmount)
                gpu.setForeground(0x00FF00) -- Green
                io.write("OK\n")
                gpu.setForeground(0xFFFFFF) -- White
            else
                gpu.setForeground(0xFF0000) -- Red
                io.write("    Unable to locate craftable for " .. storedItem[1].name .. "\n")
                gpu.setForeground(0xFFFFFF) -- White
            end
        end
    end
    io.write("Sleeping for " .. loopDelay .. " seconds...\n\n")
    os.sleep(loopDelay)
end
