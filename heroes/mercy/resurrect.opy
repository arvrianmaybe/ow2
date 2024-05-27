#!mainFile "../main.opy"

playervar resurrect_pvar

#!defineMember count_dead_allies resurrect_pvar[2]
#!defineMember res_allies resurrect_pvar[3]
#!defineMember dead_allies resurrect_pvar[4]
#!defineMember res_hud_icon_1 resurrect_pvar[7]
#!defineMember res_hud_icon_2 resurrect_pvar[8]

#!define MERCY_ULT_VOICELINE_DUR 1.635
#!define MERCY_MAS_RES_DURATION 0.65
#!define RES_WAIT 2.25

playervar is_using_res

playervar mercy_res_id


subroutine startMassRes
subroutine stopMassRes

/*
rule "[mercy/resurrect.opy]: dummybot init":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isDummy()

    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, Math.INFINITY)
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setUltCharge(100)
    eventPlayer.forceButtonPress(Button.ULTIMATE)\
*/

rule "[mercy/resurrect.opy]: Store dead allies in an array":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() >= 100
    @Condition not eventPlayer.isInSpawnRoom()
    
    do:
        eventPlayer.dead_allies = [player for player in getPlayersInRadius(worldVector(vect(0, 0, 0), eventPlayer, Transform.ROTATION_AND_TRANSLATION), 15, eventPlayer.getTeam(), LosCheck.OFF) if player.isDead()]
        wait()
    while RULE_CONDITION

def startMassRes():
    @Name "[mercy/resurrect.opy]: startMassRes()"

    # Ult Disable
    eventPlayer.setUltCharge(0)
    eventPlayer.setUltEnabled(false) # Prevent Mercy from getting ult charge
    #eventPlayer.communicate(Comms.VOICE_LINE_UP) # Play ultimate voice line

    # Dummybot Ult Voiceline
    #createDummy(Hero.MERCY, eventPlayer.getTeam(), 7, eventPlayer, eventPlayer)

    # mass res sound eeffects
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.YELLOW, eventPlayer, Math.INFINITY)
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION, Color.YELLOW, eventPlayer, Math.INFINITY)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.YELLOW, eventPlayer, Math.INFINITY)

    createEffect(getAllPlayers(), Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer, Math.INFINITY, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)

    # Res Player Effects
    if (eventPlayer.mercy_res_id == null):
        createEffect(getAllPlayers(), Effect.SPARKLES_SOUND, Color.WHITE, eventPlayer, Math.INFINITY, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        eventPlayer.mercy_res_id = getLastCreatedEntity()

    # Effects
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 1)

def stopMassRes():
    @Name "[mercy/resurrect.opy]: stopMassRes()"

    # Ult enable
    eventPlayer.setUltCharge(0)
    eventPlayer.setUltEnabled(true)

    # Gone Effects
    playEffect(getAllPlayers(), DynamicEffect.RING_EXPLOSION_SOUND, Color.YELLOW, eventPlayer, 15)
    playEffect(getAllPlayers(), DynamicEffect.BAD_EXPLOSION, Color.YELLOW, eventPlayer, Math.INFINITY)

    # Clear exterminate effects
    destroyEffect(eventPlayer.mercy_res_id)
    eventPlayer.mercy_res_id = null

    # Destroy Dummy
    #destroyDummy(eventPlayer.getTeam(), 7)



rule "[mercy/resurrect.opy]: Trigger res":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)
    #@Condition eventPlayer.isUsingUltimate()
    @Condition len(eventPlayer.dead_allies) > 0
    @Condition not isCCd(eventPlayer)
    @Condition not eventPlayer.isDead()
    
    startMassRes()
    eventPlayer.count_dead_allies = 0
    eventPlayer.dead_allies.res_allies = true
    eventPlayer.dead_allies = []
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    wait(MERCY_MAS_RES_DURATION)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)
    #wait(MERCY_ULT_VOICELINE_DUR)
    stopMassRes()



rule "[mercy/resurrect.opy]: HUD counter":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() >= 100
    @Condition len(eventPlayer.dead_allies) != eventPlayer.count_dead_allies
    @Condition not eventPlayer.isDead()
    @Condition not eventPlayer.isInSpawnRoom()
    
    do:
        eventPlayer.count_dead_allies = len(eventPlayer.dead_allies)
        if not eventPlayer.res_hud_icon_1:
            hudSubtext(eventPlayer if len([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if distance(i.getPosition(), eventPlayer.getPosition()) <= 15]) > 0 else null, " \r\n \r\n \r\n \r\n ", HudPosition.TOP, 1, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
            eventPlayer.res_hud_icon_1 = getLastCreatedText()
        if not eventPlayer.res_hud_icon_2:
            hudSubtext(eventPlayer if len([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if distance(i.getPosition(), eventPlayer.getPosition()) <= 15]) > 0 else null, "       /  \\ \r\n     /      \\ \r\n   /  {1}×{0}\r\n  --------".format(len([i for i in getDeadPlayers(eventPlayer.getTeam()).exclude(eventPlayer) if distance(i.getPosition(), eventPlayer.getPosition()) <= 15]), iconString(Icon.SKULL)), HudPosition.TOP, 5, Color.YELLOW, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
            eventPlayer.res_hud_icon_2 = getLastCreatedText()
        waitUntil(not eventPlayer.dead_allies or eventPlayer.getUltCharge() < 100, Math.INFINITY)
        destroyHudText(eventPlayer.res_hud_icon_1)
        eventPlayer.res_hud_icon_1 = null
        destroyHudText(eventPlayer.res_hud_icon_2)
        eventPlayer.res_hud_icon_2 = null
        wait()
    while RULE_CONDITION


rule "[mercy/resurrect.opy]: Resurrected player":
    @Event eachPlayer
    @Condition eventPlayer.res_allies
    
    eventPlayer.disableRespawn()
    eventPlayer.startCamera(eventPlayer.getEyePosition() + vect(0, 2, 0) + eventPlayer.getFacingDirection() * -2, eventPlayer, 0)
    eventPlayer.resurrect()
    wait()
    eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getPosition() + eventPlayer.getFacingDirection() * 100, 3)
    kill(eventPlayer, getPlayersOnHero(Hero.MERCY, eventPlayer.getTeam()))
    wait()
    eventPlayer.resurrect()
    heal(eventPlayer, null, 99999)
    eventPlayer.setStatusEffect(null, Status.ROOTED, RES_WAIT)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, RES_WAIT)
    eventPlayer.setStatusEffect(null, Status.BURNING, RES_WAIT)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.YELLOW, eventPlayer, Math.INFINITY)
    wait(RES_WAIT)
    eventPlayer.stopCamera()
    eventPlayer.res_allies = false
    eventPlayer.enableRespawn()


rule "[mercy/resurrect.opy]: Fix bug where rez HUD applied after death":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() >= 100
    @Condition eventPlayer.isDead()
    @Condition not eventPlayer.isInSpawnRoom()
    
    destroyHudText(eventPlayer.res_hud_icon_1)
    eventPlayer.res_hud_icon_1 = null
    destroyHudText(eventPlayer.res_hud_icon_2)
    eventPlayer.res_hud_icon_2 = null
    wait(0.064)
    if eventPlayer.isDead():
        goto RULE_START
