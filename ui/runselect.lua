SMODS.RunSelectPage {
  key = "sticker_choice",
  grid_size = { 2, 3 },
  --automatic_preview = true,
  selection_limit = math.huge,
  random_select = false,

  generate_pool = function()
    local pool = {}
    for i, v in pairs(SMODS.Stickers) do
      if i ~= "pinned" then
        local order = v.order
        if order > 4 then order = order - 1 end
        pool[order] = v
      end
    end
    return pool
  end,

  optional = function(self)
    return SMODS.RunSelect.Setup.choices.stake_choice ~= SMODS.Stakes.stake_srdx_platinum.order
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

-- PR this to SMODS lol
--[[
local can_change_page_ref = G.FUNCS.run_select_can_change_page
G.FUNCS.run_select_can_change_page = function(e)
  can_change_page_ref(e)
  if e.config.id == "next_selection" then
    local next_page_index = SMODS.RunSelect.Functions.get_page_key(1)
    local final = SMODS.RunSelect.Internals.current_page == #SMODS.RunSelect.Internals.pages or next_page_index > #SMODS.RunSelect.Internals.pages
    local next_button_text = final and localize('run_select_play') or (localize('run_select_'..SMODS.RunSelect.Internals.pages[next_page_index]) .. ' >')
    if next_button_text ~= SMODS.RunSelect.Internals.next_button_text then
      SMODS.RunSelect.Internals.next_button_text = next_button_text
      e.children[1].children[1].config.object:remove()
      e.children[1].children[1].config.object = DynaText({string = {{ref_table = SMODS.RunSelect.Internals, ref_value = 'next_button_text'}}, colours = {G.C.WHITE}, shadow = true, maxw = 1.8, pop_in_rate = 0, scale = 0.4, silent = true})
      e.children[1].children[1].config.object.ui_object_updated = true
    end
  end
end
--]]
