#!mainFile "../main.opy"

rule "[junkrat/tire.opy]: kill player if tire":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.isUsingUltimate()

    wait(OW2_JUNKRAT_RIP_TIRE_CAST_TIME, Wait.ABORT_WHEN_FALSE)
    kill(eventPlayer,eventPlayer)