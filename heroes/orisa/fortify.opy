#!mainFile "../../main.opy"

rule "[orisa/fortify.opy]: Remove overhealth during fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1()

    damage(eventPlayer, null, OW2_ORISA_FORTIFY_OVERHEALTH/(1-OW2_ORISA_FORTIFY_DAMAGE_REDUCTION))
    heal(eventPlayer, null, 1)

rule "[orisa/fortify.opy]: Correct movement speed during fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.setMoveSpeed(percent(ORISA_FORITFY_MOVEMENT_BONUS/OW2_ORISA_FORTIFY_MOVEMENT_DECREASE))
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setMoveSpeed(100)
