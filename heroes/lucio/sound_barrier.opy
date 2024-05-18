#!mainFile "../main.opy"


rule "[sound_barrier.opy] sound barrier extra overhealth":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingUltimate()


    getPlayersInRadius(eventPlayer.getPosition(), 10, eventPlayer.getTeam(), LosCheck.OFF).addHealthPool(Health.NORMAL, LUCIO_BEAT_OVERHEALTH, false,false)    
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    removeHealthPool(getLastCreatedHealthPool())