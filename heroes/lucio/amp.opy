#!mainFile "../main.opy"

/*
rule "[amp.opy] increased dmg to nearby allies":
    @Event eachPlayer
    @Hero lucio
    @Condition eventPlayer.isUsingAbility2() == true
    
    #eventPlayer.setStatusEffect(null, Status.HACKED, 3)
    getPlayersInRadius(eventPlayer.getPosition(), OW2_LUCIO_AURA, eventPlayer.getTeam(), LosCheck.OFF).startScalingSize(LUCIO_AMP_SCALING, true)
    getPlayersInRadius(eventPlayer.getPosition(), OW2_LUCIO_AURA, eventPlayer.getTeam(), LosCheck.SURFACES_AND_ALL_BARRIERS).setDamageDealt(LUCIO_AMP_DMG_INCREASE)
    #eventPlayer.startForcingOutlineFor(getPlayers(eventPlayer.getTeam()), true, Color.RED, OutlineVisibility.DEFAULT) # wont work cause of a workshop bug.
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    getPlayers(eventPlayer.getTeam()).setDamageDealt(100)
    eventPlayer.stopForcingOutlineFor(getAllPlayers())
    getPlayers(eventPlayer.getTeam()).stopScalingSize()
*/
