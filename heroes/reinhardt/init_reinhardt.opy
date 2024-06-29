#!mainFile "../../main.opy"

#!include "heroes/reinhardt/charge.opy"
#!include "heroes/reinhardt/firestrike.opy"
#!include "heroes/reinhardt/hammer.opy"
#!include "heroes/reinhardt/shatter.opy"

rule "[reinhardt/init_reinhardt.opy] init reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    
    defaultHero()
    newHero(REINHARDT_HEALTH, REINHARDT_ARMOR, 0)
    removePassiveHealing()
    setUltCost(REINHARDT_ULT_COST)

rule "[hero_switch.opy]: Detect switch to reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
