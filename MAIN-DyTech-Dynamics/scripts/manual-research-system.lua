module("MRS", package.seeall)
require "scripts/functions"
require "scripts/rs-functions"
require "scripts/guinames"
require "config"
require "defines"

function showResearchMainGUI(PlayerIndex)
local player = game.players[PlayerIndex]
player.gui.top.add({type="flow", direction="vertical", name=guiNames.mainResearchFlow})
player.gui.top[guiNames.mainResearchFlow].add({type="frame", direction="vertical", name=guiNames.mainResearchFrame, caption={"gui-unlock-screen-1"}})
adder = player.gui.top[guiNames.mainResearchFlow][guiNames.mainResearchFrame]
if global.ResearchSystem.RSManual then
	RSF.RecipeAvailableToUnlockTier1()
	RSF.RecipeAvailableToUnlockTier2()
	RSF.RecipeAvailableToUnlockTier3()
	RSF.RecipeAvailableToUnlockTier4()
	adder.add({type="button", name=guiNames.Tier1Base, caption={"Tier1", "(", tostring(global.ResearchSystem.RecipeAvailableToUnlock.Tier1), ")"}})
	adder.add({type="button", name=guiNames.Tier2Base, caption={"Tier2", "(", tostring(global.ResearchSystem.RecipeAvailableToUnlock.Tier2), ")"}})
	adder.add({type="button", name=guiNames.Tier3Base, caption={"Tier3", "(", tostring(global.ResearchSystem.RecipeAvailableToUnlock.Tier3), ")"}})
	adder.add({type="button", name=guiNames.Tier4Base, caption={"Tier4", "(", tostring(global.ResearchSystem.RecipeAvailableToUnlock.Tier4), ")"}})
	if global.ResearchSystem.science >= 250 then 
		adder.add({type="button", name="DyTech-Dynamics-Extra-Unlocks", caption={"research-system-extra-unlocks"}})
	end
end
adder.add({type="button", name="DyTech-Research-System-Switch", caption={"research-system-switch", {tostring(global.ResearchSystem.RSAutomatic)}}})
if debug_GUI then adder.add({type="button", name="DebugAddPoints", caption="100k points"}) end
adder.add({type="button", name="DyTech-Dynamics-Back-Button", caption={"back"}})
end

function showResearchExtraGUI(PlayerIndex)
local player = game.players[PlayerIndex]
player.gui.top.add({type="flow", direction="horizontal", name=guiNames.mainResearchExtraFlow})
player.gui.top[guiNames.mainResearchExtraFlow].add({type="frame", direction="vertical", name=guiNames.mainResearchExtraFrame1, caption={"gui-unlock-screen-1"}})
player.gui.top[guiNames.mainResearchExtraFlow].add({type="frame", direction="vertical", name=guiNames.mainResearchExtraFrame2, caption={"quickbar", game.forces.player.quickbar_count}})
player.gui.top[guiNames.mainResearchExtraFlow].add({type="frame", direction="vertical", name=guiNames.mainResearchExtraFrame3, caption={"stacksize", (game.forces.player.inserter_stack_size_bonus+1)}})
adder1 = player.gui.top[guiNames.mainResearchExtraFlow][guiNames.mainResearchExtraFrame1]
adder2 = player.gui.top[guiNames.mainResearchExtraFlow][guiNames.mainResearchExtraFrame2]
adder3 = player.gui.top[guiNames.mainResearchExtraFlow][guiNames.mainResearchExtraFrame3]
adder1.add({type="label", name="", caption={"points", global.ResearchSystem.science}})
if global.ResearchSystem.science > (500*game.forces.player.quickbar_count) and game.forces.player.quickbar_count <= 20 then
	adder2.add({type="button", name="DyTech-Dynamics-Extra-Quickbar-Minus-Button", caption="-"})
	adder2.add({type="button", name="DyTech-Dynamics-Extra-Quickbar-Plus-Button", caption="+"})
else
	adder2.add({type="button", name="DyTech-Dynamics-Extra-Quickbar-Minus-Button", caption="-"})
