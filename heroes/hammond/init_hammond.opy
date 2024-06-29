#!mainFile "../../main.opy"

#!include "heroes/hammond/shields.opy"
#!include "heroes/hammond/grapple.opy"

rule "[hammond/init.opy]: Detect switch to Wrecking Ball":
    @Event eachPlayer
    @Hero hammond

    eventPlayer.call_init = true


rule "[hammond/init.opy]: Initialize Wrecking Ball":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.call_init

    newHero(WRECKING_BALL_HEALTH, WRECKING_BALL_ARMOR, WRECKING_BALL_SHIELDS)
    setUltCost(WRECKING_BALL_ULT_COST)
    removeTankPassive()
    removePassiveHealing()

    eventPlayer.call_init = false
