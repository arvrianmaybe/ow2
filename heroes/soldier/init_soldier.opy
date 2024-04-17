#!mainFile "../main.opy"

#!include "heroes/soldier/sprint.opy"
#!include "heroes/soldier/pulse_rifle.opy"
##!include "heroes/soldier/concussive.opy"
##!include "heroes/soldier/barrage.opy"

rule "[soldier/init.opy]: Detect switch to soldier":
    @Event eachPlayer
    @Hero soldier

    eventPlayer.call_init = true


rule "[soldier/init.opy]: Initialize soldier":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.call_init

    newHero(SOLDIER_HEALTH, 0, 0)
    setUltCost(SOLDIER_ULT_COST)
    removePassiveHealing()

    eventPlayer.call_init = false