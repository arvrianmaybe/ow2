#!mainFile "../main.opy"
#!include "heroes/bastion/tank.opy"
#!include "heroes/bastion/configuration.opy"

playervar bastionid 
playervar repair_heal 
playervar self_repair 
playervar self_repair_hud_id
playervar self_repair_time_left

subroutine selfRepairGui
subroutine hideSelfRepairGui

#!define isPressingSelfRepairButton(player)\
    (player.isHoldingButton(Button.ABILITY_2) \
  or player.isHoldingButton(Button.SECONDARY_FIRE))

#!define isUsingSelfRepair(player)\
    ((isPressingSelfRepairButton(player)) \
 and (not player.isFiringPrimaryFire()) \
 and (not player.isMeleeing()) \
 and (not isCCd(player)) \
 and (player.isAlive()) \
 and (player.self_repair_time_left > 0))

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
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    #@Condition eventPlayer.current_configuration != Configuration.TANK
    @Condition eventPlayer.getHealth() != eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition not isCCd(eventPlayer)
    @Condition eventPlayer.isUsingUltimate() == false
    
    wait(0.16)
    eventPlayer.repair_heal -= 3.75
    eventPlayer.self_repair = 1
    eventPlayer.startHoT(eventPlayer, 0.16, BASTION_SELF_REPAIR_HEALING_RATE)
    #eventPlayer.setUltCharge(eventPlayer.getUltCharge() + 0.5)
    if eventPlayer.repair_heal > 0 and eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true and isCCd(eventPlayer):
    eventPlayer.self_repair = 0

rule "[bastion/self_repair.opy]: self repair start":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.getHealth() != eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition not isCCd(eventPlayer)

    wait(BASTION_SELF_REPAIR_CAST_TIME)
    selfRepairGui()
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), Math.INFINITY)
    hideSelfRepairGui()


rule "[bastion/self_repair.opy] stop self repair if full heal":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.getHealth() == eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    hideSelfRepairGui()

def selfRepairGui():
    @Name "[bastion/self_repair.opy] selfRepairGui()"

    # Effects
    if (eventPlayer.self_repair_hud_id[0] == null):
        createEffect(eventPlayer, Effect.SPHERE, Color.YELLOW, eventPlayer, 1.4, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.self_repair_hud_id[0] = getLastCreatedEntity()

    if (eventPlayer.self_repair_hud_id[1] == null):
        createEffect(getAllPlayers(), 
                     Effect.SPARKLES, 
                     Color.YELLOW, 
                     updateEveryTick(eventPlayer.getEyePosition()), 
                     1.5, 
                     EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.self_repair_hud_id[1] = getLastCreatedEntity()

    # Hud

    progressBarHud(eventPlayer, eventPlayer.repair_heal, 
    "{2} SELF HEAL {1}%".format(null, round(eventPlayer.repair_heal * 1), 
    abilityIconString(Hero.TORBJORN, Button.ABILITY_2)), 
    HudPosition.TOP, 
    4, 
    Color.YELLOW, 
    Color.WHITE, 
    ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.bastionid = getLastCreatedText()
        
    # Player Disable

    eventPlayer.setReloadEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)


def hideSelfRepairGui():
    @Name "[bastion/self_repair.opy] hideSelfRepairGui()"

    destroyEffect(eventPlayer.self_repair_hud_id)
    eventPlayer.self_repair_hud_id = null

    # Player Enable
    eventPlayer.setReloadEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    
    # Stop HOT
    stopHoT(eventPlayer.repair_heal)

    # Destroy GUI
    destroyProgressBarHud(eventPlayer.bastionid)


rule "[bastion/repair.opy]: Give ult charge for self repair":
    @Event playerDealtHealing
    @Hero bastion
    @Condition healer == healee

    eventPlayer._missing_ult_points += eventHealing
