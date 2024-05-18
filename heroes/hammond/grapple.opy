#!mainFile "../main.opy"

rule "[hammond/grapple.opy]: OW1 Grappling Claw Cooldown":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0

    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, WRECKING_BALL_GRAPPLE_COOLDOWN)

/*
rule "[hammond/grapple.opy]: No Retract":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) == 0
    
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.setJumpEnabled(false)
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), Math.INFINITY)
    eventPlayer.setJumpEnabled(true)
    eventPlayer.allowButton(Button.JUMP)
*/