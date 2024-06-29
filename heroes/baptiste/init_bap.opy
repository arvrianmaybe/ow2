#!mainFile "../../main.opy"

#!include "heroes/baptiste/regen_burst.opy"

rule "[baptiste/baptiste.opy] init baptiste":
    @Event eachPlayer
    @Hero baptiste
    
    defaultHero()
    newHero(BAPTISTE_HEALTH, 0, 0)
    setUltCost(BAPTISTE_ULT_COST)
    eventPlayer.setAmmo(0,BAPTISTE_CLIP1_SIZE)
    eventPlayer.setMaxAmmo(0,BAPTISTE_CLIP1_SIZE)
    eventPlayer.setAmmo(1, BAPTISTE_CLIP2_SIZE)
    eventPlayer.setMaxAmmo(1, BAPTISTE_CLIP2_SIZE)
    setBaseDamage(eventPlayer, BAPTISTE_PRIMARY_DAMAGE/OW2_BAPTISTE_PRIMARY_DAMAGE)
    removePassiveHealing()

rule "[hero_switch.opy]: Detect switch to baptiste":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer._hero_switched
               
    eventPlayer.call_init = true    
