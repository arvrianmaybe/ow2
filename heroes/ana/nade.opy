#!mainFile "../../main.opy"

rule "[ana/nade.opy]: healing with biotic grenade":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2

    heal(healee, healer, eventHealing*(ANA_BIOTIC_GRENADE_HEALING/OW2_ANA_BIOTIC_GRENADE_HEALING)-eventHealing)

rule "[ana/nade.opy]: Allow self healing during Biotic Grenade":
    @Event eachPlayer
    @Hero ana
    @Condition eventPlayer.isUsingAbility2()

    pushSelfHealing(Button.ABILITY_2)
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    popSelfHealing(Button.ABILITY_2)
