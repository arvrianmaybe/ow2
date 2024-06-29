#!mainFile "../../main.opy"

rule "[venture/init_venture.opy]: Detect switch to venture":
    @Event eachPlayer
    @Hero venture

    eventPlayer.call_init = true


rule "[venture/init_venture.opy]: Initialize venture":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.call_init
    
    newHero(VENTURE_HEALTH, 0, 0)
    setUltCost(VENTURE_ULT_COST)

    removePassiveHealing()

    eventPlayer.call_init = false
