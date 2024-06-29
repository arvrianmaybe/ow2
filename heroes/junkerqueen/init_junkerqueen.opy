#!mainFile "../../main.opy"

playervar jq_self_heal_id 

rule "[junkerqueen/init.opy]: Detect switch to Junkerqueen":
    @Event eachPlayer
    @Hero junkerQueen

    eventPlayer.call_init = true


rule "[junkerqueen/init.opy]: Initialize Junkerqueen":
    @Event eachPlayer
    @Hero junkerQueen
    @Condition eventPlayer.call_init
    
    defaultHero()
    newHero(JUNKERQUEEN_HEALTH, JUNKERQUEEN_ARMOR, 0)
    setUltCost(JUNKERQUEEN_ULT_COST)
    setBaseDamage(eventPlayer, JUNKERQUEEN_RAMPAGE_WOUND_DAMAGE/OW2_JUNKERQUEEN_RAMPAGE_WOUND_DAMAGE)
    removeTankPassive()
    removePassiveHealing()

    startHealingModification(eventPlayer, eventPlayer, percent(JUNKERQUEEN_ADRENALINE/OW2_JUNKERQUEEN_ADRENALINE), HealingReeval.NONE)
    eventPlayer.jq_self_heal_id = getLastHealingModification()
    
    eventPlayer.call_init = false


rule "[junkerqueen/init.opy]: Clean up Junkerqueen":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.JUNKER_QUEEN

    waitUntil(eventPlayer.getCurrentHero() != Hero.JUNKER_QUEEN, Math.INFINITY)
    stopHealingModification(eventPlayer.jq_self_heal_id)


rule "[junkerqueen/init.opy]: Compensate Junkerqueen global damage reduction":
    @Event playerDealtDamage
    @Hero junkerQueen
    @Condition eventAbility in [Button.MELEE, Button.PRIMARY_FIRE, Button.SECONDARY_FIRE, Button.ABILITY_2]

    damage(victim, attacker, (eventDamage/eventPlayer._base_damage_scalar - eventDamage)/eventPlayer._base_damage_scalar)
