#!mainFile "../main.opy"

##!include "heroes/symmetra/nemesis.opy"
#!include "heroes/symmetra/orb.opy"
#!include "heroes/symmetra/teleporter.opy"

rule "[symmetra/init_symmetra.opy]: Detect switch to symmetra":
    @Event eachPlayer
    @Hero symmetra

    eventPlayer.call_init = true


rule "[symmetra/init_symmetra.opy]: Initialize symmetra":
    @Event eachPlayer
    @Hero symmetra
    @Condition eventPlayer.call_init
    
    newHero(SYMMETRA_HEALTH, 0,SYMMETRA_SHIELDS)
    setUltCost(SYMMETRA_ULT_COST)

    removePassiveHealing()

    eventPlayer.disallowButton(Button.SECONDARY_FIRE) # no sniper sym

    eventPlayer.call_init = false
