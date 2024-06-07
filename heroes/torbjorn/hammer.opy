#!mainFile "../main.opy"

rule "[torbjorn/hammer.opy]: Decrease fire rate":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.getCurrentWeapon() == 2
    @Condition eventPlayer.isFiringPrimaryFire()
    @Condition not eventPlayer.isUsingAbility2()
    @Condition not eventPlayer.isUsingUltimate()

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    wait(TORBJORN_HAMMER_RECOVERY_TIME)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
