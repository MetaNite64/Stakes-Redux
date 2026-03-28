SMODS.Stake:take_ownership("green", {
  applied_stakes = { "yellow" },
  above_stake = "yellow",
  modifiers = function()
    G.GAME.modifiers.srdx_interest_mod = 1
    G.GAME.interest_cap = 30
  end,
})

-- make Seed Money and Money Tree friendly to non-hardcoded interest cap
SMODS.Voucher:take_ownership("seed_money", {
  name = "srdx_seed_money",
  config = { extra = { cap = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.cap } }
  end,

  redeem = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.interest_cap = card.ability.extra.cap * (5 + (G.GAME.modifiers.srdx_interest_mod or 0))
        return true
      end
    }))
  end
})

SMODS.Voucher:take_ownership("money_tree", {
  name = "srdx_money_tree",
  config = { extra = { cap = 20 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.cap } }
  end,

  redeem = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.interest_cap = card.ability.extra.cap * (5 + (G.GAME.modifiers.srdx_interest_mod or 0))
        return true
      end
    }))
  end
})
