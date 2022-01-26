
local climb = {}

function climb.version()
  return "1.1"
end

-- Attempt to detect what gamemode/game these folks are running on
function climb.game_mode()
    local reported = false -- Have we send a report
    local game_mode = "???" -- let's even return that
    if (minetest.get_modpath("default") or false) and not reported then
        reported = true
        game_mode = "MTG"
    end
    if (minetest.get_modpath("mcl_core") or false) and not reported then
        reported = true
        game_mode = "MCL"
    end
    return game_mode
end

-- Jumpy force
function climb.on_punchy_norm(itemstack, user, pointed_thing)
    -- Normal glove is limited so it must be pointing at something (anything counts)
    if not pointed_thing then return end
    if pointed_thing.type == "nothing" then
        return
    end
    local tool_definition = itemstack:get_definition()
    local tool_cap = tool_definition.tool_capabilities.groupcaps.climbing.maxlevel
    -- minetest API now allows to set speed of player
    local jump2_speed = 3.25 + tool_cap
    user:add_player_velocity({x=0, y=jump2_speed, z=0})
end -- The advanced jumpy force
function climb.on_punchy_adv(itemstack, user, pointed_thing)
    -- Advanced glove doesn't need nodes, so you just punch
    local tool_definition = itemstack:get_definition()
    local tool_cap = tool_definition.tool_capabilities.groupcaps.climbing.maxlevel
    -- minetest API now allows to set speed of player
    local jump2_speed = 3.25 + tool_cap
    user:add_player_velocity({x=0, y=jump2_speed, z=0})
end

-- The actually gloves
minetest.register_tool("climb_glove:basic_glove", {
	short_description = "Basic Climbing Glove",
    description = "Basic Climbing Glove\n(Punch nodes to use)",
	inventory_image = "climb_glove_basic.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			climbing = {times={[1]=1.50, [2]=1.0, [3]=0.50}, uses=1, maxlevel=3},
		},
	},
	groups = {climbing = 1},
    on_use = function(itemstack, user, pointed_thing)
        return climb.on_punchy_norm(itemstack, user, pointed_thing)
    end,
})
minetest.register_tool("climb_glove:adv_glove", {
	short_description = "Advanced Climbing Glove",
    description = "Advanced Climbing Glove\n(Punch to use)",
	inventory_image = "climb_glove_adv.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=3,
		groupcaps={
			climbing = {times={[1]=1.25, [2]=1.0, [3]=0.50}, uses=1, maxlevel=3},
		},
	},
	groups = {climbing = 1},
    on_use = function(itemstack, user, pointed_thing)
        return climb.on_punchy_adv(itemstack, user, pointed_thing)
    end,
})

-- Crafting
local allow_crafts = minetest.settings.get_bool("climb_crafting") or false
if allow_crafts == true then
    local gm = climb.game_mode()
    local empty = ""
    local iron = ""
    local gold = ""
    local diamond = ""
    local glove = "climb_glove:basic_glove" -- Used in making a advanced glove
    if gm == "MTG" then
        iron = "default:steel_ingot"
        gold = "default:gold_ingot"
        diamond = "default:diamond"
    elseif gm == "MCL" then
        iron = "mcl_core:iron_ingot"
        gold = "mcl_core:gold_ingot"
        diamond = "mcl_core:diamond"
    end
    minetest.register_craft({
        output = "climb_glove:basic_glove",
        recipe = {
            {empty, iron, iron},
            {gold, diamond, iron},
            {gold, gold, empty}
        }
    })
    minetest.register_craft({
        output = "climb_glove:adv_glove",
        recipe = {
            {diamond, iron, iron},
            {gold, glove, iron},
            {gold, gold, diamond}
        }
    })
end

-- Indicate ready
minetest.log("action", "[climb_glove] Running version  "..climb.version())
minetest.log("action", "[climb_glove] Running gamemode "..climb.game_mode())
minetest.log("action", "[climb_glove] Ready")
