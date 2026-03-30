SMODS.Stake:take_ownership("gold", {
  prefix_config = { applied_stakes = false, above_stake = false },
  atlas = "stakes",
  pos = { x = 1, y = 1 },
  sticker_atlas = "stickers",
  sticker_pos = { x = 2, y = 0 },
  applied_stakes = { "stake_black", "stake_srdx_emerald" },
  above_stake = "stake_black",
  modifiers = function()
    G.GAME.modifiers.srdx_shop_multiplier = 1.25
  end
})

local set_cost_ref = Card.set_cost
Card.set_cost = function(self)
  set_cost_ref(self)
  self.cost = math.floor(self.cost * (G.GAME.modifiers.srdx_shop_multiplier or 1) + 0.5)
end
