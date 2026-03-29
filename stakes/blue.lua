SMODS.Stake:take_ownership("blue", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_green" },
  above_stake = "stake_green",
  modifiers = function()
    for i, v in pairs(G.GAME.hands) do
      v.l_chips = v.l_chips * 0.8
      v.l_mult = v.l_mult * 0.8
    end
  end,
})
