-- Pre defined recipes for comparison
local recipes = {
    recipe1 = {
      ["minecraft:diamond"] = 64,
      ["minecraft:iron_ingot"] = 32,
    },
    Distillation_tower_12 = {
      ["gtceu:distillation_tower"] = 1,
      ["gtceu:ev_energy_input_hatch"] = 1,
      ["gtceu:lv_ouput_hatch"] = 11,
      ["gtceu:lv_input_hatch"] = 1,
      ["gtceu:clean_machine_casing"] = 84,
      ["gtceu:lv_output_bus"] = 1,
    },
    Distillation_tower_5 = {
      ["gtceu:distillation_tower"] = 1,
      ["gtceu:ev_energy_input_hatch"] = 1,
      ["gtceu:lv_ouput_hatch"] = 4,
      ["gtceu:lv_input_hatch"] = 1,
      ["gtceu:clean_machine_casing"] = 35,
      ["gtceu:lv_output_bus"] = 1,
    },
    Cracker = {
      ["gtceu:cracker"] = 1,
      ["gtceu:maintenance_hatch"] = 1,
      ["gtceu:lv_muffler_hatch"] = 1,
      ["gtceu:ev_energy_input_hatch"] = 2,
      ["gtceu:lv_output_hatch"] = 1,
      ["gtceu:ev_input_hatch_4x"] = 1,
      ["gtceu:lv_input_bus"] = 1,
      ["gtceu:kanthal_coil_block"] = 16,
      ["gtceu:clean_machine_casing"] = 18,
    },
    recipe2 = 
}


-- Function to verify which recipe is in the chest
function VerifyRecipeInChest(position,recipeList)
  local chest = peripheral.wrap(position)
  if chest then
    local items = chest.list()
    for nameItem, qtdDesired in pairs(recipeList) do
      local qtdFound = 0
      for slot, item in pairs(items) do
        if item.name == nameItem then
          qtdFound = qtdFound + item.count
        end
      end
      if qtdFound < qtdDesired then
        return false
      end
    end
    return true
  else
    print("ERROR(00): None chest found. Please place a chest on the left of the computer.")
    return false
  end
end

--Function to transfer all itens from a inventory to another
function TransferAll(input,output)
  local input_chest = peripheral.wrap(input)
  local output_chest = peripheral.wrap(output)
  if input_chest and output_chest then
    for slot = 1, input_chest.size() do
      local item = input_chest.getItemDetail(slot)
      if item then
        input_chest.pushItems(output, slot, item.count)
      end
    end
  else
    print("ERROR(01): No input or output chest found.")
  end
end

--Function to transfer a especific item from input to output
function TransferRecipePaper(itemName, input, output)
  local invInput = peripheral.wrap(input)
  for slot = 1, invInput.size() do
    local item = invInput.getItemDetail(slot)
    if item and item.displayName == itemName and item.name == "minecraft:paper" then
      -- Moves the especific item from the input to the output
      invInput.pushItems(output, slot, 1)
      break -- Breaks the loop after transfering the item
    end
  -- print("ERROR(03): Reference item not found.")
  end
end


-- While loop for real time detection
while true do
  local input_chest = "left"
  local output_chest = "front"
  local aux_chest = "top"
  local return_chest = "right"
  local recipeFound = false
  local recipeFoundName=""
  for nameRecipe, listItems in pairs(recipes) do
    if VerifyRecipeInChest(input_chest, listItems) then
      print("The recipe is: " .. nameRecipe)
      recipeFound = true
      recipeFoundName = nameRecipe
      break
    end
  end
  if recipeFound then
    TransferAll(input_chest, output_chest)
    TransferRecipePaper(recipeFoundName, aux_chest, return_chest)
    -- break -- Break the while loop if a recipe is found
  end
  -- Waits a short moment before verifying again 
  os.sleep(1)
end
