local gigantic = SMODS.current_mod.config.gigantic_sticker
local applied = { "stake_black" }
local stake_loc = ""
if SMODS.current_mod.config.sticker_stakes == 1 then
  applied[#applied + 1] = gigantic and "stake_srdx_emerald" or "stake_srdx_citrine"
  stake_loc = gigantic and " and Emerald Stake" or " and Citrine Stake"
end
local gold_stickers = SMODS.current_mod.config.sticker_stakes == 3

SMODS.Stake:take_ownership("gold", {
  prefix_config = { applied_stakes = false, above_stake = false },
  atlas = "stakes",
  pos = { x = 1, y = 1 },
  sticker_atlas = "stickers",
  sticker_pos = { x = 2, y = 0 },
  applied_stakes = applied,
  above_stake = "stake_black",
  modifiers = function()
    G.GAME.modifiers.srdx_shop_multiplier = 1.25
    -- no harm in doing this always; this accounts for the sticker stake setting if it's set to apply on gold stake
    G.GAME.modifiers.enable_eternals_in_shop = true
    G.GAME.modifiers.enable_perishables_in_shop = true
    G.GAME.modifiers.enable_rentals_in_shop = true
    if gigantic then G.GAME.modifiers.enable_srdx_gigantic = true end
  end,
  loc_vars = function()
    if gold_stickers then return { key = "stake_gold_stickers" } end
    return { vars = { stake_loc } }
  end
})

local set_cost_ref = Card.set_cost
Card.set_cost = function(self)
  set_cost_ref(self)
  self.cost = math.floor(self.cost * (G.GAME.modifiers.srdx_shop_multiplier or 1) + 0.5)
end
