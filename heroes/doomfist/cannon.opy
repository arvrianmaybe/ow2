#!mainFile "../main.opy"

rule "[doomfist/cannon.opy]: damage cannon":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.PRIMARY_FIRE

    damage(victim, attacker, eventDamage*(DOOMFIST_HAND_CANNON_DAMAGE/OW2_DOOMFIST_HAND_CANNON_DAMAGE)-eventDamage)