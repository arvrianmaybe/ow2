#!mainFile "../../main.opy"

#!include "heroes/lifeweaver/parting_gift.opy"

rule "[lifeweaver/init_lifeweaver.opy]: Detect switch to lifeweaver":
    @Event eachPlayer
    @Hero lifeweaver

    eventPlayer.call_init = true


rule "[lifeweaver/init.opy]: Initialize lifeweaver":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.call_init
    
    newHero(LIFEWEAVER_HEALTH, 0, LIFEWEAVER_SHIELD_HP)
    setUltCost(LIFEWEAVER_ULT_COST)

    removePassiveHealing()

    eventPlayer.call_init = false
