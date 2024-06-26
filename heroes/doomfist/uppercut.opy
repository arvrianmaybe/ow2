#!mainFile "../main.opy"

# Base off "Evolution of Ryu's Shin Shoryuken (1997-2022) Vid by XIAOQUAN (timestamp of the video is Capcom vs. SNK: Millennium Fight 2000 Pro at 1:02)"
# video : https://www.youtube.com/watch?v=KuHV4Nhulps this is also inspired by this reddit post: https://www.reddit.com/r/doomfistmains/comments/1byjwps/uppercut_20_april_fools_empowered_quick/

playervar uppercut_pvar
playervar is_using_uppercut
#!defineMember is_hit_by_uppercut uppercut_pvar[0]
#!defineMember is_uppercut_locked uppercut_pvar[1]
playervar uppercut_shields
#!defineMember _uppercut_victims uppercut_pvar[3]
#!defineMember _uppercut_attacker uppercut_pvar[4]
#!defineMember _last_uppercut_attacker uppercut_pvar[5]
playervar uppercut_dmg_effects

#!define uppercutDamageExtension()\
 if (eventPlayer.uppercut_dmg_effects[0] == null):\
    damage(eventPlayer, eventPlayer._uppercut_attacker, DOOMFIST_UPPERCUT_DAMAGE_EXTENSION)\
    eventPlayer.setStatusEffect(eventPlayer._uppercut_attacker, Status.STUNNED, DOOMFIST_UPPERCUT_STUN_PER_HIT)\
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer, 100)\
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, rgb(201, 195, 196), eventPlayer, 1)\
 eventPlayer.uppercut_dmg_effects[0] = getLastCreatedEntity()\
 wait(DOOMFIST_UPPERCUT_STUN_EXTENSION_RENEW)\
 if (eventPlayer.uppercut_dmg_effects[1] == null):\
    damage(eventPlayer, eventPlayer._uppercut_attacker, DOOMFIST_UPPERCUT_DAMAGE_EXTENSION)\
    eventPlayer.setStatusEffect(eventPlayer._uppercut_attacker, Status.STUNNED, DOOMFIST_UPPERCUT_STUN_PER_HIT)\
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.YELLOW, eventPlayer, 1)\
 eventPlayer.uppercut_dmg_effects[1] = getLastCreatedEntity()\
 wait(DOOMFIST_UPPERCUT_STUN_EXTENSION_RENEW)\
 if (eventPlayer.uppercut_dmg_effects[2] == null):\
    damage(eventPlayer, eventPlayer._uppercut_attacker, DOOMFIST_UPPERCUT_DAMAGE_EXTENSION)\
    eventPlayer.setStatusEffect(eventPlayer._uppercut_attacker, Status.STUNNED, DOOMFIST_UPPERCUT_STUN_PER_HIT)\
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, rgb(217, 144, 54), eventPlayer, 1)\
 eventPlayer.uppercut_dmg_effects[2] = getLastCreatedEntity()\
 wait(DOOMFIST_UPPERCUT_STUN_EXTENSION_RENEW)\
 if (eventPlayer.uppercut_dmg_effects[3] == null):\
    damage(eventPlayer, eventPlayer._uppercut_attacker, DOOMFIST_UPPERCUT_DAMAGE_EXTENSION)\
    eventPlayer.setStatusEffect(eventPlayer._uppercut_attacker, Status.STUNNED, DOOMFIST_UPPERCUT_STUN_PER_HIT)\
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, rgb(163, 44, 62), eventPlayer, 1)\
 eventPlayer.uppercut_dmg_effects[3] = getLastCreatedEntity()
 
 # Hex Code i use:
 # Red : #a32c3e
 # White/Grey : #c9c3c4
 # Yellow (unused) : #cee657
 # Orange : #d99036

rule "[doomfist/uppercut.opy]: Control flow for uppercut":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2()
    @Condition not eventPlayer.isUsingAbility1()
    @Condition not eventPlayer.isFiringSecondaryFire()

    eventPlayer.cancelPrimaryAction() # cancel Power Block animation
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)

    # Execute Uppercut
    eventPlayer.is_using_uppercut = true # Start of uppercut

    # Disable abilities during uppercut
    eventPlayer.is_uppercut_locked = true
    eventPlayer.setMeleeEnabled(false) # Doomfist cannot melee during uppercut
    eventPlayer.setPrimaryFireEnabled(false) # Doomfist cannot shoot during uppercut
    eventPlayer.setSecondaryFireEnabled(false) # Doomfist cannot punch during uppercut
    eventPlayer.setAbility1Enabled(false) # Doomfist cannot slam during uppercut
    eventPlayer.disallowButton(Button.ULTIMATE) # Doomfist cannot ult during uppercut
    wait(0.6)
    # Reenable abilities
    eventPlayer.is_uppercut_locked = false
    eventPlayer.setMeleeEnabled(true)
    eventPlayer.setPrimaryFireEnabled(true)
    if (eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)): # Shoot single buffered left click interrupted by power block
        eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.allowButton(Button.ULTIMATE)
    if (eventPlayer.isHoldingButton(Button.ULTIMATE)): # Activate ult if button held
        eventPlayer.forceButtonPress(Button.ULTIMATE)

