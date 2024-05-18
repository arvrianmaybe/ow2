#!mainFile "../main.opy"


rule "[widowmaker/init.opy]: Detect switch to Widowmaker":
    @Event eachPlayer
    @Hero widowmaker

    eventPlayer.call_init = true


rule "[widowmaker/init.opy]: Initialize Widowmaker":
    @Event eachPlayer
    @Hero widowmaker
    @Condition eventPlayer.call_init

    newHero(WIDOWMAKER_HEALTH, 0, 0)
    setUltCost(WIDOWMAKER_ULT_COST)
    removePassiveHealing()

    eventPlayer.call_init = false