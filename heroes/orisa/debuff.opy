#!mainFile "../main.opy"

playervar is_using_debuff
playervar orisa_debuff_sound_id
playervar orisa_debuff_effects_id

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
                       LosCheck.SURFACES).setStatusEffect(null, Status.PHASED_OUT, 0.016)
    eventPlayer.forceButtonPress(Button.ULTIMATE)
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "[orisa/debuff.opy]: Trigger Debuff start":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate()
    @Condition isInLoS(eventPlayer, eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())), BarrierLos.BLOCKED_BY_ENEMY_BARRIERS) == true # has to be on los

    wait(ORISA_DEBUFF_CAST_TIME, Wait.ABORT_WHEN_FALSE) # cast time
    eventPlayer.cancelPrimaryAction() # Stop Terra Surge animation
    if eventPlayer.isUsingAbility1():
        damage(eventPlayer, null, OW2_ORISA_FORTIFY_OVERHEALTH/(1-OW2_ORISA_FORTIFY_DAMAGE_REDUCTION)) # Remove shield gained from Terra Surge

    startDebuff() # Start debuff
    wait(ORISA_DEBUFF_DURATION) # debuff duration
    endDebuff() # End debuff


rule "[orisa/debuff.opy]: no terra surge":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.cancelPrimaryAction() # Stop Terra Surge animation


def startDebuff():
    @Name "[orisa/debuff.opy]: startDebuff()"

    eventPlayer.setUltCharge(0)
    eventPlayer.setUltEnabled(false) # Dont gain any ult during debuff

    eventPlayer.is_using_debuff = true # start debuff

    # Debuff GUI
    
    if eventPlayer.orisa_debuff_effects_id[0] == null:
    createEffect(getAllPlayers(), 
    Effect.SPHERE, 
    rgb(162, 112, 184), 
    eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())), 
    1, 
    EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.orisa_debuff_effects_id[0] = getLastCreatedEntity()
    if eventPlayer.orisa_debuff_effects_id[1] == null:
    createEffect(getAllPlayers(), 
    Effect.SPARKLES, 
    rgb(162, 112, 184), 
    eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())), 
    1, 
    EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.orisa_debuff_effects_id[1] = getLastCreatedEntity()

    # Impact Sound Effects
    if (eventPlayer.orisa_debuff_sound_id == null):
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.WHITE, eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())), Math.INFINITY)
    playEffect(getAllPlayers(), DynamicEffect.DEBUFF_IMPACT_SOUND, Color.WHITE, eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())), Math.INFINITY)
    eventPlayer.orisa_debuff_sound_id = getLastCreatedEntity()

def endDebuff():
    @Name "[orisa/debuff.opy]: endDebuff()"

    eventPlayer.setUltEnabled(true) # Gain Ult 

    # Destroy Effects
    destroyEffect(eventPlayer.orisa_debuff_effects_id[0])
    eventPlayer.orisa_debuff_effects_id[0] = null
    destroyEffect(eventPlayer.orisa_debuff_effects_id[1])
    eventPlayer.orisa_debuff_effects_id[1] = null

    #eventPlayer.enemy_orisa_player.is_using_debuff

    eventPlayer.is_using_debuff = false # stop debuff

    # End Nerfs
    eventPlayer.setDamageDealt(percent(eventPlayer._base_damage_scalar))
    eventPlayer.setDamageReceived(percent(eventPlayer._base_damage_scalar))

#ule "[orisa/debuff.opy]: remove debuffs if debuff is over":
    #@Event eachPlayer
    #@Condition eventPlayer.enemy_orisa_player.is_using_debuff
    #@Condition not eventPlayer.is_using_debuff


rule "[orisa/debuff.opy]: remove debuffs if victim died":
    @Event playerDied
    @Condition eventPlayer.is_using_debuff

    eventPlayer.is_using_debuff = false

rule "[orisa/debuff.opy]: Revert nerfs if not using debuff":
    @Event eachPlayer
    @Condition not eventPlayer.is_using_debuff
    
    eventPlayer.setDamageDealt(percent(eventPlayer._base_damage_scalar))
    eventPlayer.setDamageReceived(percent(eventPlayer._base_damage_scalar))

rule "[orisa/debuff.opy]: start debuff nerfs":
    @Event eachPlayer
    @Condition eventPlayer.is_using_debuff

    eventPlayer.setDamageDealt(percent(ORISA_DEBUFF_DAMAGE_NERF - eventPlayer._base_damage_scalar))
    eventPlayer.setDamageReceived(percent(ORISA_DEBUFF_DAMAGE_RECIVED_NERF-eventPlayer._base_damage_scalar))