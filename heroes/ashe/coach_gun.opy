#!mainFile "../../main.opy"

rule "[ashe/coouch_gun.opy]: damage shotgun":
    @Event playerDealtDamage
    @Hero ashe
    @Condition eventAbility == Button.ABILITY_1

    damage(victim, attacker, eventDamage*(ASHE_SHOTGUN_DAMAGE/OW2_ASHE_COUCH_GUN_DAMAGE)-eventDamage)
