#!mainFile "../../main.opy"

rule "[mauga/init.opy]: Detect switch to Mauga":
    @Event eachPlayer
    @Hero mauga

    eventPlayer.call_init = true


rule "[mauga/init.opy]: Initialize Mauga":
    @Event eachPlayer
    @Hero mauga
    @Condition eventPlayer.call_init
    
    newHero(MAUGA_HEALTH, 0, 0)
    setUltCost(MAUGA_ULT_COST)
    removeTankPassive()
    removePassiveHealing()
    
    eventPlayer.call_init = false
