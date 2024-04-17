#!mainFile "../main.opy"

rule "[slam.opy] slam damage":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition eventAbility == Button.ABILITY_2

    damage(victim, attacker, eventDamage*(DOOMFIST_SLAM_DAMAGE)-eventDamage)