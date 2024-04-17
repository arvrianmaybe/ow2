#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/echo/duplicate.opy"

rule "[echo/init_echo.opy] init echo":
    @Event eachPlayer
    @Hero echo
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(ECHO_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(ECHO_ULT_COST)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to echo":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    