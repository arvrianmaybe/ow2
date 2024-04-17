#!mainFile "../main.opy"
#!include "heroes/venture/dash.opy"

rule "[venture/init_venture.opy]: Detect switch to venture":
    @Event eachPlayer
    @Hero venture
    #sadly venture isnt out yet completly and also cause the program wont recognize venture

    eventPlayer.call_init = true


rule "[venture/init.opy]: Initialize venture":
    @Event init_venture
    @Hero venture 
    #sadly venture isnt out yet completly and also cause the program wont recognize venture
    #@Condition eventPlayer.call_init

    defaultHero()
    newHero(VENTURE_HEALTH, 0, 0)
    setUltCost(VENTURE_ULT_COST)
    removePassiveHealing()

    eventPlayer.call_init = false