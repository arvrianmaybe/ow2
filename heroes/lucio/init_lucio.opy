#!mainFile "../../main.opy"

#!include "heroes/lucio/aura.opy"
#!include "heroes/lucio/sound_barrier.opy"

rule "[lucio/init_lucio.opy]: Detect switch to Lucio":
    @Event eachPlayer
    @Hero lucio

    eventPlayer.call_init = true


rule "[lucio/init_lucio.opy]: Initialize Lucio":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.call_init
    
    newHero(LUCIO_HEALTH, 0, 0)
    setUltCost(LUCIO_ULT_COST)
    removePassiveHealing()

    eventPlayer.setKnockbackDealt(percent(LUCIO_SOUNDWAVE_KNOCKBACK/OW2_LUCIO_SOUNDWAVE_KNOCKBACK))

    eventPlayer.call_init = false
