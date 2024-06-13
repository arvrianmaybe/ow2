#!mainFile "../main.opy"

#!include "heroes/doomfist/punch.opy"
#!include "heroes/doomfist/meteor.opy"
#!include "heroes/doomfist/uppercut.opy"
#!include "heroes/doomfist/slam.opy"
#!include "heroes/doomfist/cannon.opy"

rule "[doomfist/init_doomfist.opy] init doomfist":
    @Event eachPlayer
    @Hero doomfist
    # @Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(DOOMFIST_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(DOOMFIST_ULT_COST)
    #eventPlayer.hp_health = 375
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to doomfist":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
