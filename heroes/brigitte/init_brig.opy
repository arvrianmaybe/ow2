#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/brigitte/shield_bash.opy"
#!include "heroes/brigitte/inspire.opy"

rule "[brigitte/init_brigitte.opy] init brigitte":
    @Event eachPlayer
    @Hero brigitte
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(BRIGITTE_HEALTH, BRIGITTE_HEALTH_ARMOR, 0)
    setUltCost(BRIGITTE_ULT_COST)
    removePassiveHealing()
    #eventPlayer.hp_health = 150
    #eventPlayer.hp_armour = 50
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to brigitte":
    @Event eachPlayer
    @Hero brigitte
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    