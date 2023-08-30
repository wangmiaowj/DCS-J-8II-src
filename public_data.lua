Pylons = {

    pylon(1, 0, 0, 0, 0,
        {
            FiX = 0,
            FiY = 0,
            FiZ = 0,
            use_full_connector_position = true,
        },
        {

            --/N/ ROCKETS
            { CLSID = "{UB-16_S5M}", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "{UB-16_S5M}" } } } }, -- UB-16 S-5M
            { CLSID = "DIS_RKT_90_UG", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "DIS_RKT_90_UG" } } } }, -- S-24B ED
            { CLSID = "DIS_BRM1_90", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "DIS_BRM1_90" } } } }, -- S-24A

            --/N/ BOMBS
            { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", connector = "pylon001",
                required = { { station = 7, loadout = { "{FB3CE165-BF07-4979-887C-92B87F13276B}" } } } ,arg = 309, arg_value = 0.5}, -- FAB-100
            { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", connector = "pylon001",
                required = { { station = 7, loadout = { "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" } } } ,arg = 309, arg_value = 0.5}, -- FAB-250
            { CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}", connector = "pylon001",
                required = { { station = 7, loadout = { "{4203753F-8198-4E85-9924-6F8FF679F9FF}" } } } ,arg = 309, arg_value = 0.5}, -- RBK-250 PTAB
            { CLSID = "{FAB-250-M54-TU}", connector = "pylon001",
                required = { { station = 7, loadout = { "{FAB-250-M54-TU}" } } } ,arg = 309, arg_value = 0.5},
            { CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}", connector = "pylon001",
                required = { { station = 7, loadout = { "{0511E528-EA28-4caf-A212-00D1408DF10A}" } } } ,arg = 309, arg_value = 0.5}, --SAB-100

            --/N/ MISSILES


            { CLSID = "{Aspide_MK1}", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "{Aspide_MK1}" } } } },
            { CLSID = "DIS_PL-5EII", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "DIS_PL-5EII" } } } },
            { CLSID = "DIS_PL-8A", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "DIS_PL-8A" } } } },
            { CLSID = "DIS_PL-12", connector = "pylon001", arg = 309, arg_value = 0.0,
                required = { { station = 7, loadout = { "DIS_PL-12" } } } },

            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon001", arg = 309, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon001", arg = 309, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon001", arg = 309, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon001", arg = 309, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon001", arg = 309, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon001", arg = 309, arg_value = 0.5 },

            { CLSID = "<CLEAN>", connector = "pylon001", arg = 309, arg_value = 1.0,
                required = { { station = 7, loadout = { "<CLEAN>" } } } },
        }
    ),

    pylon(2, 1, 0, 0, 0,
        {
            FiZ = 0,
            use_full_connector_position = true,
        },
        {
            --/N/ ROCKETS
            { CLSID = "{UB-16_S5M}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{UB-16_S5M}" } } } },
            { CLSID = "{UB-32_S5M}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{UB-32_S5M}" } } } },
            --{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "pylon002",arg = 310,arg_value = 0.5}, -- S-24B ED
            { CLSID = "DIS_RKT_90_UG", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_RKT_90_UG" } } } }, -- S-24B ED
            { CLSID = "DIS_BRM1_90", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_BRM1_90" } } } }, -- S-24A

            --/N/ BOMBS
            --{ CLSID = "{5A1AC2B4-CA4B-4D09-A1AF-AC52FBC4B60B}",connector = "pylon002",arg = 310,arg_value = 0.5}, -- MER 4xFAB-100
            { CLSID = "{FAB-100-4}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{FAB-100-4}" } } } }, -- MER 4xFAB-100 arg = 318 small doors
            { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{FB3CE165-BF07-4979-887C-92B87F13276B}" } } } }, -- FAB-100
            { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" } } } }, -- FAB-250
            { CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{37DCC01E-9E02-432F-B61D-10C166CA2798}" } } } }, -- FAB-500 M62
            { CLSID = "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}" } } } }, -- BetAB-500
            { CLSID = "{BD289E34-DF84-4C5E-9220-4B14C346E79D}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{BD289E34-DF84-4C5E-9220-4B14C346E79D}" } } } }, -- BetAB-500ShP
            { CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{4203753F-8198-4E85-9924-6F8FF679F9FF}" } } } }, -- RBK-250 PTAB
            { CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{D5435F26-F120-4FA3-9867-34ACE562EF1B}" } } } }, -- RBK-500 PTAB-10-5
            { CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}" } } } }, -- BL.755
            { CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{0511E528-EA28-4caf-A212-00D1408DF10A}" } } } }, --SAB-100

            -- Tanks
            { CLSID = "DIS_TANK1100", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_TANK1100" } } } },

            --/N/ MISSILES
            { CLSID = "{Aspide_MK1}", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "{Aspide_MK1}" } } } },
            { CLSID = "DIS_PL-5EII", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_PL-5EII" } } } },
            { CLSID = "DIS_PL-8A", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_PL-8A" } } } },
            { CLSID = "DIS_PL-12", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_PL-12" } } } },
            { CLSID = "DIS_LD-10", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_LD-10" } } } },
            { CLSID = "DIS_LD-10_DUAL_L", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_LD-10_DUAL_R" } } } },
            { CLSID = "DIS_C-802AK", connector = "pylon002", arg = 310, arg_value = 0.0,
                required = { { station = 6, loadout = { "DIS_C-802AK" } } } },
            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon002", arg = 310, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon002", arg = 310, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon002", arg = 310, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon002", arg = 310, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon002", arg = 310, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon002", arg = 310, arg_value = 0.5 },

            { CLSID = "<CLEAN>", connector = "pylon002", arg = 310, arg_value = 1.0,
                required = { { station = 6, loadout = { "<CLEAN>" } } } },
        }
    ),
    pylon(3, 1, 0, 0, 0,
        {
            FiZ = 0,
            use_full_connector_position = true,
        },
        {
            --/N/ ROCKETS
            { CLSID = "{UB-16_S5M}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{UB-16_S5M}" } } } },
            { CLSID = "{UB-32_S5M}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{UB-32_S5M}" } } } },
            --{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "pylon003",arg = 311,arg_value = 0.5}, -- S-24B ED
            { CLSID = "DIS_RKT_90_UG", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_RKT_90_UG" } } } },
            { CLSID = "DIS_BRM1_90", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_BRM1_90" } } } },

            --/N/ BOMBS
            --{ CLSID = "{5A1AC2B4-CA4B-4D09-A1AF-AC52FBC4B60B}",connector = "pylon003",arg = 311,arg_value = 0.5}, -- MER 4xFAB-100
            { CLSID = "{FAB-100-4}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{FAB-100-4}" } } } }, -- MER 4xFAB-100 arg = 318 small doors
            { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{FB3CE165-BF07-4979-887C-92B87F13276B}" } } } }, -- FAB-100
            { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" } } } }, -- FAB-250
            { CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{37DCC01E-9E02-432F-B61D-10C166CA2798}" } } } }, -- FAB-500 M62
            { CLSID = "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}" } } } }, -- BetAB-500
            { CLSID = "{BD289E34-DF84-4C5E-9220-4B14C346E79D}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{BD289E34-DF84-4C5E-9220-4B14C346E79D}" } } } }, -- BetAB-500ShP
            { CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{4203753F-8198-4E85-9924-6F8FF679F9FF}" } } } }, -- RBK-250 PTAB
            { CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{D5435F26-F120-4FA3-9867-34ACE562EF1B}" } } } }, -- RBK-500 PTAB-10-5
            { CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}" } } } }, -- BL.755
            { CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{0511E528-EA28-4caf-A212-00D1408DF10A}" } } } }, --SAB-100

            --/N/ MISSILES
            { CLSID = "{Aspide_MK1}", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "{Aspide_MK1}" } } } },
            { CLSID = "DIS_PL-5EII", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_PL-5EII" } } } },
            { CLSID = "DIS_PL-8A", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_PL-8A" } } } },
            { CLSID = "DIS_PL-12", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_PL-12" } } } },
            { CLSID = "DIS_LD-10", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_LD-10" } } } },
            { CLSID = "DIS_LD-10_DUAL_L", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_LD-10_DUAL_R" } } } },
            { CLSID = "DIS_C-802AK", connector = "pylon003", arg = 311, arg_value = 0.0,
                required = { { station = 5, loadout = { "DIS_C-802AK" } } } },
            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon003", arg = 311, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon003", arg = 311, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon003", arg = 311, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon003", arg = 311, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon003", arg = 311, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon003", arg = 311, arg_value = 0.5 },

            { CLSID = "<CLEAN>", connector = "pylon003", arg = 311, arg_value = 1.0 ,
            required = { { station = 5, loadout = { "<CLEAN>" } } } }
        }
    ),
    pylon(4, 1, 0, 0, 0,
        {
            FiZ = -1.2,
            use_full_connector_position = true,
        },
        {
            --/N/ BOMBS
            { CLSID = "{RN-24}", connector = "pylon004", arg = 312, arg_value = 0.0, }, --"nuclear" 10KT
            { CLSID = "{RN-28}", connector = "pylon004", arg = 312, arg_value = 0.0, }, --"nuclear" 1KT
            { CLSID = "{LSWM_AA}", connector = "pylon004", arg = 312, arg_value = 0.0, }, --"nuclear" 1KT
            { CLSID = "{LSWM_AS}", connector = "pylon004", arg = 312, arg_value = 0.0, }, --"nuclear" 1KT
            { CLSID = "{LSWM_AG}", connector = "pylon004", arg = 312, arg_value = 0.0, }, --"nuclear" 1KT
            --/N/ FUEL TANKS
            { CLSID = "DIS_TANK800", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "DIS_TANK800_EMPTY", connector = "pylon004", arg = 312, arg_value = 0.0, },
            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon004", arg = 312, arg_value = 0.5 },
            { CLSID = "<CLEAN>", connector = "pylon004", arg = 312, arg_value = 1.0 },

        }
    ),

    pylon(5, 1, 0, 0, 0,
        {
            FiZ = 0,
            use_full_connector_position = true,
        },
        {
            --/N/ ROCKETS
            { CLSID = "{UB-16_S5M}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{UB-16_S5M}" } } } },
            { CLSID = "{UB-32_S5M}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{UB-32_S5M}" } } } },
            --{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "pylon005",arg = 311,arg_value = 0.5}, -- S-24B ED
            { CLSID = "DIS_RKT_90_UG", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_RKT_90_UG" } } } }, -- S-24B ED
            { CLSID = "DIS_BRM1_90", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_BRM1_90" } } } }, -- S-24A

            --/N/ BOMBS
            --{ CLSID = "{5A1AC2B4-CA4B-4D09-A1AF-AC52FBC4B60B}",connector = "pylon005",arg = 311,arg_value = 0.5}, -- MER 4xFAB-100
            { CLSID = "{FAB-100-4}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{FAB-100-4}" } } } }, -- MER 4xFAB-100 arg = 319 small doors
            { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{FB3CE165-BF07-4979-887C-92B87F13276B}" } } } }, -- FAB-100
            { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" } } } }, -- FAB-250
            { CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{37DCC01E-9E02-432F-B61D-10C166CA2798}" } } } }, -- FAB-500
            { CLSID = "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}" } } } }, -- BetAB-500
            { CLSID = "{BD289E34-DF84-4C5E-9220-4B14C346E79D}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{BD289E34-DF84-4C5E-9220-4B14C346E79D}" } } } }, -- BetAB-500ShP
            { CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{4203753F-8198-4E85-9924-6F8FF679F9FF}" } } } }, -- RBK-250
            { CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{D5435F26-F120-4FA3-9867-34ACE562EF1B}" } } } }, -- RBK-500AO
            { CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}" } } } }, -- BL.755
            { CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{0511E528-EA28-4caf-A212-00D1408DF10A}" } } } }, --SAB-100

            --/N/ MISSILES
            { CLSID = "{Aspide_MK1}", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "{Aspide_MK1}" } } } },
            { CLSID = "DIS_PL-5EII", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_PL-5EII" } } } },
            { CLSID = "DIS_PL-8A", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_PL-8A" } } } },
            { CLSID = "DIS_PL-12", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_PL-12" } } } },
            { CLSID = "DIS_LD-10_DUAL_R", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_LD-10_DUAL_L" } } } },
            { CLSID = "DIS_LD-10", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_LD-10" } } } },
            { CLSID = "DIS_C-802AK", connector = "pylon005", arg = 313, arg_value = 0.0,
                required = { { station = 3, loadout = { "DIS_C-802AK" } } } },
            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon005", arg = 313, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon005", arg = 313, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon005", arg = 313, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon005", arg = 313, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon005", arg = 313, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon005", arg = 313, arg_value = 0.5 },
            { CLSID = "<CLEAN>", connector = "pylon005", arg = 313, arg_value = 1.0,
            required = { { station = 3, loadout = { "<CLEAN>" } } }  },

        }
    ),

    pylon(6, 1, 0, 0, 0,
        {
            FiZ = 0,
            use_full_connector_position = true,
        },
        {
            --/N/ ROCKETS
            { CLSID = "{UB-16_S5M}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{UB-16_S5M}" } } } },
            { CLSID = "{UB-32_S5M}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{UB-32_S5M}" } } } },
            --{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "pylon006",arg = 311,arg_value = 0.5}, -- S-24B ED
            { CLSID = "DIS_RKT_90_UG", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_RKT_90_UG" } } } }, -- S-24B ED
            { CLSID = "DIS_BRM1_90", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_BRM1_90" } } } }, -- S-24A

            --/N/ BOMBS
            --{ CLSID = "{5A1AC2B4-CA4B-4D09-A1AF-AC52FBC4B60B}",connector = "pylon006",arg = 311,arg_value = 0.5}, -- MER 4xFAB-100
            { CLSID = "{FAB-100-4}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{FAB-100-4}" } } } }, -- MER 4xFAB-100 arg = 319 small doors
            { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{FB3CE165-BF07-4979-887C-92B87F13276B}" } } } }, -- FAB-100
            { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" } } } }, -- FAB-250
            { CLSID = "{37DCC01E-9E02-432F-B61D-10C166CA2798}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{37DCC01E-9E02-432F-B61D-10C166CA2798}" } } } }, -- FAB-500
            { CLSID = "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{35B698AC-9FEF-4EC4-AD29-484A0085F62B}" } } } }, -- BetAB-500
            { CLSID = "{BD289E34-DF84-4C5E-9220-4B14C346E79D}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{BD289E34-DF84-4C5E-9220-4B14C346E79D}" } } } }, -- BetAB-500ShP
            { CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{4203753F-8198-4E85-9924-6F8FF679F9FF}" } } } }, -- RBK-250
            { CLSID = "{D5435F26-F120-4FA3-9867-34ACE562EF1B}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{D5435F26-F120-4FA3-9867-34ACE562EF1B}" } } } }, -- RBK-500AO
            { CLSID = "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{08164777-5E9C-4B08-B48E-5AA7AFB246E2}" } } } }, -- BL.755
            { CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{0511E528-EA28-4caf-A212-00D1408DF10A}" } } } }, --SAB-100

            -- Tanks
            { CLSID = "DIS_TANK1100", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_TANK1100" } } } },
            --/N/ MISSILES
            { CLSID = "{Aspide_MK1}", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "{Aspide_MK1}" } } } },
            { CLSID = "DIS_PL-5EII", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_PL-5EII" } } } },
            { CLSID = "DIS_PL-8A", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_PL-8A" } } } },
            { CLSID = "DIS_PL-12", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_PL-12" } } } },
            { CLSID = "DIS_LD-10_DUAL_R", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_LD-10_DUAL_L" } } } },
            { CLSID = "DIS_LD-10", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_LD-10" } } } },
            { CLSID = "DIS_C-802AK", connector = "pylon006", arg = 314, arg_value = 0.0,
                required = { { station = 2, loadout = { "DIS_C-802AK" } } } },
            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon006", arg = 314, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon006", arg = 314, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon006", arg = 314, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon006", arg = 314, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon006", arg = 314, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon006", arg = 314, arg_value = 0.5 },
            { CLSID = "<CLEAN>", connector = "pylon006", arg = 314, arg_value = 1.0 ,
            required = { { station = 2, loadout = { "<CLEAN>" } } } },

        }
    ),

    pylon(7, 0, 0, 0, 0,
        {
            FiZ = 0,
            use_full_connector_position = true,
        },
        {
            --/N/ ROCKETS
            { CLSID = "{UB-16_S5M}", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "{UB-16_S5M}" } } } }, -- UB-16 S-5M
            --test --{ CLSID = "{UB-32_S5M}",connector = "pylon007",arg = 312,arg_value = 0.5},
            --{ CLSID = "{3858707D-F5D5-4bbb-BDD8-ABB0530EBC7C}",connector = "pylon007",arg = 312,arg_value = 0.5}, -- S-24B ED
            { CLSID = "DIS_RKT_90_UG", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "DIS_RKT_90_UG" } } } }, -- S-24B ED
            { CLSID = "DIS_BRM1_90", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "DIS_BRM1_90" } } } }, -- S-24A

            --/N/ BOMBS
            { CLSID = "{FB3CE165-BF07-4979-887C-92B87F13276B}", connector = "pylon007",
                required = { { station = 1, loadout = { "{FB3CE165-BF07-4979-887C-92B87F13276B}" } } } ,arg = 315, arg_value = 0.5}, -- FAB-100
            { CLSID = "{3C612111-C7AD-476E-8A8E-2485812F4E5C}", connector = "pylon007",
                required = { { station = 1, loadout = { "{3C612111-C7AD-476E-8A8E-2485812F4E5C}" } } } ,arg = 315, arg_value = 0.5}, -- FAB-250
            { CLSID = "{4203753F-8198-4E85-9924-6F8FF679F9FF}", connector = "pylon007",
                required = { { station = 1, loadout = { "{4203753F-8198-4E85-9924-6F8FF679F9FF}" } } } ,arg = 315, arg_value = 0.5}, -- RBK-250 PTAB
            --{ CLSID = "{40A24F07-CD7D-4F83-89A2-39B2258B62C6}",connector = "pylon007"},-- PB-250 /not appearing, not in ED repo/
            { CLSID = "{FAB-250-M54-TU}", connector = "pylon007",
                required = { { station = 1, loadout = { "{FAB-250-M54-TU}" } } } ,arg = 315, arg_value = 0.5},
            { CLSID = "{0511E528-EA28-4caf-A212-00D1408DF10A}", connector = "pylon007",
                required = { { station = 1, loadout = { "{0511E528-EA28-4caf-A212-00D1408DF10A}" } } } ,arg = 315, arg_value = 0.5}, --SAB-100

            { CLSID = "{Aspide_MK1}", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "{Aspide_MK1}" } } } },
            { CLSID = "DIS_PL-5EII", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "DIS_PL-5EII" } } } },
            { CLSID = "DIS_PL-8A", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "DIS_PL-8A" } } } },
            { CLSID = "DIS_PL-12", connector = "pylon007", arg = 315, arg_value = 0.0,
                required = { { station = 1, loadout = { "DIS_PL-12" } } } },
            --SMOKE
            { CLSID = "DIS_SMOKE_GENERATOR_R", connector = "pylon007", arg = 315, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_G", connector = "pylon007", arg = 315, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_B", connector = "pylon007", arg = 315, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_Y", connector = "pylon007", arg = 315, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_W", connector = "pylon007", arg = 315, arg_value = 0.5 },
            { CLSID = "DIS_SMOKE_GENERATOR_O", connector = "pylon007", arg = 315, arg_value = 0.5 },
            { CLSID = "<CLEAN>", connector = "pylon007", arg = 315, arg_value = 1.0 ,
            required = { { station = 1, loadout = { "<CLEAN>" } } } },
        }
    )

}