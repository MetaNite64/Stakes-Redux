local stake = SMODS.current_mod.config.cyan_stake and "stake_srdx_cyan" or "stake_green"
local stake_loc = SMODS.current_mod.config.cyan_stake and "Cyan" or "Green"

SMODS.Stake:take_ownership("blue", {
  prefix_config = { applied_stakes = false, above_stake = false },
  applied_stakes = { stake },
  above_stake = stake,
  modifiers = function()
    if SMODS.Mods.stakesredux.config.blue_stake == 1 then
      G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) - 1
    end
    if SMODS.Mods.stakesredux.config.blue_stake == 2 then
      G.GAME.win_ante = (G.GAME.win_ante or 8) + 2
    end
    if SMODS.Mods.stakesredux.config.blue_stake == 3 then
      G.GAME.modifiers.srdx_double_boss = true
    end
    if SMODS.Mods.stakesredux.config.blue_stake == 4 then
      G.GAME.modifiers.srdx_slow_boosters = true
    end
  end,
  loc_vars = function(self)
    return { vars = { stake_loc } }
  end
})

-- for variant 2 only
local gba_ref = get_blind_amount
get_blind_amount = function(ante)
  if SMODS.Mods.stakesredux.config.blue_stake == 2 then
    local scale = G.GAME.modifiers.scaling or 1
    local amounts = {}
    amounts[1] = {
      300,  800, 2000,  5000,  11000,  20000,   35000,  50000,  85000,  150000
    }
    amounts[2] = {
      300,  900, 2600,  8000,  20000,  36000,  60000,  100000,  150000, 250000
    }
    amounts[3] = {
      300,  1000, 3200,  9000,  25000,  60000,  110000,  200000,  450000, 800000
    }
    amounts[4] = {
      300,
      700 + 100*scale,
      1400 + 600*scale,
      2100 + 2900*scale,
      15000 + 5000*scale*math.log(scale),
      12000 + 8000*(scale+1)*(0.4*scale),
      10000 + 25000*(scale+1)*((scale/4)^2),
      50000 * (scale+1)^2 * (scale/7)^2,
      85000 * (scale+1)^2 * (scale/7)^2,
      150000 * (scale+1)^2 * (scale/7)^2
    }

    if ante < 1 then return 100 end
    local use = math.min(scale, 4)
    if ante <= 10 then return amounts[use][ante] - amounts[use][ante] % (10^math.floor(math.log10(amounts[use][ante])-1)) end

    local a, b, c, d = amounts[use][10], amounts[use][10] / amounts[use][9], ante - 10, 1 + 0.2 * (ante - 10)
    local amount = math.floor(a*(b + (0.75*c)^d)^c)
    amount = amount - amount%(10^math.floor(math.log10(amount)-1))
    return amount
  else
    return gba_ref(ante)
  end
end

-- for variant 3 only
local gcb_ref = Spectrallib.get_copied_blinds
Spectrallib.get_copied_blinds = function(blind, proto)
  local ret = gcb_ref(blind, proto)
  if G.GAME.modifiers.srdx_double_boss then table.insert(ret, G.GAME.srdx_double_boss) end
  return ret
end

local reroll_boss_ref = G.FUNCS.reroll_boss
G.FUNCS.reroll_boss = function(e)
  local ret = reroll_boss_ref(e)
  G.GAME.srdx_double_boss = SMODS.get_new_blind("boss")
  return ret
end

-- for variant 4 only
G.FUNCS.srdx_shop_booster_empty = function(e)
  e.states.visible = true
  e.states.visible = not (G.shop_booster and G.shop_booster.cards and G.shop_booster.cards[1])
end

local ca_draw_ref = CardArea.draw
CardArea.draw = function(self)
  if self == G.shop_booster and not self.cards[1] then
    if not self.children.area_uibox then
      self.children.area_uibox = UIBox{
        definition =
        {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
          {n=G.UIT.R, config={minw = self.T.w,minh = self.T.h,align = "cm", padding = 0.1, mid = true, r = 0.1, colour = self.config.bg_colour or self ~= G.shop_vouchers and {0,0,0,0} or nil, ref_table = self}, nodes={
            {n=G.UIT.C, config={align = "cm", paddin = 0.1, func = 'srdx_shop_booster_empty', visible = false}, nodes={
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = 'DEFEAT', scale = 0.6, colour = G.C.WHITE}}
              }},
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = 'BOSS BLIND', scale = 0.4, colour = G.C.WHITE}}
              }},
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = 'TO RESTOCK', scale = 0.4, colour = G.C.WHITE}}
              }},
            }},
          }},
        }},
        config = { align = 'cm', offset = {x=0,y=0}, major = self, parent = self}
      }
    end
    self.children.area_uibox:draw()
  else
    return ca_draw_ref(self)
  end
end
