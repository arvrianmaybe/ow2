#!mainFile "../main.opy"

rule "[baptiste/reg_boost.opy] reg boost delayed":
    @Hero baptiste
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_1)

    eventPlayer.disallowButton(Button.ABILITY_1)
    wait(0.1)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_1) 