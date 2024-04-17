#!mainFile "../main.opy"

playervar meteor_strike_slow_time

#!define getMeteorStrikeDamage(d) \
    (DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MAX_DAMAGE \
     + ((DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MAX_DAMAGE - DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MIN_DAMAGE) \
        / (DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MAX_DAMAGE - DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MIN_DAMAGE)) \
        * (d - DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MAX_DAMAGE))


rule "[doomfist/meteor.opy]: Deal Meteor Strike damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventDamage < (DOOMFIST_METEOR_STRIKE_OUTER_SPHERE_MAX_DAMAGE + DOOMFIST_METEOR_STRIKE_INNER_SPHERE_DAMAGE)/2

    damage(victim, attacker, getMeteorStrikeDamage(eventDamage) - eventDamage)
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[doomfist/meteor.opy]: Compensate Meteor Strike slow effect":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ULTIMATE

    victim.setMoveSpeed(DOOMFIST_METEOR_STRIKE_SLOW)
    victim.meteor_strike_slow_time = DOOMFIST_METEOR_STRIKE_SLOW_DURATION
    chase(victim.meteor_strike_slow_time, 0, rate=1, ChaseReeval.NONE)
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[doomfist/meteor.opy]: Reset Meteor Strike slow effect compensation":
    @Event eachPlayer
    @Condition eventPlayer.meteor_strike_slow_time <= 0

    stopChasingVariable(eventPlayer.meteor_strike_slow_time)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[doomfist/meteor.opy]:  Meteor Strike knockback":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ULTIMATE

    victim.setGravity(50) 
    victim.applyImpulse(Vector.UP, 5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ) 
    victim.applyImpulse(directionTowards(attacker, victim), 
                        20/max(distance(attacker, victim), DOOMFIST_METEOR_STRIKE_INNER_SPHERE_RADIUS), 
                        Relativity.TO_WORLD, 
                        Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    victim.setGravity(100)
    eventPlayer.allowButton(Button.ABILITY_2)


rule "[doomfist/meteor.opy]: Remove Meteor Strike healing":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setHealingDealt(100)
    eventPlayer.allowButton(Button.ABILITY_2)