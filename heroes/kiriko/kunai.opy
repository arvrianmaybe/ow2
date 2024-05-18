#!mainFile "../main.opy"

rule "[kiriko/kunai.opy]: Kunai damage increase":
    @Event playerDealtDamage
    @Hero kiriko
    @Condition eventAbility == null 
    @Condition eventDamage >= OW2_KIRIKO_KUNAI_DAMAGE*eventPlayer._base_damage_scalar
    @Condition not eventWasCriticalHit

    damage(victim, attacker, (eventDamage/eventPlayer._base_damage_scalar*(KIRIKO_KUNAI_DAMAGE/OW2_KIRIKO_KUNAI_DAMAGE) - eventDamage)/eventPlayer._base_damage_scalar)


rule "[kiriko/kunai.opy]: decrease Kiriko fire rate":
    @Event eachPlayer
    @Hero kiriko
    @Condition eventPlayer.isFiringSecondaryFire()
    @Condition not eventPlayer.isUsingUltimate()

    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    wait(KIRIKO_KUNAI_RECOVERY_TIME)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    if eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)

/*
rule "[kiriko/kunai.opy]: kunai 2.5 multipler damage":
    @Event playerDealtDamage
    @Hero kiriko
    @Condition eventAbility == Button.PRIMARY_FIRE #already one
    @Condition eventWasCriticalHit

    damage(
        victim, 
        attacker, 
        (KIRIKO_KUNAI_HEADSHOT_MULTIPLIER \
        * (KIRIKO_KUNAI_DAMAGE/OW2_KIRIKO_KUNAI_DAMAGE) \
        * (eventDamage/eventPlayer._base_damage_scalar/KIRIKO_KUNAI_HEADSHOT_MULTIPLIER) \
        - eventDamage)/eventPlayer._base_damage_scalar)
*/
