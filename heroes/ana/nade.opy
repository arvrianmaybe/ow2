#!mainFile "../main.opy"

rule "[ana/nade.opy]: Hhealing with biotic grenade":
    @Event playerDealtHealing
    @Hero ana
    @Condition eventAbility == Button.ABILITY_2

    heal(healee, healer, eventHealing*(ANA_BIOTIC_GRENADE_HEALING/OW2_ANA_BIOTIC_GRENADE_HEALING)-eventHealing)