end
if global.ResearchSystem.science > (250+(250*game.forces.player.inserter_stack_size_bonus)) then
	adder3.add({type="button", name="DyTech-Dynamics-Extra-Stacksize-Minus-Button", caption="-"})
	adder3.add({type="button", name="DyTech-Dynamics-Extra-Stacksize-Plus-Button", caption="+"})
else
	adder3.add({type="button", name="DyTech-Dynamics-Extra-Stacksize-Minus-Button", caption="-"})
end
adder1.add({type="button", name="DyTech-Dynamics-Back-Button", caption={"back"}})
end

function showUnlockTableGUI(PlayerIndex, Tier)
local player = game.players[PlayerIndex]
player.gui.top.add({type="flow", direction="vertical", name=guiNames.mainResearchTableFlow})
player.gui.top[guiNames.mainResearchTableFlow].add({type="frame", direction="vertical", name=guiNames.mainResearchTableFrame, caption={"tier-unlock-screen-1", Tier, {"tier-unlock-screen-2"}}})
adder = player.gui.top[guiNames.mainResearchTableFlow][guiNames.mainResearchTableFrame]
adder.add({type="table", name=guiNames.RSTable, colspan=16})
	populateGUIUnlockTable(PlayerIndex, Tier)
adder.add({type="button", name=guiNames.MRSBackButton2, caption={"back"}})
end

function populateGUIUnlockTable(PlayerIndex, TierRecipe)
local player = game.players[PlayerIndex]
local mainResearchTableFrame = player.gui.top[guiNames.mainResearchTableFlow][guiNames.mainResearchTableFrame]
	for _, name in pairs(mainResearchTableFrame[guiNames.RSTable].children_names) do
		mainResearchTableFrame[guiNames.RSTable][name].destroy()
	end
	for RecipeName, info in pairs(global.ResearchSystem.ItemUnlock) do
	if not global.ResearchSystem.Unlocked[RecipeName] then
	local data = global.ResearchSystem.ItemUnlock[RecipeName]
		if global.ResearchSystem.science > data.Points and RSF.DSgetResearchLevel(data.Tech)==TierRecipe then
			mainResearchTableFrame[guiNames.RSTable].add({type="checkbox", name=RecipeName, style=RecipeName.."_DyTech_button_style", caption="", state = false})
		end
	end end
end

function showUnlockGUIBase(PlayerIndex, RecipeName)
local info = global.ResearchSystem.ItemUnlock[RecipeName]
game.players[PlayerIndex].gui.top.add({type="flow", direction="vertical", name=guiNames.mainFlowMRSUnlock1})
game.players[PlayerIndex].gui.top[guiNames.mainFlowMRSUnlock1].add({type="frame", direction="vertical", name=guiNames.mainFrameMRSUnlock, caption={"gui-unlock-screen"}})
mainFrameMRSUnlock = game.players[PlayerIndex].gui.top[guiNames.mainFlowMRSUnlock1][guiNames.mainFrameMRSUnlock]
-- Flow 2
mainFrameMRSUnlock.add({type="flow", direction="horizontal", name=guiNames.mainFlowMRSUnlock2})
mainFrameMRSUnlock[guiNames.mainFlowMRSUnlock2].add({type="label", name="", caption={"name", {info.Locale.."-name."..RecipeName}}})
-- Flow 3
mainFrameMRSUnlock.add({type="flow", direction="horizontal", name=guiNames.mainFlowMRSUnlock3})
mainFrameMRSUnlock[guiNames.mainFlowMRSUnlock3].add({type="label", name="", caption={"has-science-points", tostring(global.ResearchSystem.science)}})
-- Flow 4
mainFrameMRSUnlock.add({type="flow", direction="horizontal", name=guiNames.mainFlowMRSUnlock4})
mainFrameMRSUnlock[guiNames.mainFlowMRSUnlock4].add({type="label", name="", caption={"science-points-cost", info.Points}})
-- Buttons
mainFrameMRSUnlock.add({type="flow", direction="horizontal", name=guiNames.mainFlowMRSUnlock5})
mainFrameMRSUnlock[guiNames.mainFlowMRSUnlock5].add({type="button", name=guiNames.MRSUnlockButton, caption={"unlock"}})
mainFrameMRSUnlock[guiNames.mainFlowMRSUnlock5].add({type="button", name=guiNames.MRSBackButton1, caption={"close"}})
end