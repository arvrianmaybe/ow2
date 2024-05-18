#!mainFile "../main.opy"
#!include "heroes/bastion/tank.opy"
#!include "heroes/bastion/configuration.opy"

playervar bastionid 
playervar repair_heal 
playervar self_repair 


rule "[bastion/self_repair.opy] self repair init":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.repair_heal < 100
    @Condition eventPlayer.self_repair == 0
    
    wait(0.32)
    eventPlayer.repair_heal += 8
    if eventPlayer.repair_heal > 100:
        eventPlayer.repair_heal = 100
    if RULE_CONDITION:
        goto RULE_START


rule "[bastion/self_repair.opy] self repair timer":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    @Condition eventPlayer.getHealth() != eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition not isCCd(eventPlayer)
    @Condition eventPlayer.isUsingUltimate() == false
    
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setReloadEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)
    wait(0.16)
    eventPlayer.repair_heal -= 3.75
    eventPlayer.self_repair = 1
    eventPlayer.startHoT(eventPlayer, 0.16, 50)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.YELLOW, eventPlayer, 0.1)
    eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 0.5)
    if eventPlayer.repair_heal > 0 and eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true and eventPlayer.isAlive() == true and eventPlayer.hasStatusEffect(Status.STUNNED) == false and eventPlayer.hasStatusEffect(Status.KNOCKED_DOWN) == false and eventPlayer.hasStatusEffect(Status.ASLEEP) == false and eventPlayer.hasStatusEffect(Status.STUNNED) == false and eventPlayer.getHealth() != eventPlayer.getMaxHealth():
        goto RULE_START
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setReloadEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    if eventPlayer.current_configuration == Configuration.TANK:
        eventPlayer.setPrimaryFireEnabled(false)
    else:
        eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.self_repair = 0


rule "[bastion/self_repair.opy] self gui":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.getHealth() != eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition not isCCd(eventPlayer)
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    wait(BASTION_SELF_REPAIR_CAST_TIME, Wait.ABORT_WHEN_FALSE)
    progressBarHud(eventPlayer, eventPlayer.repair_heal, "{2} SELF HEAL {1}%".format(null, round(eventPlayer.repair_heal * 1), abilityIconString(Hero.TORBJORN, Button.ABILITY_2)), HudPosition.TOP, 4, Color.YELLOW, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.DEFAULT)
    eventPlayer.bastionid = getLastCreatedText()
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), Math.INFINITY)
    destroyProgressBarHud(eventPlayer.bastionid)

rule "[bastion/self_repair.opy] stop self repair if full heal":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.getHealth() == eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    destroyProgressBarHud(eventPlayer.bastionid)
    stopHoT(eventPlayer.repair_heal)