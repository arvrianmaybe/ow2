#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/kiriko/kunai.opy"
#!include "heroes/kiriko/wall_climb.opy"
rule "[kiriko/init_kiriko.opy]: Detect switch to Kiriko":
    @Event eachPlayer
    @Hero kiriko

    eventPlayer.call_init = true


rule "[kiriko/init_kiriko.opy]: Initialize Kiriko":
    @Event eachPlayer
    @Hero kiriko
    @Condition eventPlayer.call_init
    
    newHero(KIRIKO_HEALTH, 0, 0)
    setUltCost(KIRIKO_ULT_COST)

    removePassiveHealing()

    eventPlayer.setHealingDealt(percent(KIRKIO_OFUDA_HEALING/OW2_KIRIKO_OFUDA_HEALING))

    eventPlayer.setMaxAmmo(0, 6)
    eventPlayer.setAmmo(0, 12)
    setBaseDamage(eventPlayer, (KIRIKO_KUNAI_HEADSHOT_DAMAGE/OW2_KIRIKO_KUNAI_HEADSHOT_DAMAGE))

    eventPlayer.call_init = false
