#!mainFile "../../main.opy"

#!include "heroes/pharah/rocket_launcher.opy"
#!include "heroes/pharah/concussive.opy"

rule "[pharah/init.opy]: Initialize Pharah":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.call_init

    newHero(PHARAH_HEALTH, 0, 0)
    setUltCost(PHARAH_ULT_COST)
    removePassiveHealing()
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)

    eventPlayer.call_init = false

rule "[pharah/init.opy]: Detect switch to Pharah":
    @Event eachPlayer
    @Hero pharah

    eventPlayer.call_init = true
