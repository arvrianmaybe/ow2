#!mainFile "../../main.opy"

#!include "heroes/sojourn/railgun.opy"

rule "[sojourn/init.opy]: Detect switch to Sojourn":
    @Event eachPlayer
    @Hero sojourn

    eventPlayer.call_init = true


rule "[sojourn/init.opy]: Initialize Sojourn":
    @Event eachPlayer
    @Hero sojourn
    @Condition eventPlayer.call_init

    newHero(SOJOURN_HEALTH, 0, 0)
    setUltCost(SOJOURN_ULT_COST)
    setBaseDamage(eventPlayer, SOJOURN_GLOBAL_DAMAGE)
    
    removePassiveHealing()

    eventPlayer.call_init = false


rule "[sojourn/init.opy]: Deal regular damage for Primary and Melee":
    @Event playerDealtDamage
    @Hero sojourn
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.MELEE]

    damage(victim, attacker, (eventDamage/SOJOURN_GLOBAL_DAMAGE - eventDamage)/SOJOURN_GLOBAL_DAMAGE)
