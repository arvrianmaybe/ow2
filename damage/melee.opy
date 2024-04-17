#!mainFile "../main.opy"

rule "[headshot.opy]":
    @Event playerDealtDamage
    @Condition eventAbility == Button.MELEE

    damage(victim, attacker, 1.9687659754)