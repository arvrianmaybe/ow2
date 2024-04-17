#!mainFile "../main.opy"

rule "[headshot.opy]":
    @Event playerDealtDamage
    @Condition eventWasCriticalHit == true

    damage(victim, victim, 1.9687659754)