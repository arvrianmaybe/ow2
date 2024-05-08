#!include "env/ow_env.opy"

##!obfuscate noRuleFilling noConstantObfuscation

#!suppressWarnings w_type_check w_unsuitable_event

# Game Lobby
#!include "lobby/ow_lobby.opy"

# Constants
#!include "constant/reimagined_constant.opy"
#!include "constant/normal_constant.opy"

# Passives

#!include "passives/tank/knockback.opy"
#!include "passives/tank/ult_charge.opy"
#!include "passives/damage/damage_passive.opy"
#!include "passives/support/self_heal.opy"

# Utilities
#!include "utilities/reset.opy"
#!include "utilities/anti_crash.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "utilities/macro.opy"
#!include "utilities/role_lock.opy"
#!include "utilities/watermark.opy"
#!include "utilities/stat_helper.opy"
#!include "utilities/debug.opy"

# Heroes
#!include "heroes/ana/init_ana.opy"
#!include "heroes/ashe/init_ashe.opy"
#!include "heroes/bastion/init_bastion.opy"
#!include "heroes/baptiste/init_bap.opy"
#!include "heroes/brigitte/init_brig.opy"
#!include "heroes/doomfist/init_doomfist.opy"
#!include "heroes/dva/init_dva.opy"
#!include "heroes/echo/init_echo.opy"
#!include "heroes/genji/init_genji.opy"
#!include "heroes/hanzo/init_hanzo.opy"
#!include "heroes/illari/init_illari.opy"
#!include "heroes/junkerqueen/init_junkerqueen.opy"
#!include "heroes/junkrat/init_junkrat.opy"
#!include "heroes/kiriko/init_kiriko.opy"
#!include "heroes/lifeweaver/init_lifeweaver.opy"
#!include "heroes/lucio/init_lucio.opy"
#!include "heroes/mauga/init_mauga.opy"
#!include "heroes/mccree/init_mccree.opy"
#!include "heroes/mei/init_mei.opy"
#!include "heroes/mercy/init_mercy.opy"
#!include "heroes/moira/init_moira.opy"
#!include "heroes/orisa/init_orisa.opy"
#!include "heroes/pharah/init_pharah.opy"
#!include "heroes/ramattra/init_ramattra.opy"
#!include "heroes/roadhog/init_roadhog.opy"
#!include "heroes/reinhardt/init_reinhardt.opy"
#!include "heroes/reaper/init_reaper.opy"
#!include "heroes/symmetra/init_sym.opy"
#!include "heroes/soldier/init_soldier.opy"
#!include "heroes/sombra/init_sombra.opy"
#!include "heroes/sojourn/init_sojourn.opy"
#!include "heroes/sigma/init_sigma.opy"
#!include "heroes/torbjorn/init_torb.opy"
#!include "heroes/tracer/init_tracer.opy"
#!include "heroes/venture/init_venture.opy"
#!include "heroes/widowmaker/init_widowmaker.opy"
#!include "heroes/winston/init_winston.opy"
#!include "heroes/hammond/init_hammond.opy"
#!include "heroes/zarya/init_zarya.opy"
#!include "heroes/zenyatta/init_zenyatta.opy"

# Damage
##!include "damage/melee.opy"
##!include "damage/headshot.opy"

# Ultimate
##!include "ultimate/ult_charge.opy"
##!include "ultimate/ultimate_cost.opy"
