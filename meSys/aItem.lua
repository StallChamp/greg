--Arraystructure 
--Item (string): the full name id of the item found by pressing F3+h and looking at the item disciption. Example : "minecraft:iron_ingot"
--Damage (int): durability of the item OR the number behind the id for items that share a name i.e. Laboratoryblocks 1035/2 , 1035
--              when adding such items comment the name beside the entry like so "--tin_igot"
--WantedNumberOfItems (int): The wandted Amount of items in the me system
--MaxCraftSize (int): lies du hund
--Full example: {"chisel:laboratoryblock", 2, 128, 32} --Enamelled Wall

return {
  {"gregtech:gt.metaitem.01", 11081, 3000, 10}, --StainlessSteel
  {"gregtech:gt.metaitem.01", 11306, 3000, 10}, --StainlessSteel
  {"gregtech:gt.metaitem.01", 11305, 3000, 10}, --Steel
  {"gregtech:gt.metaitem.01", 11067, 3000, 10}, --Neodynium
  {"gregtech:gt.metaitem.01", 11084, 3000, 10}, --Iridium
  {"gregtech:gt.metaitem.01", 11334, 3000, 10}, --Black Steel
  {"gregtech:gt.metaitem.01", 11366, 5000, 10}, --Energetic Alloy
  {"gregtech:gt.metaitem.01", 11312, 3000, 10}, --Kanthal
  {"gregtech:gt.metaitem.01", 11028, 3000, 10}, --Titanium
  {"gregtech:gt.metaitem.01", 11019, 5000, 10}, --Alu
  {"gregtech:gt.metaitem.01", 11316, 3000, 10}, --TungstenSteel
  {"gregtech:gt.metaitem.03", 32088, 10, 10}, -- zmp Circuit
  {"gregtech:gt.metaitem.03", 32087, 50, 10}, -- luv Circuit
  {"gregtech:gt.metaitem.03", 32086, 100, 10}, -- iv Circuit
  {"gregtech:gt.metaitem.03", 32085, 100, 10}, -- ev Circuit
  {"gregtech:gt.metaitem.03", 32082, 200, 10}, -- hv Circuit
  {"gregtech:gt.metaitem.03", 32080, 100, 10}, -- mv Circuit
  {"gregtech:gt.metaitem.03", 32078, 100, 10}, -- lv Circuit
  {"appliedenergistics2:item.ItemMultiMaterial", 30, 100, 10}, --Acceleration card
  {"gregtech:gt.metaitem.01", 32714, 500, 16}, --Lapratron crystall
}