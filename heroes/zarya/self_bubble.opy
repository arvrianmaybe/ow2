#!mainFile "../main.opy"

playervar self_bubble_cooldown
playervar self_bubble_cd_text

#!define initSelfBubble()\
    eventPlayer.self_bubble_cooldown = 0

#!define showSelfBubbleCD()\
    if eventPlayer.self_bubble_cd_text == null:\
        createInWorldText(eventPlayer,\
                        "{0}".format(ceil(eventPlayer.self_bubble_cooldown)),\
                        updateEveryTick(eventPlayer.getEyePosition() + (100 * (1.99 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + ((-1.44 - 0.2) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()),\
                        verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))),\
                        3,\
                        Clip.NONE,\
                        WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR,\
                        Color.WHITE,\
                        SpecVisibility.DEFAULT)\
        eventPlayer.self_bubble_cd_text = getLastCreatedText()

#!define hideSelfBubbleCD()\
    destroyInWorldText(eventPlayer.self_bubble_cd_text)\
    eventPlayer.self_bubble_cd_text = null


rule "[zarya/self_bubble.opy]:  zarya self bubble cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.setAbilityCharge(Button.ABILITY_1, 2)
    eventPlayer.setAbility1Enabled(false)
    wait(ZARYA_BUBBLE_DURATION) # 2 second bubble duration
    eventPlayer.self_bubble_cooldown = ZARYA_PARTICLE_BARRIER_COOLDOWN_TIME
    chase(eventPlayer.self_bubble_cooldown, 0, rate=1, ChaseReeval.NONE)


rule "[zarya/self_bubble.opy]: Disable self bubble if on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.self_bubble_cooldown > 0

    eventPlayer.setAbility1Enabled(false)
    showSelfBubbleCD()

rule "[zarya/self_bubble.opy]: Enable self bubble if not on cooldown":
    @Event eachPlayer
    @Hero zarya
    @Condition eventPlayer.self_bubble_cooldown <= 0

    eventPlayer.setAbility1Enabled(true)
    hideSelfBubbleCD()