#!mainFile "../../main.opy"

#!include "heroes/ana/sleep.opy"
#!include "heroes/ana/nade.opy"

rule "[ana/init_ana.opy] init ana":
    @Event eachPlayer
    @Hero ana
    
    defaultHero()
    newHero(ANA_HEALTH, 0, 0)
    setUltCost(ANA_ULT_COST)
    removeSelfHealing()

rule "[hero_switch.opy]: Detect switch to ana":
    @Event eachPlayer
    @Hero ana
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
