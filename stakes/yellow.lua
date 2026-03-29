SMODS.Stake {
  key = "yellow",
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { "stake_orange" },
  above_stake = "stake_orange",
  pos = { x = 2, y = 1 },
  sticker_pos = { x = 3, y = 1 },
  colour = G.C.YELLOW,
  modifiers = function()
    G.GAME.modifiers.srdx_interest_mod = 1
    G.GAME.interest_cap = 30
  end
}

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
