#!mainFile "../main.opy"

playervar ally_bubble_cooldown
playervar ally_bubble_cd_text

#!define initAllyBubble()\
    eventPlayer.ally_bubble_cooldown = 0


#!define showAllyBubbleCD()\
    if eventPlayer.ally_bubble_cd_text == null:\
        createInWorldText(eventPlayer,\
                        "{0}".format(ceil(eventPlayer.ally_bubble_cooldown)),\
                        updateEveryTick(eventPlayer.getEyePosition() + (100 * (2.3 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((-1.46 - 0.2) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()),\
                        verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))),\
                        3,\
                        Clip.NONE,\
                        WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR,\
                        Color.WHITE,\
                        SpecVisibility.DEFAULT)\
        eventPlayer.ally_bubble_cd_text = getLastCreatedText()

#!define hideAllyBubbleCD()\
    destroyInWorldText(eventPlayer.ally_bubble_cd_text)\
    eventPlayer.ally_bubble_cd_text = null


rule "[zarya/ally_bubble.opy]:  zarya ally bubble cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.setAbilityCharge(Button.ABILITY_2, 2)
    eventPlayer.setAbility2Enabled(false)
    wait(ZARYA_BUBBLE_DURATION)
    eventPlayer.ally_bubble_cooldown = ZARYA_PROJECTED_BARRIER_COOLDOWN_TIME
    chase(eventPlayer.ally_bubble_cooldown, 0, rate=1, ChaseReeval.NONE)


rule "[zarya/ally_bubble.opy]: Disable ally bubble if on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.ally_bubble_cooldown > 0

    eventPlayer.setAbility2Enabled(false)
    showAllyBubbleCD()


rule "[zarya/ally_bubble.opy]: Enable ally bubble if not on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.ally_bubble_cooldown <= 0

    eventPlayer.setAbility2Enabled(true)
    hideAllyBubbleCD()