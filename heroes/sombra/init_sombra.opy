#!mainFile "../main.opy"
#!include "heroes/sombra/hack.opy"
#!include "heroes/sombra/stealth.opy"

rule "[sombra/init_sombra.opy] init sombra":
    @Event eachPlayer
    @Hero sombra
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(SOMBRA_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(SOMBRA_ULT_COST)
    eventPlayer.disallowButton(Button.ABILITY_1)

    eventPlayer.is_using_stealth = false

rule "[hero_switch.opy]: Detect switch to sombra":
    @Event eachPlayer
    @Hero sombra
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    

rule "[sombra/init.opy]: Clean up Sombra":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.SOMBRA
    
    waitUntil(eventPlayer.getCurrentHero() != Hero.SOMBRA, Math.INFINITY)
    exitStealth()