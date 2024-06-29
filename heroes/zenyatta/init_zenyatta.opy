#!mainFile "../../main.opy"


rule "[zenyatta/init_zenyatta.opy]: Detect switch to zenyatta":
    @Event eachPlayer
    @Hero zenyatta

    eventPlayer.call_init = true


rule "[zenyatta/init_zenyatta.opy]: Initialize zenyatta":
    @Event eachPlayer
    @Hero zenyatta
    @Condition eventPlayer.call_init

    newHero(ZENYATTA_HEALTH, 0, ZENYATTA_SHIELDS)
    setUltCost(ZENYATTA_ULT_COST)
    removePassiveHealing()

    eventPlayer.setKnockbackDealt(percent(ZENYATTA_KNOCKBACK/OW2_ZENYATTA_KNOCKBACK))
    
    eventPlayer.setAmmo(0, ZENYATTA_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0, ZENYATTA_CLIP_SIZE)

    eventPlayer.call_init = false
