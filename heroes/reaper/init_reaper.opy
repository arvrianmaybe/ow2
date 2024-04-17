#!mainFile "../main.opy"

#!include "heroes/reaper/shotgun.opy"
#!include "heroes/reaper/blossom.opy"

rule "[reaper/init.opy]: Detect switch to reaper":
    @Event eachPlayer
    @Hero reaper

    eventPlayer.call_init = true


rule "[reaper/init.opy]: Initialize reaper":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.call_init

    newHero(REAPER_HEALTH, 0, 0)
    setUltCost(REAPER_ULT_COST)
    removePassiveHealing()

    eventPlayer.call_init = false

rule "[init_reaper.opy] reaping gain extra":
    @Event playerDealtDamage
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == false

    heal(eventPlayer, eventPlayer, REAPER_REAPING_EXTRA_HEALS)