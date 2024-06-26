#!mainFile "../../main.opy"

playervar debuff_pvar
#!defineMember orisa_debuff_id debuff_pvar [0]
#!defineMember orisa_debuff_id1 debuff_pvar [1]
#!defineMember orisa_debuff_origin debuff_pvar [2]
#!defineMember orisa_debuff_beam_id debuff_pvar [3]
#!defineMember orisa_debuff_sound_id debuff_pvar [4]
#!defineMember is_using_debuff debuff_pvar [5]
#!defineMember is_debuff debuff_pvar [6]

subroutine startDebuff
subroutine endDebuff


rule "[orisa/debuff.opy]: play Terra Surge voiceline":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    @Condition eventPlayer.getUltCharge() >= 100
    
    eventPlayer.allowButton(Button.ULTIMATE)
    getPlayersInRadius(eventPlayer, 
                       OW2_ORISA_TERRA_SURGE_RADIUS, 
                       getOppositeTeam(eventPlayer.getTeam()), 
                       LosCheck.SURFACES).setStatusEffect(null, Status.PHASED_OUT, 1)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.ULTIMATE)


rule "[orisa/debuff.opy]: Trigger debuff start":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.cancelPrimaryAction() # Stop Terra Surge animation
    if eventPlayer.isUsingAbility1():
        damage(eventPlayer, null, OW2_ORISA_FORTIFY_OVERHEALTH/(1-OW2_ORISA_FORTIFY_DAMAGE_REDUCTION)) # Remove shield gained from Terra Surge

    endDebuff() # Destroy any existing debuff
    waitUntil(eventPlayer.isOnGround(), Math.INFINITY)
    startDebuff() # Start new debuff
    wait(ORISA_DEBUFF_DURATION, Wait.RESTART_WHEN_TRUE) # Start debuff timer
    endDebuff()


def startDebuff():
    @Name "[orisa/debuff.opy]: startDebuff()"

    eventPlayer.orisa_debuff_origin = eventPlayer.getPosition() + ORISA_DEBUFF_HEIGHT/2*Vector.UP

    eventPlayer.setUltCharge(0)
    eventPlayer.setUltEnabled(false) # Prevent Orisa from getting ult charge
    eventPlayer.communicate(Comms.VOICE_LINE_UP) # Play ultimate voice line

    # Supercharge GUI
    if eventPlayer.orisa_debuff_id == null:
        createEffect(getAllPlayers(), 
                     Effect.SPHERE, 
                     Color.LIME_GREEN, 
                     eventPlayer.orisa_debuff_origin + ORISA_DEBUFF_HEIGHT/4*Vector.UP, 
                     ORISA_DEBUFF_HEIGHT/3, 
                     EffectReeval.NONE)
        eventPlayer.orisa_debuff_id = getLastCreatedEntity()
    if eventPlayer.orisa_debuff_id1 == null:
        createEffect(getAllPlayers(), 
                     Effect.SPHERE, 
                     Color.LIME_GREEN, 
                     eventPlayer.orisa_debuff_origin + ORISA_DEBUFF_HEIGHT/4*Vector.DOWN, 
                     ORISA_DEBUFF_HEIGHT/3, 
                     EffectReeval.NONE)
        eventPlayer.orisa_debuff_id1 = getLastCreatedEntity()
    
    # debuff deploy effect
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.GREEN, eventPlayer.orisa_debuff_origin, 3)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.GREEN, eventPlayer.orisa_debuff_origin, 200)

    # Announce debuff active
    eventPlayer.is_using_debuff = true


def endDebuff():
    @Name "[orisa/debuff.opy]: endDebuff()"

    eventPlayer.setUltEnabled(true)
    destroyEffect(eventPlayer.orisa_debuff_id)
    eventPlayer.orisa_debuff_id = null
    destroyEffect(eventPlayer.orisa_debuff_id1)
    eventPlayer.orisa_debuff_id1 = null
    eventPlayer.is_using_debuff = false
    getPlayers(eventPlayer.getTeam()).is_debuff = false

    # Clear debuff beam effects
    destroyEffect(eventPlayer.orisa_debuff_beam_id)
    eventPlayer.orisa_debuff_beam_id= null


