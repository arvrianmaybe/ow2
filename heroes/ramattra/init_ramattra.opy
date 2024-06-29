#!mainFile "../../main.opy"

#!include "heroes/ramattra/nemesis.opy"
#!include "heroes/ramattra/vortex.opy"
##!include "heroes/ramattra/annihilation.opy"

rule "[ramattra/init_ramattra.opy]: Detect switch to ramattra":
    @Event eachPlayer
    @Hero ramattra

    eventPlayer.call_init = true


rule "[ramattra/init_ramattra.opy]: Initialize ramattra":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.call_init
    
    # stopAnnihilation()
    # eventPlayer.ult_duration = ULT_DURATION_WORKSHOP_SETTINGS

    newHero(RAMATTRA_HEALTH, RAMATTRA_ARMOR, 0)
    setUltCost(RAMATTRA_ULT_COST)
    # Below variables are also declared and initialized in reset_hero.opy

    removeTankPassive()
    removePassiveHealing()

    eventPlayer.call_init = false

# rule "[ramattra/init_ramattra.opy] clean up ramattra":
    # @Event eachPlayer
    # @Condition eventPlayer.ult_duration != ULT_DURATION_WORKSHOP_SETTINGS
    # @Condition eventPlayer.isUsingUltimate() != true
    # @Condition eventPlayer.getCurrentHero() == Hero.RAMATTRA
    
    # waitUntil(eventPlayer.getCurrentHero() != Hero.RAMATTRA, Math.INFINITY)
    # stopAnnihilation()`
