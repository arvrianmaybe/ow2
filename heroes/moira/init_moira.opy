#!mainFile "../main.opy"

#!include "heroes/moira/coalescence.opy"
#!include "heroes/moira/biotic_grasp.opy"


rule "[moira/init_moira.opy]: Detect switch to moira":
    @Event eachPlayer
    @Hero moira

    eventPlayer.call_init = true


rule "[moira/init_moira.opy]: Initialize moira":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.call_init
    
    newHero(MOIRA_HEALTH, 0, 0)
    setUltCost(MOIRA_ULT_COST)