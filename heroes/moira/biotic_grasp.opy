#!mainFile "../main.opy"

rule "[moira/biotic_grasp.opy]: deal less biotic grasp damage":
    @Event playerDealtDamage
    @Hero moira
    @Condition eventAbility == Button.SECONDARY_FIRE

    heal(victim, null, eventDamage - eventDamage*(MOIRA_BIOTIC_GRASP_DAMAGE/OW2_MOIRA_BIOTIC_GRASP_DAMAGE))

/*
rule "[moira/biotic_grasp.opy] Moira Slow Decay":
    @Event eachPlayer
    @Hero moira
    @Condition eventPlayer.isFiringSecondaryFire() == true
        
    damage(eventPlayer, eventPlayer, 3)
    wait(0.1)
    if RULE_CONDITION:
        goto RULE_START
*/
