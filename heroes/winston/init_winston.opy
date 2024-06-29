#!mainFile "../../main.opy"

#!include "heroes/winston/leap.opy"
#!include "heroes/winston/primal.opy"

rule "[winston/init_winston.opy] init winston":
    @Event eachPlayer
    @Hero winston
    
    defaultHero()
    newHero(WINSTON_HEALTH, WINSTON_ARMOR, 0)
    removePassiveHealing()
    eventPlayer.setSecondaryFireEnabled(false) #no sniper monkey

rule "[hero_switch.opy]: Detect switch to winston":
    @Event eachPlayer
    @Hero winston
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
