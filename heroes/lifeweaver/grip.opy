#!mainFile "../main.opy"

playervar grip


rule "[lifeweaver/grip.opy] lifeweaver grip enemy":
    @Event eachPlayer
    @Hero lifeweaver
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0
    @Condition eventPlayer.isAlive() == true
    
    eventPlayer.grip[0] = eventPlayer.getPlayerClosestToReticle(Team.ALL)
    if not isInLoS(eventPlayer.grip[0], eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS):
        return
    createEffect(getAllPlayers(), Effect.SPHERE, Color.ROSE, eventPlayer.grip[0], 1.5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.grip[1] = getLastCreatedEntity()
    eventPlayer.grip[0].setGravity(0)
    eventPlayer.setMoveSpeed(50)
    while distance(eventPlayer, eventPlayer.grip[0]) >= 3:
        wait(0.1)
        eventPlayer.grip[0].applyImpulse(directionTowards(eventPlayer.grip[0], eventPlayer), 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)
        if not isInLoS(eventPlayer.grip[0], eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS):
            break
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, OW2_LIFEWEAVER_GRIP_COOLDOWN)
    destroyEffect(eventPlayer.grip[1])
    eventPlayer.setMoveSpeed(100)
    eventPlayer.grip[0].setGravity(100)