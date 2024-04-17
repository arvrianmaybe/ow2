#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/ashe/coach_gun.opy"

rule "[ashe/init_ashe.opy] init ashe":
    @Event eachPlayer
    @Hero ashe
   # @Condition eventPlayer.call_init == true
    
    defaultHero()
    #eventPlayer.hp_health = 200
    #applyCustomHealth()
    newHero(ASHE_HEALTH, 0, 0)
    setUltCost(ASHE_ULT_COST)
    removePassiveHealing()

rule "[hero_switch.opy]: Detect switch to ashe":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    