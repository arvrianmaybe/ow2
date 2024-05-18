#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/brigitte/shield_bash.opy"
#!include "heroes/brigitte/inspire.opy"

rule "[brigitte/init.opy]: Detect switch to Brigitte":
    @Event eachPlayer
    @Hero brigitte

    eventPlayer.call_init = true


rule "[brigitte/init.opy]: Initialize Brigitte":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer.call_init == true
    
    newHero(BRIGITTE_HEALTH, BRIGITTE_HEALTH_ARMOR, 0)
    setUltCost(BRIGITTE_ULT_COST)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.startScalingSize(1.2, true)

    removePassiveHealing()
    
    eventPlayer.call_init = false
