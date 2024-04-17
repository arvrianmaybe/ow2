#!mainFile "../main.opy"

rule "[rampage.opy] more wound dmg":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventAbility == Button.ULTIMATE

    damage(victim, attacker, eventDamage*(JUNKERQUEEN_RAMPAGE_WOUND_DAMAGE/OW2_JUNKERQUEEN_RAMPAGE_WOUND_DAMAGE)-eventDamage)