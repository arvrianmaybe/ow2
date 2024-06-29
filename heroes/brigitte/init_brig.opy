#!mainFile "../../main.opy"

#!include "heroes/brigitte/shield_bash.opy"

rule "[brigitte/init.opy]: Detect switch to Brigitte":
    @Event eachPlayer
    @Hero brigitte

    eventPlayer.call_init = true


rule "[brigitte/init.opy]: Initialize Brigitte":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.call_init == true
    
    newHero(BRIGITTE_HEALTH, BRIGITTE_HEALTH_ARMOR, 0)
    setUltCost(BRIGITTE_ULT_COST)

    removePassiveHealing()
    
    eventPlayer.call_init = false
