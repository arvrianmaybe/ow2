#!mainFile "../main.opy"

rule "[venture/explorer_resolve.opy]: remove explore resolve passive":
    @Hero venture
    @Event eachPlayer
    @Condition eventPlayer.getHealthOfType(Health.SHIELDS) == true
    
    damage(eventPlayer, null, 1)
    wait(0.016, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START