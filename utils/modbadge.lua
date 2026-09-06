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
