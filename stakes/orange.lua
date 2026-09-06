SMODS.Stake:take_ownership("orange", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_red" },
  above_stake = "stake_red",
  modifiers = function()
    G.GAME.modifiers.srdx_edition_rare = true
  end,
  loc_vars = function(self, info_queue, card)
  end
})

local poll_edition_ref = poll_edition
poll_edition = function(_key, _mod, _no_neg, _guaranteed, _options)
  if G.GAME.modifiers.srdx_edition_rare then
    _mod = (_mod or 1) * 0.5
  end
  return poll_edition_ref(_key, _mod, _no_neg, _guaranteed, _options)
end
