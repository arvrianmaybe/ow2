#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/winston/leap.opy"
#!include "heroes/winston/primal.opy"
##!include "heroes/winston/shatter.opy"

rule "[winston/init_winston.opy] init winston":
    @Event eachPlayer
    @Hero winston
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(WINSTON_HEALTH, WINSTON_ARMOR, 0)
    removePassiveHealing()
    eventPlayer.setSecondaryFireEnabled(false) #no sniper monkey
    #eventPlayer.hp_health = 200
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to winston":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    