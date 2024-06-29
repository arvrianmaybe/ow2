#!mainFile "../../main.opy"

rule "[tracer/init.opy]: Detect switch to Tracer":
    @Event eachPlayer
    @Hero tracer

    eventPlayer.call_init = true


rule "[tracer/init.opy]: Initialize Tracer":
    @Event eachPlayer
    @Hero tracer

    defaultHero()
    newHero(TRACER_HEALTH, 0, 0)
    setUltCost(TRACER_ULT_COST)
    removePassiveHealing()

    eventPlayer.call_init = false
