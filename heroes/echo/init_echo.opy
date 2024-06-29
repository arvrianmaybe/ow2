#!mainFile "../main.opy"

#!include "heroes/echo/duplicate.opy"

rule "[echo/init_echo.opy] init echo":
    @Event eachPlayer
    @Hero echo
    
    defaultHero()
    newHero(ECHO_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(ECHO_ULT_COST)

rule "[hero_switch.opy]: Detect switch to echo":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
