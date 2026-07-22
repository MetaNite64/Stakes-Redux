SMODS.RunSelectPage {
  key = "sticker_choice",
  grid_size = { 2, 6 },
  selection_limit = math.huge,
  random_select = false,

  generate_pool = function()
    local pool = {}
    for i, v in pairs(SMODS.Stickers) do
      if v.needs_enable_flag and i ~= "pinned" then
        local order = v.order
        if order > 4 then order = order - 1 end
        pool[order] = v
      end
    end
    return pool
  end,

  optional = function(self)
    return SMODS.RunSelect.Setup.choices.stake_choice ~= "stake_srdx_platinum"
  end,

  quick_start_text = function(self, choice)
    if G.PROFILES[G.SETTINGS.profile].last_choices.stake_choice == SMODS.Stakes.stake_srdx_platinum.order then
      return "All Stickers"
    end
    local last_choices = G.PROFILES[G.SETTINGS.profile].last_choices.srdx_sticker_choice or {}
    local count = 0
    for _, v in pairs(last_choices) do
      if v then count = count + 1 end
    end
    return count .. " Stickers"
  end,

  create_selection_card = function(self, sticker_key, card_number, area)
    local card = SMODS.create_card { key = "c_base", force_stickers = { card_key }, area = area }
    card.srdx_run_select_sticker = sticker_key
    card.greyed = not SMODS.RunSelect.Setup.choices[self.key][sticker_key]
    card:add_sticker(sticker_key, true)
    return card
  end,

  handle_choice = function(self, choice, remove)
    local choices = SMODS.RunSelect.Setup.choices[self.key]
    choices = choices or {}
    choices[choice.srdx_run_select_sticker] = not choices[choice.srdx_run_select_sticker]
    choice.greyed = not choice.greyed
  end,

  set_default = function(self, choice)
    local final = {}
    for i, v in pairs(choice) do
      if SMODS.Stickers[i] then final[i] = v end
    end
    return final
  end,

  start_run = function(self, choice)
    for k, v in pairs(choice) do
      if k == "eternal" or k == "perishable" or k == "rental" then
        G.GAME.modifiers["enable_" .. k .. "s_in_shop"] = v
      else
        G.GAME.modifiers["enable_" .. k] = v
      end
    end
  end
}
