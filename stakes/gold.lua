local applied = { "stake_black" }
local stake_loc = ""
if SMODS.current_mod.config.sticker_stakes == 1 then
  local sticker_stake = "stake_srdx_citrine"
  stake_loc = " and Citrine Stake"
  if SMODS.current_mod.config.gigantic_sticker then
    sticker_stake = "stake_srdx_emerald"
    stake_loc = " and Emerald Stake"
  end
  if SMODS.current_mod.config.blighted_sticker then
    sticker_stake = "stake_srdx_obsidian"
    stake_loc = " and Obsidian Stake"
  end
  if SMODS.current_mod.config.traitorous_sticker then
    sticker_stake = "stake_srdx_bixbite"
    stake_loc = " and Bixbite Stake"
  end
  applied[#applied + 1] = sticker_stake
end
local gold_stickers = SMODS.current_mod.config.sticker_stakes == 4

SMODS.Stake:take_ownership("gold", {
  prefix_config = { applied_stakes = false, above_stake = false },
  atlas = "stakes",
  pos = { x = 2, y = 0 },
  sticker_atlas = "stickers",
  sticker_pos = { x = 2, y = 1 },
  applied_stakes = applied,
  above_stake = "stake_black",
  modifiers = function()
    G.GAME.modifiers.srdx_shop_multiplier = 1.25
    if gold_stickers then
      G.GAME.modifiers.enable_eternals_in_shop = true
      G.GAME.modifiers.enable_perishables_in_shop = true
      G.GAME.modifiers.enable_rentals_in_shop = true
      for i, v in pairs(SMODS.Stickers) do
        if v.original_mod and v.needs_enable_flag then
          G.GAME.modifiers["enable_" .. i] = true
        end
      end
    end
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
