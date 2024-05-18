#!mainFile "../main.opy"

playervar ow2_adaptive_shield_n
playervar adaptive_shield_n

#!define getOW1AdaptiveShields(n) (WRECKING_BALL_SHIELD_PER_TARGET*n + WRECKING_BALL_ADAPTIVE_SHIELD_BASE)
#!define getOW2AdaptiveShields(n) (OW2_WRECKING_BALL_SHIELD_PER_TARGET*n + OW2_WRECKING_BALL_ADAPTIVE_SHIELD_BASE)


rule "[hammond/shields.opy]: Adaptive Shields":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.ow2_adaptive_shield_n = len(getPlayersInRadius(eventPlayer.getEyePosition(), 
                                                               OW2_WRECKING_BALL_ADAPTIVE_SHIELD_RADIUS, 
                                                               getOppositeTeam(eventPlayer.getTeam()), 
                                                               LosCheck.SURFACES_AND_ALL_BARRIERS))
    eventPlayer.adaptive_shield_n = len(getPlayersInRadius(eventPlayer.getEyePosition(), 
                                                               WRECKING_BALL_ADAPTIVE_SHIELD_RADIUS, 
                                                               getOppositeTeam(eventPlayer.getTeam()), 
                                                               LosCheck.SURFACES_AND_ALL_BARRIERS))

    damage(eventPlayer, null, getOW2AdaptiveShields(eventPlayer.ow2_adaptive_shield_n) - getOW1AdaptiveShields(eventPlayer.adaptive_shield_n))