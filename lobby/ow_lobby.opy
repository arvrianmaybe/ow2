#!mainFile "../main.opy"
#!include "constant/reimagined_constant.opy"
#!include "utilities/macro.opy"
#!include "constant/normal_constant.opy"

# Environment Variables
#!define GAMEMODE_VERSION "v1.50"
#!define GAMEMODE_NAME "Remastered Overwatch"
#!define GAMEMODE_DESCRIPTION (GAMEMODE_NAME + " " + GAMEMODE_VERSION + "\n" + \
                               "\n" + \
                               "Reimagined Overwatch 2 (FYTZG)" + "\n" + \
                               "old version of this gamemode." + "\n" + \
                               "\n" + \
                               "Main build: " + GAMEMODE_CODE + "\n" + \
                               "Staging build: " + STAGING_CODE + "\n" + \
                               "\n" + \
                               "Gamemode forked from" + "\n" + \
                               "Overwatch 1 Emulator v1.12.2 (KHTG0)" + "\n" + \
                               "by ecksdee#11729" + "\n" + \
                               "\n" + \
                               "Codebase Contributors:" + "\n" + \
                               "viper" + "\n" + \
                               "pepperminthe_" + "\n" + \
                               "highrezolution42#0927" + "\n" + \
                               "ecksdee#4643" + "\n" + \
                               "\n" + \
                               "workshop.codes/remastered" + "\n" + \
                               "\n" + \
                               "Discord:" + "\n" + \
                               DISCORD_SHORT_LINK + "\n" + \
                               DISCORD_LONG_LINK + "\n" + \
                               "\n" + \
                               "Source code:" + "\n" + \
                               "https://shorter.me/Q4Se9")
#!define GAMEMODE_CODE "WS8C5"
#!define STAGING_CODE "KR56M"
#!define DISCORD_SHORT_LINK "dsc.gg/runece"
#!define DISCORD_LONG_LINK "discord.gg/vb5r2gfNTQ"

rule "Copyright (c) 2024 Remastered Overwatch. See https://github.com/arvrianmaybe/ow2 for license to use this code.":
    # this code has been forked by overwatch 1 emulator, please also check theres https://github.com/Overwatch-1-Emulator/ow1-emulator
    disableInspector()

