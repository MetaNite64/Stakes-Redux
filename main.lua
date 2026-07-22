--[[
STAKES REDUX
- by metanite64

A mod that adds a separate branch of stakes dedicated to stickers,
and reworks most of the vanilla stakes.
--]]

SMODS.Atlas {
  key = "stakes",
  px = 29, py = 29,
  path = "stakes.png"
}

SMODS.Atlas {
  key = "stickers",
  px = 71, py = 95,
  path = "stickers.png"
}

loc_colour()
G.C.SRDX_PINK = HEX("FDBDBF")
G.C.SRDX_CYAN = HEX("0ACAFF")
G.C.SRDX_TANZANITE = HEX("C75985")
G.C.SRDX_SAPPHIRE = HEX("687EE7")
G.C.SRDX_CITRINE = HEX("E3B448")
G.C.SRDX_EMERALD = HEX("5FAD26")
G.C.SRDX_OBSIDIAN = HEX("4F4F4F")
G.C.SRDX_BIXBITE = HEX("A10000")
G.C.SRDX_PLATINUM = HEX("B8B8E1")

G.ARGS.LOC_COLOURS["srdx_pink"] = G.C.SRDX_PINK
G.ARGS.LOC_COLOURS["srdx_cyan"] = G.C.SRDX_CYAN
G.ARGS.LOC_COLOURS["srdx_tanzanite"] = G.C.SRDX_TANZANITE
G.ARGS.LOC_COLOURS["srdx_sapphire"] = G.C.SRDX_SAPPHIRE
G.ARGS.LOC_COLOURS["srdx_citrine"] = G.C.SRDX_CITRINE
G.ARGS.LOC_COLOURS["srdx_emerald"] = G.C.SRDX_EMERALD
G.ARGS.LOC_COLOURS["srdx_obsidian"] = G.C.SRDX_OBSIDIAN
G.ARGS.LOC_COLOURS["srdx_bixbite"] = G.C.SRDX_BIXBITE
G.ARGS.LOC_COLOURS["srdx_platinum"] = G.C.SRDX_PLATINUM

SMODS.current_mod.optional_features = function()
  return {
    cardareas = {
      discard = true,
      deck = true
    },
    post_trigger = true
  }
end

assert(SMODS.load_file("ui/modbadge.lua"))()
assert(SMODS.load_file("ui/config.lua"))()
if SMODS.current_mod.config.sticker_stakes == 3 then
  assert(SMODS.load_file("ui/runselect.lua"))()
end

if SMODS.current_mod.config.sticker_stakes == 1 or SMODS.current_mod.config.sticker_stakes == 2 then
  assert(SMODS.load_file("stakes/tanzanite.lua"))()
  assert(SMODS.load_file("stakes/sapphire.lua"))()
  assert(SMODS.load_file("stakes/citrine.lua"))()
end
if SMODS.current_mod.config.gigantic_sticker then
  assert(SMODS.load_file("stakes/emerald.lua"))()
end
if SMODS.current_mod.config.blighted_sticker then
  assert(SMODS.load_file("stakes/obsidian.lua"))()
end
if SMODS.current_mod.config.traitorous_sticker then
  assert(SMODS.load_file("stakes/bixbite.lua"))()
end

assert(SMODS.load_file("stakes/white.lua"))()
assert(SMODS.load_file("stakes/pink.lua"))()
assert(SMODS.load_file("stakes/red.lua"))()
assert(SMODS.load_file("stakes/orange.lua"))()
if SMODS.current_mod.config.yellow_stake then
  assert(SMODS.load_file("stakes/yellow.lua"))()
end
assert(SMODS.load_file("stakes/green.lua"))()
if SMODS.current_mod.config.cyan_stake then
  assert(SMODS.load_file("stakes/cyan.lua"))()
end
assert(SMODS.load_file("stakes/blue.lua"))()
assert(SMODS.load_file("stakes/purple.lua"))()
assert(SMODS.load_file("stakes/black.lua"))()

assert(SMODS.load_file("stakes/gold.lua"))()
if SMODS.current_mod.config.platinum_stake then
  assert(SMODS.load_file("stakes/platinum.lua"))()
end

if next(SMODS.find_mod("MoreFluff")) then
  assert(SMODS.load_file("crossmod/morefluff.lua"))()
end
