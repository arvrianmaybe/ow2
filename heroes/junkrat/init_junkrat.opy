#!mainFile "../main.opy"

#!include "heroes/junkrat/bomb.opy"
#!include "heroes/junkrat/tire.opy"

rule "[junkrat/init.opy]: Detect switch to Junkrat":
    @Event eachPlayer
    @Hero junkrat

    eventPlayer.call_init = true

rule "[junkrat/init.opy]: Initialize Junkrat":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.call_init
    
    defaultHero()
    eventPlayer.setMaxHealth(percent((JUNKRAT_HEALTH-JUNKRAT_TIRE_HEALTH)/(OW2_JUNKRAT_HEALTH-OW2_JUNKRAT_TIRE_HEALTH)))
    eventPlayer.addHealthPool(Health.NORMAL, 
                              JUNKRAT_HEALTH - (JUNKRAT_HEALTH-JUNKRAT_TIRE_HEALTH)/(OW2_JUNKRAT_HEALTH-OW2_JUNKRAT_TIRE_HEALTH)*OW2_JUNKRAT_HEALTH, 
                              true, 
                              false)
    setUltCost(JUNKRAT_ULT_COST)
    removePassiveHealing()
    wait()
    eventPlayer.disallowButton(Button.ABILITY_2)

    eventPlayer.call_init = false
