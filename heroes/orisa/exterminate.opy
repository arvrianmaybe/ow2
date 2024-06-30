#!mainFile "../../main.opy"

playervar exterminate_pvar
#!defineMember _is_using_exterminate exterminate_pvar[0]
#!defineMember _exterminate_effect_id exterminate_pvar[1]
#!defineMember _exterminate_effect_id1 exterminate_pvar[2]

subroutine startExterminate
subroutine hideExterminate

rule "[orisa/exterminate.opy]: Trigger exterminate ability":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.isUsingAbility1() == false
    
    waitUntil(not eventPlayer.isHoldingButton(Button.ABILITY_2), Math.INFINITY) # Ensure player exterminate
    startExterminate()
    wait(ORISA_EXTERMINATE_DURATION)
    hideExterminate()


def startExterminate():
    @Name "[orisa/exterminate.opy]: startExterminate()"

    eventPlayer._is_using_exterminate = true # Starts Exterminate

    # Exterminate Player Effects
    if (eventPlayer._exterminate_effect_id == null):
        createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, rgb(129, 214, 90), updateEveryTick(eventPlayer.getPosition()), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS) # hex is #81d65a
        eventPlayer._exterminate_effect_id = getLastCreatedEntity()
    if (eventPlayer._exterminate_effect_id1 == null):
        createEffect(getAllPlayers(), Effect.SPARKLES, Color.LIME_GREEN, eventPlayer, 1.2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer._exterminate_effect_id1 = getLastCreatedEntity()
    
    # Exterminate Sound
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.LIME_GREEN, eventPlayer, 100)

    # Exterminate Buffs
    setBaseDamage(eventPlayer, ORISA_EXTERMINATE_GUN_DAMAGE/ORISA_GUN_DAMAGE)


def hideExterminate():
    @Name "[orisa/exterminate.opy]: hideExterminate()"

    # Exterminate gone sound
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.LIME_GREEN, eventPlayer, 100)

    # Clear exterminate effects
    destroyEffect(eventPlayer._exterminate_effect_id)
    eventPlayer._exterminate_effect_id = null
    destroyEffect(eventPlayer._exterminate_effect_id1)
    eventPlayer._exterminate_effect_id1 = null

    # Cooldown
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, ORISA_EXTERMINATE_COOLDOWN)

    # Clean Up Player Buffs
    setBaseDamage(eventPlayer, ORISA_GUN_DAMAGE/OW2_ORISA_FUSION_DRIVER_DAMAGE)

    eventPlayer._is_using_exterminate = false # Stop Exterminate

rule "[orisa/exterminate.opy]: abort exterminate if player uses fortify":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer._is_using_exterminate
    @Condition eventPlayer.isUsingAbility1()

    hideExterminate()

rule"[orisa/exterminate.opy]: abort exterminate if player got dealt with cc":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer._is_using_exterminate
    @Condition isCCd(eventPlayer)

    hideExterminate()
