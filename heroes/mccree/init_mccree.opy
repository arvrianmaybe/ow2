#!mainFile "../../main.opy"

#!include "heroes/mccree/roll.opy"
#!include "heroes/mccree/deadeye.opy"
#!include "heroes/mccree/flashbang.opy"

rule "[mccree/init_mccree.opy] init mccree":
    @Event eachPlayer
    @Hero mccree

    defaultHero()
    newHero(MCCREE_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(MCCREE_ULT_COST)

rule "[hero_switch.opy]: Detect switch to mccree":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
