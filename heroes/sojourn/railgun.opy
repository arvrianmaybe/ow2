#!mainFile "../main.opy"

#!define getRailgunAltDamage(d) \
((SOJOURN_RAILGUN_ALT_DAMAGE_MAX-SOJOURN_RAILGUN_ALT_DAMAGE_MIN) \
 / (OW2_SOJOURN_RAILGUN_ALT_DAMAGE_MAX-OW2_SOJOURN_RAILGUN_ALT_DAMAGE_MIN) \
 * (d-OW2_SOJOURN_RAILGUN_ALT_DAMAGE_MIN) + SOJOURN_RAILGUN_ALT_DAMAGE_MIN)


 
rule "[sojourn/railgun.opy]: Railgun alt fire bodyshot damage":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility in [Button.SECONDARY_FIRE, Button.ULTIMATE]
    @Condition not eventWasCriticalHit

    damage(victim, attacker, (getRailgunAltDamage(eventDamage/SOJOURN_GLOBAL_DAMAGE) - eventDamage)/SOJOURN_GLOBAL_DAMAGE)
    if (getRailgunAltDamage(eventDamage/SOJOURN_GLOBAL_DAMAGE) - eventDamage)/SOJOURN_GLOBAL_DAMAGE < 1:
        heal(victim, null, (eventDamage - getRailgunAltDamage(eventDamage/SOJOURN_GLOBAL_DAMAGE))/SOJOURN_GLOBAL_DAMAGE)


rule "[sojourn/railgun.opy]:  Railgun alt fire headshot damage":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility in [Button.SECONDARY_FIRE, Button.ULTIMATE]
    @Condition eventWasCriticalHit

    damage(victim, attacker, (SOJOURN_RAILGUN_ALT_HEADSHOT_MULTIPLIER * \
                                getRailgunAltDamage((eventDamage/OW2_SOJOURN_RAILGUN_ALT_HEADSHOT_MULTIPLIER)/SOJOURN_GLOBAL_DAMAGE)\
                                - eventDamage)/SOJOURN_GLOBAL_DAMAGE)
    if (SOJOURN_RAILGUN_ALT_HEADSHOT_MULTIPLIER * \
        getRailgunAltDamage((eventDamage/OW2_SOJOURN_RAILGUN_ALT_HEADSHOT_MULTIPLIER)/SOJOURN_GLOBAL_DAMAGE)\
        - eventDamage)/SOJOURN_GLOBAL_DAMAGE < 1:
        heal(victim, null, (eventDamage - SOJOURN_RAILGUN_ALT_HEADSHOT_MULTIPLIER * \
                            getRailgunAltDamage((eventDamage/OW2_SOJOURN_RAILGUN_ALT_HEADSHOT_MULTIPLIER)/SOJOURN_GLOBAL_DAMAGE))/SOJOURN_GLOBAL_DAMAGE)