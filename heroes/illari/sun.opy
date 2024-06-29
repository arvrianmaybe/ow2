#!mainFile "../../main.opy"

rule "[illari/sun.opy]: increase sun dmg":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility in [Button.ULTIMATE]
    @Condition eventDamage/eventPlayer._base_damage_scalar < (ILLARI_SUNSTRUCK_DAMAGE/2)

    damage(victim, attacker, (eventDamage/eventPlayer._base_damage_scalar - eventDamage)/eventPlayer._base_damage_scalar)
