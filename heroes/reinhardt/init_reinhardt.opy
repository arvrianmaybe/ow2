#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/reinhardt/firestrike.opy"
#!include "heroes/reinhardt/hammer.opy"
#!include "heroes/reinhardt/shatter.opy"

rule "[reinhardt/init_reinhardt.opy] init reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(REINHARDT_HEALTH, REINHARDT_ARMOR, 0)
    removePassiveHealing()
    setUltCost(REINHARDT_ULT_COST)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    