#!mainFile "../main.opy"
#!include "heroes/bastion/tank.opy"
#!include "heroes/bastion/configuration.opy"

playervar self_repair_gui 
playervar repair_pvar
playervar self_repair_hud_id
playervar self_repair_time_left

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

#!define hideSelfRepairRing()\
 destroyEffect(eventPlayer.self_repair_hud_id[0])\
 eventPlayer.self_repair_hud_id[0] = null\
 destroyEffect(eventPlayer.self_repair_hud_id[1])\
 eventPlayer.self_repair_hud_id[1] = null
 
#!define hideSelfRepairResource()\
    destroyProgressBarHud(eventPlayer.self_repair_gui)\
    eventPlayer.self_repair_gui = null

 #!defineMember self_repair_instance repair_pvar[3]

rule "[bastion/self_repair.opy]: self repair start":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    @Condition eventPlayer.getHealth() != eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition not isCCd(eventPlayer)

    wait(BASTION_SELF_REPAIR_CAST_TIME, Wait.ABORT_WHEN_FALSE)
    stopChasingVariable(eventPlayer.self_repair_time_left) # Stop resource recharging

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

    # HUD

    if eventPlayer.self_repair_gui == null:
        progressBarHud(eventPlayer if eventPlayer.self_repair_time_left < BASTION_MAX_SELF_REPAIR_DURATION else null, 
                        roundedPercent(eventPlayer.self_repair_time_left/BASTION_MAX_SELF_REPAIR_DURATION), 
                        "Self-Repair", 
                        HudPosition.TOP, 
                        1, 
                        Color.YELLOW, 
                        Color.YELLOW, 
                        ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, 
                        SpecVisibility.DEFAULT)
        eventPlayer.self_repair_gui = getLastCreatedText()
        
    # Player Disable

    eventPlayer.setReloadEnabled(false)
    eventPlayer.setPrimaryFireEnabled(false)

    # Start Self Repair

    if eventPlayer.self_repair_instance == null:
        eventPlayer.startHoT(eventPlayer, eventPlayer.self_repair_time_left, BASTION_SELF_REPAIR_HEALING_RATE)
        eventPlayer.self_repair_instance = getLastHoT()
    chase(eventPlayer.self_repair_time_left, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE) # Start resource depletion

rule "[bastion/repair.opy]: Deactivate self-repair":
    @Event eachPlayer
    @Hero bastion
    @Condition not isUsingSelfRepair(eventPlayer)

    # Stop Healing

    stopHoT(eventPlayer.self_repair_instance)
    eventPlayer.self_repair_instance = null

    # Start Charging

    stopChasingVariable(eventPlayer.self_repair_time_left) # Stop resource depletion
    wait(BASTION_SELF_REPAIR_COOLDOWN_TIME, Wait.ABORT_WHEN_FALSE) # Wait 1 second cooldown before recharging heal resource

    chase(eventPlayer.self_repair_time_left, \
    BASTION_MAX_SELF_REPAIR_DURATION, \
    rate=BASTION_MAX_SELF_REPAIR_DURATION/BASTION_SELF_REPAIR_RECHARGE_DURATION, \
    ChaseReeval.DESTINATION_AND_RATE) # Start recharging

    # Disable Player Effects

    hideSelfRepairRing()

    # Allow Buttons

    eventPlayer.setReloadEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)


rule "[bastion/self_repair.opy] stop self repair if full heal":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.getHealth() == eventPlayer.getMaxHealth() == true
    @Condition eventPlayer.isAlive() == true
    @Condition isUsingSelfRepair(eventPlayer)

    stopHoT(eventPlayer.self_repair_instance)
    eventPlayer.self_repair_instance = null

    stopChasingVariable(eventPlayer.self_repair_time_left) # Stop resource depletion
    wait(BASTION_SELF_REPAIR_COOLDOWN_TIME, Wait.ABORT_WHEN_FALSE) # Wait 1 second cooldown before recharging heal resource

    chase(eventPlayer.self_repair_time_left, \
    BASTION_MAX_SELF_REPAIR_DURATION, \
    rate=BASTION_MAX_SELF_REPAIR_DURATION/BASTION_SELF_REPAIR_RECHARGE_DURATION, \
    ChaseReeval.DESTINATION_AND_RATE) # Start recharging

    destroyEffect(eventPlayer.self_repair_hud_id)
    eventPlayer.self_repair_hud_id = null

    eventPlayer.setReloadEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)

rule "[bastion/repair.opy]: Hide self repair resource GUI":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer.self_repair_time_left >= BASTION_MAX_SELF_REPAIR_DURATION

    hideSelfRepairResource()

rule "[bastion/repair.opy]: Give ult charge for self repair":
    @Event playerDealtHealing
    @Hero bastion
    @Condition healer == healee

    eventPlayer._missing_ult_points += eventHealing
