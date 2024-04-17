#!mainFile "../main.opy
#!include "heroes/bastion/tank.opy"
#!include "heroes/bastion/machine_gun.opy"
#!include "heroes/bastion/configuration.opy"

rule "[bastion/sentry.opy]: Detect sentry mode":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isInAlternateForm()
    @Condition eventPlayer.current_configuration == Configuration.RECON # Sentry mode can only be entered from recon mode
    @Condition eventPlayer.current_configuration != Configuration.TANK # prevents incorrectly identifying tank as sentry
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.current_configuration = Configuration.SENTRY


rule "[bastion/sentry.opy]: Go back to sentry mode": # thanks for ecks for letting me steal this code rq
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isUsingAbility1()
    @Condition eventPlayer.current_configuration == Configuration.SENTRY

    do:
        wait(1, Wait.IGNORE_CONDITION)
        waitUntil(not eventPlayer.isUsingAbility1(), 4.984) # 6 second total time - 1 second - 1 tick
        waitUntil(eventPlayer.isHoldingButton(Button.ABILITY_1) or not eventPlayer.isUsingAbility1(), 1)
        if eventPlayer.isUsingAbility1() and not eventPlayer.isHoldingButton(Button.ABILITY_1):
            wait(0.016, Wait.IGNORE_CONDITION)
            eventPlayer.cancelPrimaryAction()
            eventPlayer.forceButtonPress(Button.ABILITY_1)
    while RULE_CONDITION


rule "[bastion/sentry.opy]: Initialize sentry mode":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.current_configuration == Configuration.SENTRY

    setBaseDamage(eventPlayer, BASTION_SENTRY_DAMAGE/OW2_BASTION_ASSAULT_CONFIG_DAMAGE)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.setKnockbackReceived(0)

    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)