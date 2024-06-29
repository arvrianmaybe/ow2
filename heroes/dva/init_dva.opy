#!mainFile "../../main.opy"

#!include "heroes/dva/booster.opy"
#!include "heroes/dva/bomb.opy"
#!include "heroes/dva/hp.opy"

rule "[dva/init.opy]: Initialize DVa":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.call_init
    
    newHero(DVA_HEALTH,DVA_ARMOR, 0)
    setUltCost(DVA_ULT_COST)
    removePassiveHealing()

rule "[hero_switch.opy]: Detect switch to Dva":
     @Event eachPlayer
    @Hero dva
    @Condition eventPlayer._hero_switched
    
    eventPlayer.call_init = true    
