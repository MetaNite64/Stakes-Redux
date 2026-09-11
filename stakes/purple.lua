SMODS.Stake:take_ownership("purple", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_blue" },
  above_stake = "stake_blue",
  modifiers = function()
    G.GAME.modifiers.srdx_double_showdowns = true
  end,
})

local showdown_ref = SMODS.is_showdown_ante
SMODS.is_showdown_ante = function()
  return G.GAME.modifiers.srdx_double_showdowns and (G.GAME.round_resets.ante % math.floor(G.GAME.win_ante / 2) == 0 and G.GAME.round_resets.ante > 0) or showdown_ref()
end
