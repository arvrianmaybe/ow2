#!mainFile "../main.opy"

rule "[shout.opy] shout extra overhealth":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventAbility == Button.ABILITY_2

    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    damage(victim, attacker, eventDamage*(JUNKERQUEEN_CARNAGE_DAMAGE/OW2_JUNKERQUEEN_CARNAGE_DAMAGE)-eventDamage)