local stakesredux = SMODS.current_mod

stakesredux.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = {
      emboss = 0.05,
      minh = 6,
      r = 0.1,
      minw = 10,
      align = "cm",
      padding = 0.2,
      colour = G.C.BLACK
    }, nodes = {
      { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
       { n = G.UIT.T, config = { text = "REQUIRES RESTART", colour = G.C.RED, scale = 0.6 }}
      }},
      create_toggle {
        label = "Gigantic Sticker",
        active_colour = HEX("40C67D"),
        ref_table = stakesredux.config,
        ref_value = "gigantic_sticker"
      },
      create_toggle {
        label = "Yellow Stake",
        active_colour = HEX("40C67D"),
        ref_table = stakesredux.config,
        ref_value = "yellow_stake"
      },
      create_toggle {
        label = "Platinum Stake",
        active_colour = HEX("40C67D"),
        ref_table = stakesredux.config,
        ref_value = "platinum_stake"
      },
      create_option_cycle {
        label = "Pink Stake",
        scale = 0.8,
        w = 6,
        options = { "Enabled", "Disabled (new White Stake)", "Disabled (vanilla White Stake)" },
        opt_callback = "update_pink_stake",
        current_option = stakesredux.config.pink_stake
      },
      create_option_cycle {
        label = "Sticker Stakes",
        scale = 0.8,
        w = 6,
        options = { "Separate Stakes", "Stickers on White Stake", "Stickers on Gold Stake" },
        opt_callback = "update_sticker_stakes",
        current_option = stakesredux.config.sticker_stakes
      }
    }
  }
end

G.FUNCS.update_pink_stake = function(e)
  stakesredux.config.pink_stake = e.to_key
end

G.FUNCS.update_sticker_stakes = function(e)
  stakesredux.config.sticker_stakes = e.to_key
end

-- ts fucked up man
local buildModtag_ref = buildModtag
buildModtag = function(mod)
  local ret = buildModtag_ref(mod)
  local atlas_key = getModtagInfo(mod)
  if atlas_key == "srdx_modicon" then
    ret.nodes[1].config.object.draw = function(_sprite)
      _sprite.ARGS.send_to_shader = _sprite.ARGS.send_to_shader or {}
      _sprite.ARGS.send_to_shader[1] = math.min(_sprite.VT.r*3, 1) + G.TIMERS.REAL/(18) + (_sprite.juice and _sprite.juice.r*20 or 0) + 1
      _sprite.ARGS.send_to_shader[2] = G.TIMERS.REAL

      Sprite.draw_shader(_sprite, 'dissolve')
      Sprite.draw_shader(_sprite, 'voucher', nil, _sprite.ARGS.send_to_shader)
    end
  end
  return ret
end
