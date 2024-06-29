#!mainFile "../../main.opy"

rule "[illari/solar_rifle.opy]:  Solar Rifle body damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition not eventWasCriticalHit

    damage(
        victim, 
        attacker, 
        ((ILLARI_RIFLE_DAMAGE/OW2_ILLARI_RIFLE_DAMAGE) \
        * (eventDamage/eventPlayer._base_damage_scalar) \
        - eventDamage)/eventPlayer._base_damage_scalar)


rule "[illari/solar_rifle.opy]:  Solar Rifle  2.5 multipler damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility == Button.PRIMARY_FIRE
    @Condition eventWasCriticalHit

    damage(
        victim, 
        attacker, 
        (ILLARI_RIFLE_HEADSHOT_MULTIPLIER \
        * (ILLARI_RIFLE_DAMAGE/OW2_ILLARI_RIFLE_DAMAGE) \
        * (eventDamage/eventPlayer._base_damage_scalar/OW2_ILLARI_RIFLE_HEADSHOT_MULTIPLIER) \
        - eventDamage)/eventPlayer._base_damage_scalar)
