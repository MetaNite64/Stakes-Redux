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
        { n = G.UIT.R, config = { align = "cm", padding = 0.1 }, nodes = {
            { n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
                create_toggle {
                    label = "Gigantic Sticker",
                    active_colour = HEX("40C67D"),
                    ref_table = stakesredux.config,
                    ref_value = "gigantic_sticker"
                },
                create_toggle {
                    label = "Blighted Sticker",
                    active_colour = HEX("40C67D"),
                    ref_table = stakesredux.config,
                    ref_value = "blighted_sticker"
                },
                create_toggle {
                    label = "Traitorous Sticker",
                    active_colour = HEX("40C67D"),
                    ref_table = stakesredux.config,
                    ref_value = "traitorous_sticker"
                }
            }},
            { n = G.UIT.C, config = { align = "cm", padding = 0.1 }, nodes = {
                create_toggle {
                    label = "Yellow Stake",
                    active_colour = HEX("40C67D"),
                    ref_table = stakesredux.config,
                    ref_value = "yellow_stake"
                },
                create_toggle {
                    label = "Cyan Stake",
                    active_colour = HEX("40C67D"),
                    ref_table = stakesredux.config,
                    ref_value = "cyan_stake"
                },
                create_toggle {
                    label = "Platinum Stake",
                    active_colour = HEX("40C67D"),
                    ref_table = stakesredux.config,
                    ref_value = "platinum_stake"
                }
            }}
        }},
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
