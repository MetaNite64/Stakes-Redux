-- apply all the stickers if sticker_stakes is set to apply them on white stake
if SMODS.current_mod.config.sticker_stakes == 3 then
  SMODS.Stake:take_ownership("white", {
    modifiers = function()
      G.GAME.modifiers.enable_eternals_in_shop = true
      G.GAME.modifiers.enable_perishables_in_shop = true
      G.GAME.modifiers.enable_rentals_in_shop = true
      for i, v in pairs(SMODS.Stickers) do
        if v.original_mod and v.needs_enable_flag then
          G.GAME.modifiers["enable_" .. i] = true
        end
      end
    end
  })
end
