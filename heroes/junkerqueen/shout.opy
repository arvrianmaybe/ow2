#!mainFile "../main.opy"


rule "[shout.opy] shout extra overhealth":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.isUsingAbility1()


    getPlayersInRadius(eventPlayer.getPosition(), 10, eventPlayer.getTeam(), LosCheck.OFF).addHealthPool(Health.NORMAL, JUNKERQUEEN_SHOUT_OVERHEALTH, false,false)    
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    removeHealthPool(getLastCreatedHealthPool())