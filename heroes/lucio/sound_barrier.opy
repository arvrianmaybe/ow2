#!mainFile "../main.opy"

/*
rule "[sound_barrier.opy]: sound barrier extra overhealth if on ground":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventPlayer.isOnGround()

    wait(OW2_LUCIO_SOUND_BARRIER_CAST_TIME, Wait.ABORT_WHEN_FALSE)
    getPlayersInRadius(eventPlayer.getPosition(), 10, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ENEMY_BARRIERS).addHealthPool(Health.NORMAL, LUCIO_BEAT_OVERHEALTH, false,false)    
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    removeHealthPool(getLastCreatedHealthPool())
*/
