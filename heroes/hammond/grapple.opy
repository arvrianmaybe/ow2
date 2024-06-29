#!mainFile "../../main.opy"

rule "[hammond/grapple.opy]: Set Grappling Claw Cooldown":
    @Event eachPlayer
    @Hero hammond
    @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0

    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, WRECKING_BALL_GRAPPLE_COOLDOWN)
