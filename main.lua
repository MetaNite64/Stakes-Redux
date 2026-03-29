--[[
STAKES REDUX
- by metanite64

A mod that adds a separate branch of stakes dedicated to stickers,
and reworks most of the vanilla stakes.
--]]

loc_colour()
G.C.SRDX_PINK = HEX("FDBDBF")
G.C.SRDX_TANZANITE = HEX("C75985")
G.C.SRDX_SAPPHIRE = HEX("687EE7")
G.C.SRDX_CITRINE = HEX("E3B448")

G.ARGS.LOC_COLOURS["srdx_pink"] = G.C.SRDX_PINK
G.ARGS.LOC_COLOURS["srdx_tanzanite"] = G.C.SRDX_TANZANITE
G.ARGS.LOC_COLOURS["srdx_sapphire"] = G.C.SRDX_SAPPHIRE
G.ARGS.LOC_COLOURS["srdx_citrine"] = G.C.SRDX_CITRINE

assert(SMODS.load_file("stakes/pink.lua"))()
assert(SMODS.load_file("stakes/red.lua"))()
assert(SMODS.load_file("stakes/orange.lua"))()
assert(SMODS.load_file("stakes/yellow.lua"))()
assert(SMODS.load_file("stakes/green.lua"))()
assert(SMODS.load_file("stakes/blue.lua"))()
assert(SMODS.load_file("stakes/purple.lua"))()
assert(SMODS.load_file("stakes/black.lua"))()

assert(SMODS.load_file("stakes/tanzanite.lua"))()
assert(SMODS.load_file("stakes/sapphire.lua"))()
assert(SMODS.load_file("stakes/citrine.lua"))()

assert(SMODS.load_file("stakes/gold.lua"))()
