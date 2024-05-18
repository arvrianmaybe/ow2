#!mainFile "../main.opy"

rule "[reinhardt/charge.opy] increased charge speed"
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.setMoveSpeed(REINHARDE_CHARGE_SPEED)
    waitUntil(not eventPlayer.isUsingAbility1(), 1)
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 0) 
    wait(REINHARDT_CHARGE_COOLDOWN_TIME)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 2)

rule "[reinhardt/charge.opy]: Increase charge damage":
    @Event playerDealtDamage
    @Hero reinhardt
    @Condition eventAbility == Button.ABILITY_1
    
    if eventDamage > (OW2_REINHARDT_CHARGE_BUMP_DAMAGE + 1): 
        damage(victim, attacker, (eventDamage/eventPlayer._base_damage_scalar*(REINHARDT_CHARGE_PIN_DAMAGE/OW2_REINHARDT_CHARGE_PIN_DAMAGE)-eventDamage)/eventPlayer._base_damage_scalar)
    else:
        damage(victim, attacker, (eventDamage/eventPlayer._base_damage_scalar - eventDamage)/eventPlayer._base_damage_scalar)


rule "[reinhardt/charge.opy]: Reduce charge radius":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.startForcingThrottle(0, 1/OW2_REINHARDT_TURN_BONUS, 0, 1/OW2_REINHARDT_TURN_BONUS, 0, 1/OW2_REINHARDT_TURN_BONUS)
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.stopForcingThrottle()