rule "[orisa/debuff.opy]: nerf players in range":
    @Event eachPlayer
    @Condition eventPlayer.enemy_orisa_player.is_using_debuff
    @Condition (distance(eventPlayer, eventPlayer.enemy_orisa_player.orisa_debuff_origin) <= ORISA_DEBUFF_AOE_RADIUS and \
               isInLoS(eventPlayer, eventPlayer.enemy_orisa_player.orisa_debuff_origin, BarrierLos.PASS_THROUGH_BARRIERS))
    @Condition eventPlayer.isAlive()

    eventPlayer.is_debuff = true


rule "[orisa/debuff.opy]: revert players outside debuff range":
    @Event eachPlayer
    @Condition eventPlayer.enemy_orisa_player.is_using_debuff
    @Condition eventPlayer.is_debuff
    @Condition not (distance(eventPlayer, 
                             eventPlayer.enemy_orisa_player.orisa_debuff_origin) <= ORISA_DEBUFF_AOE_RADIUS \
                    and \
                    isInLoS(eventPlayer, 
                            eventPlayer.enemy_orisa_player.orisa_debuff_origin, 
                            BarrierLos.PASS_THROUGH_BARRIERS))
    
    wait(ORISA_DEBUFF_LINGER_TIME, Wait.ABORT_WHEN_FALSE)
    eventPlayer.is_debuff = false


rule "[orisa/debuff.opy]: revert nerfs when debuff is over":
    @Event eachPlayer
    @Hero orisa
    @Condition not eventPlayer.is_using_debuff
    
    getPlayers(eventPlayer.getTeam()).is_debuff = false


rule "[orisa/debuff.opy]: revert nerfs if player dies":
    @Event playerDied
    @Condition eventPlayer.is_debuff
    
    eventPlayer.is_debuff = false


rule "[orisa/debuff.opy]: nerf player when they have debuff":
    @Event eachPlayer
    @Condition eventPlayer.is_debuff

    setBaseDamage(eventPlayer, ORISA_DEBUFF_DAMAGE_PENALTY/ORISA_SUPERCHARGER_DAMAGE_MULTIPLIER)
    setBaseDefense(eventPlayer, ORISA_DEBUFF_DMG_RECEIVED_PENALTY/ORISA_CUSTOM_SUPERCHARGE_DEFENSE_MULTIPLIER)

    # Beam and sound effects
    if (eventPlayer.orisa_debuff_beam_id == null): # beam
        createBeam(getAllPlayers(), 
                   Beam.GOOD, 
                   eventPlayer.enemy_orisa_player.orisa_debuff_origin, 
                   (eventPlayer.getPosition() + eventPlayer.getEyePosition())/2, 
                   Color.BLUE, 
                   EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.orisa_debuff_beam_id = getLastCreatedEntity()
    if (eventPlayer.orisa_debuff_sound_id == null): # sound
        createEffect(eventPlayer, 
                     Effect.ENERGY_SOUND, 
                     Color.GREEN, 
                     eventPlayer.getPosition(), 
                     100, 
                     EffectReeval.POSITION_AND_RADIUS)
        eventPlayer.orisa_debuff_sound_id = getLastCreatedEntity()


rule "[orisa/debuff.opy]: revert nerfs if not debuff":
    @Event eachPlayer
    @Condition not eventPlayer.is_debuff
    
    eventPlayer.setDamageDealt(100)
    eventPlayer.setDamageReceived(100)
    
    # Beam and sound effects
    destroyEffect(eventPlayer.orisa_debuff_beam_id)
    eventPlayer.orisa_debuff_beam_id = null
    destroyEffect(eventPlayer.orisa_debuff_sound_id)
    eventPlayer.orisa_debuff_sound_id = null
