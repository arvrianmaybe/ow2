#!mainFile "../main.opy"

rule "[torbjorn/overload.opy]: less overload hp":
    @Event eachPlayer
    @Hero torbjorn
    @Condition eventPlayer.isUsingAbility2()

    damage(eventPlayer, null, TORBJORN_OVERLOAD_OVERHEALTH*(TORBJORN_TURRET_HEALTH/OW2_TORBJORN_TURRET_HEALTH) - TORBJORN_OVERLOAD_OVERHEALTH)