rule "[doomfist/uppercut.opy]: Uppercut vfx + movement physics":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.is_using_uppercut

    # vfx
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer, 100)
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, eventPlayer.getTeam(), eventPlayer, 100)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, eventPlayer.getTeam(), eventPlayer, 100)

    # movement physics
    cancelMomentum(eventPlayer)
    eventPlayer.disablePlayerCollision() # Doomfist phases through enemies during uppercut

    eventPlayer.applyImpulse(getForwardDirection(eventPlayer), 5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION) # Step Forward
    eventPlayer.setGravity(0) # Override gravity during uppercut
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0) # Deny player from inputting movement commands
    wait(0.15)
    eventPlayer.applyImpulse(Vector.UP, 35, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION) # Uppercut
    wait(0.1)
    eventPlayer.applyImpulse(Vector.DOWN, max(0, eventPlayer.getSpeedInDirection(Vector.UP)), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    wait()
    eventPlayer.applyImpulse(Vector.UP, 2.5, Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION)
    eventPlayer.enablePlayerCollision()
    eventPlayer.is_using_uppercut = false # End of uppercut
    wait(0.35)

    # set cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, DOOMFIST_UPPERCUT_COOLDOWN)
    eventPlayer.setAbility2Enabled(true)

    eventPlayer.stopForcingThrottle()
    if (eventPlayer.isUsingAbility1()): return
    eventPlayer.setGravity(50)
    wait(0.25)
    if (eventPlayer.isUsingAbility1()): return
    eventPlayer.setGravity(100)

rule "[doomfist/uppercut.opy]: Detect uppercut victims":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.is_using_uppercut
    @Condition eventPlayer.isAlive()

    do:
        eventPlayer._uppercut_victims = \
            getPlayersInRadius(
                eventPlayer, 
                DOOMFIST_UPPERCUT_RADIUS, 
                getOppositeTeam(eventPlayer.getTeam()), 
                LosCheck.SURFACES).exclude(eventPlayer)
        eventPlayer._uppercut_victims = \
            [uppercut_victim for uppercut_victim in eventPlayer._uppercut_victims 
                    if ((uppercut_victim.isAlive()) \
                    and (angleBetweenVectors(
                            getForwardDirection(eventPlayer), 
                                directionTowards(
                                    eventPlayer, 
                                    uppercut_victim)) 
                        <= 90))] # Victim in front of doomfist

        eventPlayer._uppercut_victims.is_hit_by_uppercut = true
        eventPlayer._uppercut_victims._uppercut_attacker = eventPlayer

        wait()
    while RULE_CONDITION

rule "[doomfist/uppercut.opy]: Damage uppercut victims + vfx + uppercut knockback physics":
    @Event eachPlayer
    @Condition eventPlayer.is_hit_by_uppercut
    @Condition eventPlayer._last_uppercut_attacker != eventPlayer._uppercut_attacker

     # knockback
    eventPlayer.startForcingThrottle(0, 0, 0, 0, 0, 0) # Lose movement control
    eventPlayer.applyImpulse(Vector.UP, 13.5, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION_XYZ)
    eventPlayer.applyImpulse(getForwardDirection(eventPlayer._uppercut_attacker), 8.5, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION_XYZ)

    # upercut hit vfx
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.WHITE, eventPlayer, 1)

    # initial stun
    eventPlayer.setStatusEffect(eventPlayer._uppercut_attacker, Status.STUNNED, DOOMFIST_UPPERCUT_INITIAL_STUN)

    # damage
    damage(eventPlayer, eventPlayer._uppercut_attacker, DOOMFIST_UPPERCUT_DAMAGE)
    eventPlayer.setEnvironmentalKillCreditor(eventPlayer._uppercut_attacker)

    # damage extension
    uppercutDamageExtension()

    # lock out
    wait(DOOMFIST_UPPERCUT_AIR_LOCK_TIME)
    eventPlayer.stopForcingThrottle() # Regain movement control

rule "[doomfist/uppercut.opy]: Best defense for each uppercut victim hit":
    @Event eachPlayer
    @Condition eventPlayer.is_hit_by_uppercut
    @Condition eventPlayer._last_uppercut_attacker != eventPlayer._uppercut_attacker

    # best defense
    stopChasingVariable(eventPlayer._uppercut_attacker.uppercut_shields)
    eventPlayer._uppercut_attacker.uppercut_shields += DOOMFIST_BEST_DEFENSE
    wait(DOOMFIST_BEST_DEFENSE_LINGER)
    chase(eventPlayer._uppercut_attacker.uppercut_shields, 0, rate=DOOMFIST_BEST_DEFENSE_DECAY_RATE, ChaseReeval.NONE)


rule "[doomfist/uppercut.opy]: Uppercut victim state variables":
    @Event eachPlayer
    @Condition eventPlayer.is_hit_by_uppercut
    @Condition eventPlayer._last_uppercut_attacker != eventPlayer._uppercut_attacker

    eventPlayer._last_uppercut_attacker = eventPlayer._uppercut_attacker
    waitUntil(not eventPlayer._uppercut_attacker.is_using_uppercut, Math.INFINITY)
    eventPlayer.is_hit_by_uppercut = false
    eventPlayer._last_uppercut_attacker = null
    wait(1)
    eventPlayer._uppercut_attacker = null
