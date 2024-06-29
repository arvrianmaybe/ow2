#!mainFile "../../main.opy

#!include "heroes/ashe/coach_gun.opy"

rule "[ashe/init_ashe.opy] init ashe":
    @Event eachPlayer
    @Hero ashe
    
    defaultHero()
    newHero(ASHE_HEALTH, 0, 0)
    setUltCost(ASHE_ULT_COST)
    removePassiveHealing()
    eventPlayer.setKnockbackDealt(0) # for shotgun

rule "[hero_switch.opy]: Detect switch to ashe":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