settings {
    "main": {
        "modeName": GAMEMODE_NAME,
        "description": GAMEMODE_DESCRIPTION,
    },
    "lobby": {
        "allowPlayersInQueue": true,
        "mapRotation": "afterGame",
        "enableMatchVoiceChat": true,
        "spectatorSlots": 12,
        "team1Slots": 6,
        "team2Slots": 6,
        "returnToLobby": "never"
    },
    "gamemodes": {
        "assault": {
            "enableCompetitiveRules": true
        },
        "control": {
            "disabledMaps": [
                "lijiangTowerLny"
            ],
            "enableCompetitiveRules": true
        },
        "escort": {
            "enableCompetitiveRules": true
        },
        #"flashpoint": {
            #"controlPointA": false
        #},
        "hybrid": {
            "disabledMaps": [
                "blizzWorldWinter",
                "eichenwaldeHalloween",
                "hollywoodHalloween",
                "kingsRowWinter"
            ],
            "enableCompetitiveRules": true
        },
        "push": {
            "enableCompetitiveRules": true
        },
        "general": {
            "heroLimit": "1PerTeam",
            "roleLimit": "off",
            "gamemodeStartTrigger": "allSlotsFilled",
            "tankPassiveHealthBonus": "alwaysEnabled",
            "enableCompetitiveRules": true
        },
        #"clash": {
            #"heroLimit": "1PerTeam",
            #"roleLimit": "off",
            #"gamemodeStartTrigger": "allSlotsFilled",
            #"tankPassiveHealthBonus": "alwaysEnabled",
            #"enableCompetitiveRules": true
        #},
    },
    "heroes": {
        "allTeams": {
        "ana": {
            "ability1Cooldown%": percent(ANA_SLEEP_DART_COOLDOWN/OW2_ANA_SLEEP_DART_COOLDOWN_TIME),
            "ability2Cooldown%": percent(ANA_BIOTIC_GRENADE_COOLDOWN/OW2_ANA_BIOTIC_GRENADE_COOLDOWN),
            "ultGen%": percent(ANA_ULT_COST/OW2_ANA_ULT_COST)
            },
            "ashe": {
                "ability1EnemyKb%": 0,
                "ability1SelfKb%": 0,
                "health%": percent(ASHE_BOB_HEALTH/OW2_ASHE_BOB_HEALTH), # for BOB hp
                "ultGen%": percent(OW2_ASHE_ULT_COST/ASHE_ULT_COST)
            },
            "baptiste": {
                "health%": percent(BAPTISTE_LAMP_HP/OW2_BAPTISTE_LAMP_HP), # for immortality field hp
                "ability2Cooldown%": percent(BAPTISTE_LAMP_COOLDOWN_TIME/OW2_BAPTISTE_LAMP_COOLDOWN_TIME),
                "ultGen%": percent(OW2_BAPTISTE_ULT_COST/BAPTISTE_ULT_COST)
            },
            "bastion": {
                "ability1Cooldown%": percent(BASTION_SENTRY_COOLDOWN/OW2_BASTION_RECONFIGURE_COOLDOWN),
                #"secondaryFireCooldown%": percent(BASTION_TANK_COOLDOWN/OW2_TACTICAL_GRENADE_COOLDOWN),
                "ultGen%": percent(OW2_BASTION_ULT_COST/BASTION_ULT_COST)
                },
                "mccree": {
                    "ability2Cooldown%": percent(MCCREE_FLASHBANG_COOLDOWN/OW2_MCCREE_FLASHBANG_COOLDOWN),
                    "ultGen%": percent(OW2_MCCREE_ULT_COST/MCCREE_ULT_COST)
                },
            "doomfist": {
                #"ability1ChargeRate%": 10,
                "ammoRegenerationTime%": 162,
                "secondaryFireKb%": 0,
                "ultGen%": percent(OW2_DOOMFIST_ULT_COST/DOOMFIST_ULT_COST)
            },
            "dva": {
                "health%": percent(DVA_PILOT_HEALTH/OW2_DVA_PILOT_HEALTH), # for pilot dva hp
                "secondaryFireMaximumTime%": percent(DVA_MATRIX_DURATION/OW2_DVA_MATRIX_DURATION),
                "ability1Cooldown%": percent(DVA_BOOSTER_COOLDOWN_TIME/OW2_DVA_BOOSTER_COOLDOWN_TIME),
                "ability2Cooldown%": percent(DVA_MICRO_MISSILES_COOLDOWN_TIME/OW2_DVA_MICRO_MISSILES_COOLDOWN_TIME),
                "ultGen%": percent(OW2_DVA_ULT_COST/DVA_ULT_COST)
            },
            "echo": {
                "ultGen%": percent(OW2_ECHO_ULT_COST/ECHO_ULT_COST)
            },
            "genji": {
                "ultGen%": percent(OW2_GENJI_ULT_COST/GENJI_ULT_COST)
            },
            "hanzo": {
                "ability2Cooldown%": percent(HANZO_STORM_COOLDOWN/OW2_HANZO_STORM_COOLDOWN),
                "ultGen%": percent(OW2_HANZO_ULT_COST/HANZO_ULT_COST)
            },
            "junkrat": {
                "ability1Cooldown%": percent(JUNKRAT_CONCUSSION_MINE_COOLDOWN/OW2_JUNKRAT_CONCUSSION_MINE_COOLDOWN),
                "ultGen%": percent(OW2_JUNKRAT_ULT_COST/JUNKRAT_ULT_COST)
            },
            "junkerQueen": {
                "ability1Cooldown%": percent(JUNKERQUEEN_SHOUT_COOLDOWN/OW2_JUNKERQUEEN_SHOUT_COOLDOWN),
                "ultGen%": percent(JUNKERQUEEN_ULT_COST/OW2_JUNKERQUEEN_ULT_COST)
                },
            "kiriko": {
                "ability1Cooldown%": percent(KIRIKO_SWIFT_STEP_COOLDOWN/OW2_KIRIKO_SWIFT_STEP_COOLDOWN),
                "ability2Cooldown%": percent(KIRIKO_SUZU_COOLDOWN/OW2_KIRIKO_SUZU_COOLDOWN),    
                "ultGen%": percent(KIRIKO_ULT_COST/OW2_KIRIKO_ULT_COST)
            },
            "lifeweaver": {
                "health%": percent(LIFEWEAVER_PETAL_HP/OW2_LIFEWEAVER_PETAL_HP), # for petal
                "ultGen%": percent(LIFEWEAVER_ULT_COST/OW2_LIFEWEAVER_ULT_COST)
            },
            "lucio": {
                "ultGen%": percent(LUCIO_ULT_COST/OW2_LUCIO_ULT_COST),
                "ability2Cooldown%": percent(LUCIO_AMP_COOLDOWN/OW2_LUCIO_AMP_COOLDOWN),    
            },
            "illari": {
                "health%": percent(ILLARI_PYLON_HP/OW2_ILLARI_PYLON_HP), #for pylon hp
                "ultGen%": percent(ILLARI_ULT_COST/OW2_ILLARI_ULT_COST),
                "ability1Cooldown%": percent(ILLARI_OUTBURST_COOLDOWN/OW2_ILLARI_OUTBURST_COOLDOWN),
                "ability2Cooldown%": percent(ILLARI_PYLON_COOLDOWN/OW2_ILLARI_PYLON_COOLDOWN)
            },
            "mei": {
                "health%": percent(MEI_ICEWALL_HP/OW2_MEI_ICEWALL_HP), # for icewall
                "ultGen%": percent(OW2_MEI_ULT_COST/MEI_ULT_COST)
            },
            "mercy": {
                "ultGen%": percent(OW2_MERCY_ULT_COST/MERCY_ULT_COST),
                "enablePassive": false
            },
            "mauga": {
                "primaryFireIgniteDamage": 0,
                "primaryFireIgniteDuration": 0,
                "primaryFireIgniteRate": 0,
                "health%": percent(MAUGA_CAGE_FIGHT_HEALTH/OW2_MAUGA_CAGE_FIGHT_HEALTH), # for cage fight
                "ultGen%": percent(MAUGA_ULT_COST/OW2_MAUGA_ULT_COST)
            },
            "moira": {
                "ultGen%": percent(OW2_MOIRA_ULT_COST/MOIRA_ULT_COST),
                "ultDuration%": percent(MOIRA_ULTIMATE_DURATION/OW2_MOIRA_ULT_DURATION),
                "primaryFireMaximumTime%": percent((OW2_MOIRA_HEAL_GRASP_AMMO_USAGE/MOIRA_HEAL_GRASP_AMMO_USAGE)*(MOIRA_HEAL_GRASP_AMMO/OW2_MOIRA_HEAL_GRASP_AMMO)),
            },
            "orisa": {
                "ability2Cooldown%": percent(ORISA_EXTERMINATE_COOLDOWN/OW2_ORISA_JAVELIN_SPIN_COOLDOWN),
                "ultGen%": percent(ORISA_ULT_COST/OW2_ORISA_ULT_COST)
            },
            "pharah": {
                "passiveExtraFuel%": 0,
                "ability1RefuelScalar": 0,
                "ability1Cooldown%": percent(PHARAH_JUMP_JET_COOLDOWN/OW2_PHARAH_JUMP_JET_COOLDOWN),
                "ability2Cooldown%": percent(PHARAH_CONCUSSIVE_BLAST_COOLDOWN/OW2_PHARAH_CONCUSSIVE_BLAST_COOLDOWN),
                "ultGen%": percent(PHARAH_ULT_COST/OW2_PHARAH_ULT_COST)
            },
            "reaper": {
                "ultGen%": percent(REAPER_ULT_COST/OW2_REAPER_ULT_COST)
            },
            "reinhardt": {
                "secondaryFireRechargeRate%": percent(REINHARDT_BARRIER_REGEN/OW2_REINHARDT_BARRIER_REGEN),
                "health%": percent(REINHARDT_BARRIER_HEALTH/OW2_REINHARDT_BARRIER_HEALTH), # for barrier
                "ability1Cooldown%": percent(REINHARDT_CHARGE_COOLDOWN_TIME/OW2_REINHARDT_CHARGE_COOLDOWN_TIME),
                "ultGen%": percent(REINHARDT_ULT_COST/OW2_REINHARDT_ULT_COST)
            },
            "roadhog": {
                "secondaryFireMaximumTime%": percent((ROADHOG_BREATHER_CAST_TIME+ROADHOG_BREATHER_DURATION)/OW2_ROADHOG_BREATHER_DURATION),
                "secondaryFireRechargeRate%": 500,
                "ability2Cooldown%": percent(ROADHOG_BREATHER_COOLDOWN/OW2_ROADHOG_TRAP_COOLDOWN),
                "ultGen%": percent(OW2_ROADHOG_ULT_COST/ROADHOG_ULT_COST)
            },
            "sigma": {
                "secondaryFireRechargeRate%": percent(SIGMA_BARRIER_REGEN/OW2_SIGMA_BARRIER_REGEN),
                "health%": percent(SIGMA_BARRIER_HEALTH/OW2_SIGMA_BARRIER_HEALTH), # for barrier
                "ultGen%": percent(OW2_SIGMA_ULT_COST/SIGMA_ULT_COST),
            },
            "ramattra": {
                "health%": percent(RAMATTRA_BARRIER_HEALTH/OW2_RAMATTRA_BARRIER_HEALTH), # for barrier
                "ability1Cooldown%": percent(RAMATTRA_NEMESIS_COOLDOWN/OW2_RAMATTRA_NEMESIS_COOLDOWN),
                # "enableInfiniteUlt": true, # for old ult
                "ultGen%": percent(RAMATTRA_ULT_COST/OW2_RAMATTRA_ULT_COST),
            },
            "soldier": {
                "ability2Cooldown%": percent(SOLDIER_BIOTIC_FIELD_COOLDOWN/OW2_SOLDIER_BIOTIC_FIELD_COOLDOWN),
                "ultGen%": percent(OW2_SOLDIER_ULT_COST/SOLDIER_ULT_COST)
            },
            "sombra": {
                "secondaryFireCooldown%": percent(SOMBRA_HACK_COOLDOWN_TIME/OW2_SOMBRA_HACK_COOLDOWN_TIME),
                "ultGen%": percent(OW2_SOMBRA_ULT_COST/SOMBRA_ULT_COST)
            },
            "sojourn": {
                "ability1Cooldown%": percent(SOJOURN_POWER_SLIDE_COOLDOWN_TIME/OW2_SOJOURN_POWER_SLIDE_COOLDOWN_TIME),
                "ultGen%": percent(SOJOURN_ULT_COST/OW2_SOJOURN_ULT_COST)
            },
            "symmetra": {
                "health%": percent(SYMMETRA_TURRET_HEALTH/OW2_SYMMETRA_TURRET_HEALTH), # for turret hp
                "ultGen%": percent(OW2_SYMMETRA_ULT_COST/SYMMETRA_ULT_COST)
            },
            "torbjorn": {
                "health%": percent(TORBJORN_TURRET_HEALTH/OW2_TORBJORN_TURRET_HEALTH), # for turret hp
                "ultGen%": percent(OW2_TORBJORN_ULT_COST/TORBJORN_ULT_COST)
            },
            "tracer": {
                "health%": percent(TRACER_HEALTH/OW2_TRACER_HEALTH), # for recall hp
                "ultGen%": percent(OW2_TRACER_ULT_COST/TRACER_ULT_COST)
            },
            "tracer": {
                "health%": percent(TRACER_HEALTH/OW2_TRACER_HEALTH), # for recall hp
                "ultGen%": percent(OW2_TRACER_ULT_COST/TRACER_ULT_COST)
            },
            "venture": {
                "ultGen%": percent(OW2_VENTURE_ULT_COST/VENTURE_ULT_COST)
            },
            "winston": {
                "health%": percent(WINSTON_BARRIER_HEALTH/OW2_WINSTON_BARRIER_HEALTH), # for barrier hp
                "ability1Cooldown%": percent(WINSTON_JUMP_PACK_COOLDOWN_TIME/OW2_WINSTON_JUMP_PACK_COOLDOWN_TIME),
                "ultGen%": percent(OW2_WINSTON_ULT_COST/WINSTON_ULT_COST)
            },
            "hammond": {
                "ability1Kb%": percent(1/OW2_WRECKING_BALL_FIREBALL_KB),
                "ultGen%": percent(OW2_WRECKING_BALL_ULT_COST/WRECKING_BALL_ULT_COST),
                "ability3Cooldown%": percent(WRECKING_BALL_PILEDRIVER_COOLDOWN_TIME/OW2_WRECKING_BALL_PILEDRIVER_COOLDOWN_TIME)
            },
            "zarya": {
                "health%": percent(ZARYA_BARRIER_HEALTH/OW2_ZARYA_BARRIER_HEALTH),
                "ultGen%": percent(ZARYA_ULT_COST/OW2_ZARYA_ULT_COST)
            },
            "zenyatta": {
             "ultGen%": percent(OW2_ZENYATTA_ULT_COST/ZENYATTA_ULT_COST)
             },
             "enabledHeroes": [
                 "ana",
                 "ashe",
                 "baptiste",
                 "bastion",
                 "brigitte",
                 "mccree",
                 "doomfist",
                 "dva",
                 "echo",
                 "genji",
                 "hanzo",
                 "illari",
                 "junkerQueen",
                 "junkrat",
                 "kiriko",
                 "lifeweaver",
                 "lucio",
                 "mauga",
                 "mei",
                 "mercy",
                 "moira",
                 "orisa",
                 "pharah",
                 "ramattra",
                 "reaper",
                 "reinhardt",
                 "roadhog",
                 "sigma",
                 "sojourn",
                 "soldier",
                 "sombra",
                 "symmetra",
                 "torbjorn",
                 "tracer",
                 "venture",
                 "widowmaker",
                 "winston",
                 "hammond",
                 "zarya",
                 "zenyatta",
             ]
         }
     }
 }
