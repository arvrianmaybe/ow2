#!mainFile "../main.opy"

##!include "heroes/sombra/emp.opy"
##!include "heroes/sombra/hack.opy"
##!include "heroes/sombra/stealth.opy"
##!include "heroes/sombra/translocator.opy"


rule "[sombra/init_sombra.opy] init sombra":
    @Event eachPlayer
    @Hero sombra
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(SOMBRA_HEALTH,0, 0)
    removePassiveHealing()

rule "[hero_switch.opy]: Detect switch to sombra":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
