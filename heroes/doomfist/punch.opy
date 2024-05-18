#!mainFile "../main.opy"

playervar punched_victims
playervar wall_impacted_victims
playervar punch_charge_time
playervar is_ultimate_locked 

subroutine initRocketPunch

#!define initRocketPunch() \
    eventPlayer.punched_victims = [] \
    eventPlayer.wall_impacted_victims = []


rule "[punch.opy] reset if earn elimination":
    @Event playerEarnedElimination
    @Hero doomfist

    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)

rule "[punch.opy] start punch":
    @Event playerDealtDamage
    @Hero doomfist
    @Condition  eventPlayer.isFiringSecondaryFire()
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)


    eventPlayer.punched_victims = []
    eventPlayer.wall_impacted_victims = []
    eventPlayer.punch_charge_time = 0
    chase(eventPlayer.punch_charge_time, DOOMFIST_ROCKET_PUNCH_CHARGE_TIME_MAX, rate=1, ChaseReeval.NONE)
    waitUntil(not eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), Math.INFINITY)
    stopChasingVariable(eventPlayer.punch_charge_time)
    eventPlayer.punch_charge_time = max(DOOMFIST_ROCKET_PUNCH_CHARGE_TIME_MIN, eventPlayer.punch_charge_time)
    
    waitUntil(not eventPlayer.isFiringSecondaryFire(), Math.INFINITY)
    # eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, PUNCH_COOLDOWN) #workshop buug, wont work.

rule "[doomfist/punch.opy]: Remove Empowered Punch from ultimate":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.is_ultimate_locked = true
    waitUntil(eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), 4.8)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.016)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    wait()
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.is_ultimate_locked = false
    eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, 0)
    if eventPlayer.isHoldingButton(Button.ABILITY_1):
        wait() 
        eventPlayer.forceButtonPress(Button.ABILITY_1)
        eventPlayer.allowButton(Button.ABILITY_2)
        if eventPlayer.isHoldingButton(Button.ABILITY_2):
        eventPlayer.forceButtonPress(Button.ABILITY_2)
        eventPlayer.allowButton(Button.SECONDARY_FIRE)