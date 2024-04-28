#!mainFile "../main.opy"

playervar dead_allies 
playervar self_resurrect_effect 
playervar count_dead_allies 
playervar resurrect_allies 
playervar resurrect_hud_icons_1 
playervar resurrect_hud_icons_2 


rule "[mercy/resurrect.opy]: Resurrect":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition len(eventPlayer.dead_allies) > 0
    @Condition isCCd(eventPlayer)
    @Condition eventPlayer.isDead() != true
    
    eventPlayer.communicate(Comms.HELLO)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer + vect(0, 0.5, 0), 15)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.YELLOW, eventPlayer + vect(0, 1, 0), 2)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 2.25)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.YELLOW, eventPlayer, 2000)
    eventPlayer.count_dead_allies = 0
    eventPlayer.dead_allies.resurrect_allies = true
    eventPlayer.dead_allies = []
    createEffect(getAllPlayers(), Effect.CLOUD, Color.YELLOW, eventPlayer, 5, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    eventPlayer.self_resurrect_effect = getLastCreatedEntity()
    eventPlayer.setUltEnabled(false)
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    wait(0.064)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    #wait this amount of time for the voiceline to finish, then immediately destroy bot
    wait(1.635)
    destroyDummy(eventPlayer.getTeam(), 5)
    #to equal the time left remaining for the total waits to equal 2.25 seconds
    wait(0.551)
    eventPlayer.setUltEnabled(true)
    destroyEffect(eventPlayer.self_resurrect_effect)

rule "[mercy/resurrect.opy]: Hud Counter":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() == 100
    @Condition len(eventPlayer.dead_allies) != eventPlayer.count_dead_allies
    @Condition eventPlayer.isDead() != true
    @Condition eventPlayer.isInSpawnRoom() != true
    @Condition eventPlayer.isDummy() != true
    
    eventPlayer.count_dead_allies = len(eventPlayer.dead_allies)
    hudSubtext(eventPlayer if len([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if distance(i.getPosition(), eventPlayer.getPosition()) <= 15]) > 0 else null, " \r\n \r\n \r\n \r\n ", HudPosition.TOP, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.resurrect_hud_icons_1 = getLastCreatedText()
    hudSubtext(eventPlayer if len([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if distance(i.getPosition(), eventPlayer.getPosition()) <= 15]) > 0 else null, "       /  \\ \r\n     /      \\ \r\n   /  {1}×{0}\r\n  --------".format(len([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if distance(i.getPosition(), eventPlayer.getPosition()) <= 15]), iconString(Icon.SKULL)), HudPosition.TOP, 5, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    eventPlayer.resurrect_hud_icons_2 = getLastCreatedText()
    waitUntil(not eventPlayer.dead_allies or eventPlayer.getUltCharge() < 100, Math.INFINITY)
    destroyAllHudTexts()
    wait()
    if RULE_CONDITION:
        goto RULE_START


rule "[mercy/resurrect.opy]: resurrect allies":
    @Event eachPlayer
    @Condition eventPlayer.resurrect_allies == true
    @Condition eventPlayer.isDummy() != true
    
    eventPlayer.disableRespawn()
    eventPlayer.startCamera(eventPlayer.getEyePosition() + vect(0, 2, 0) + eventPlayer.getFacingDirection() * -2, eventPlayer, 0)
    eventPlayer.resurrect()
    wait()
    eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getPosition() + eventPlayer.getFacingDirection() * 100, 3)
    wait()
    eventPlayer.resurrect()
    heal(eventPlayer, null, Math.INFINITY)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.YELLOW, eventPlayer, 2000)
    wait(2.25)
    eventPlayer.stopCamera()
    eventPlayer.resurrect_allies = 0
    eventPlayer.enableRespawn()

rule "[mercy/resurrect.opy]: fix issue": # fix an issue where rez hud still applies after death
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isDead() == true
    @Condition eventPlayer.isInSpawnRoom() != true
    @Condition eventPlayer.isDummy() != true
    
    destroyHudText(eventPlayer.resurrect_hud_icons_1)
    destroyHudText(eventPlayer.resurrect_hud_icons_2)
    wait(0.064)
    if eventPlayer.isDead() == true:
        goto RULE_START

rule "[mercy/resurrect.opy]: Add array to dead allies":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isInSpawnRoom() != true
    @Condition eventPlayer.isDummy() != true
    
    eventPlayer.dead_allies = [player for player in getPlayersInRadius(worldVector(vect(0, 0, 0), eventPlayer, Transform.ROTATION_AND_TRANSLATION), 15, eventPlayer.getTeam(), LosCheck.OFF) if player.isDead()]
    wait()
    if RULE_CONDITION:
        goto RULE_START