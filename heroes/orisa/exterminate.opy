#!mainFile "../main.opy"

playervar is_using_exterminate
playervar exterminate_player
playervar exterminate_player_effect

subroutine startExterminate
subroutine hideExterminate

rule "[orisa/exterminate.opy]: Trigger exterminate ability":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), Math.INFINITY) # Ensure player exterminate
    startExterminate()
    wait(ORISA_EXTERMINATE_DURATION)
    hideExterminate()


def startExterminate():
    @Name "[orisa/exterminate.opy]: startExterminate()"

    eventPlayer.is_using_exterminate = true # Starts Exterminate

    # Exterminate Player Effects
    if (eventPlayer.exterminate_player_effect[0] == null):
        createEffect(eventPlayer, Effect.LIGHT_SHAFT, rgb(129, 214, 90), updateEveryTick(eventPlayer.getPosition()), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS) # hex is #81d65a
        eventPlayer.exterminate_player_effect[0] = getLastCreatedEntity()
    if (eventPlayer.exterminate_player_effect[1] == null):
        createEffect(getAllPlayers(), Effect.SPARKLES, Color.LIME_GREEN, eventPlayer, 1.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.exterminate_player_effect[1] = getLastCreatedEntity()
    
    # Exterminate Sound
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.LIME_GREEN, eventPlayer, 100)

    # Exterminate Buffs
    eventPlayer.setDamageDealt(ORISA_EXTERMINATE_DAMAGE)
    eventPlayer.setMoveSpeed(percent(ORISA_EXTERMINATE_SPEED/ORISA_FORITFY_MOVEMENT_BONUS))


def hideExterminate():
    @Name "[orisa/exterminate.opy]: hideExterminate()"

    # Exterminate gone sound
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer, 100)

    # Clear exterminate effects
    destroyEffect(eventPlayer.exterminate_player_effect[0])
    eventPlayer.exterminate_player_effect[0] = null
    destroyEffect(eventPlayer.exterminate_player_effect[1])
    eventPlayer.exterminate_player_effect[1] = null

    # Cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, ORISA_EXTERMINATE_COOLDOWN)

    # Clean Up Player Buffs
    eventPlayer.setDamageDealt(100)
    eventPlayer.setMoveSpeed(100)

    eventPlayer.is_using_exterminate = false # Stop Exterminate
