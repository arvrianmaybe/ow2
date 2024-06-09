#!mainFile "../dev_main.opy"


globalvar DEBUG_MODE = createWorkshopSetting(bool, "Dev Tools", "debug mode", false)
#!define STAT_KEEP_ALIVE (2)
#!define STAT_SPACING (0.5)

playervar debug_pvar
#!define _total_damage_received debug_pvar[0]
#!define _last_damage_received debug_pvar[1]
#!define _total_healing_received debug_pvar[2]
#!define _last_healing_received debug_pvar[3]

rule "[debug.opy] Disable Inspector for performance":
    @Event global
    @Condition not DEBUG_MODE

    disableInspector()

rule "[debug.opy] global debug (Top Left)":
    @Event eachPlayer
    @Condition DEBUG_MODE == true

    hudHeader(getAllPlayers(), "Global", HudPosition.LEFT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "Server Load: {}%".format(getServerLoad()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "Server Load Average: {}%".format(getAverageServerLoad()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "Server Load Peak: {}%".format(getPeakServerLoad()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "isInSetup(): {}".format(isInSetup()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)
    hudSubheader(getAllPlayers(), "getTotalTimeElapsed(): {}".format(getTotalTimeElapsed()), HudPosition.LEFT, 1, Color.WHITE, HudReeval.VISIBILITY_AND_STRING)

rule "[debug.opy] player debug (Top Right)":
    @Event eachPlayer
    @Condition DEBUG_MODE == true

    hudHeader(eventPlayer, "Event Player", HudPosition.RIGHT, 0, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "call_init = {}".format(eventPlayer.call_init), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "isInAlternateForm() = {}".format(eventPlayer.isInAlternateForm()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "isUsingUltimate() = {}".format(eventPlayer.isUsingUltimate()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "isUsingAbility1() = {}".format(eventPlayer.isUsingAbility1()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer, "isUsingAbility2() = {}".format(eventPlayer.isUsingAbility2()), HudPosition.RIGHT, 1, Color.WHITE, HudReeval.STRING)
    hudSubheader(eventPlayer(), "getSpeed() = {}".format(eventPlayer.getSpeed()), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

rule "[debug.opy] unlimated ult":
    @Event eachPlayer
    @Condition DEBUG_MODE == true
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE)

    eventPlayer.setUltCharge(100)
    eventPlayer.forceButtonPress(Button.ULTIMATE)

rule "[debug.opy] Show Player Damage/Healing":
    @Event eachPlayer
    @Condition DEBUG_MODE

    # most recent damage
    createInWorldText(
        getAllPlayers() if eventPlayer._last_damage_received > 0 else null, 
        eventPlayer._last_damage_received, 
        eventPlayer.getEyePosition() + 1 * STAT_SPACING * Vector.UP, 
        1, 
        Clip.NONE, 
        WorldTextReeval.VISIBILITY_POSITION_AND_STRING, 
        Color.RED, 
        SpecVisibility.DEFAULT)

    # total healing
    createInWorldText(
        getAllPlayers() if eventPlayer._total_healing_received > 0 else null, 
        eventPlayer._total_healing_received, 
        eventPlayer.getEyePosition() + 2 * STAT_SPACING * Vector.UP, 
        2, 
        Clip.NONE, 
        WorldTextReeval.VISIBILITY_POSITION_AND_STRING, 
        Color.YELLOW, 
        SpecVisibility.DEFAULT)

    # total damage
    createInWorldText(
        getAllPlayers() if eventPlayer._total_damage_received > 0 else null, 
        eventPlayer._total_damage_received, 
        eventPlayer.getEyePosition() + 3 * STAT_SPACING * Vector.UP, 
        2, 
        Clip.NONE, 
        WorldTextReeval.VISIBILITY_POSITION_AND_STRING, 
        Color.RED, 
        SpecVisibility.DEFAULT)

    # most recent healing
    createInWorldText(
        getAllPlayers() if eventPlayer._last_healing_received > 0 else null, 
        eventPlayer._last_healing_received, 
        eventPlayer.getEyePosition() + 4 * STAT_SPACING * Vector.UP, 
        1, 
        Clip.NONE, 
        WorldTextReeval.VISIBILITY_POSITION_AND_STRING, 
        Color.YELLOW, 
        SpecVisibility.DEFAULT)


rule "[debug.opy] Debug damage instance":
    @Event playerTookDamage
    @Condition DEBUG_MODE

    printLog("attacker={}, victim={}, ability={}, amount={}".format(attacker, victim, eventAbility, eventDamage))

    victim._last_damage_received = eventDamage
    victim._total_damage_received += eventDamage
    wait(STAT_KEEP_ALIVE, Wait.RESTART_WHEN_TRUE)
    victim._last_damage_received = 0
    victim._total_damage_received = 0


rule "[debug.opy] Debug healing instance":
    @Event playerReceivedHealing
    @Condition DEBUG_MODE

    printLog("healer={}, healee={}, ability={}, amount={}".format(healer, healee, eventAbility, eventHealing))
    
    healee._last_healing_received = eventHealing
    healee._total_healing_received += eventHealing
    wait(STAT_KEEP_ALIVE, Wait.RESTART_WHEN_TRUE)
    healee._last_healing_received = 0
    healee._total_healing_received = 0

rule "[debug.opy] dummybot testing":
    @Event eachPlayer
    @Condition DEBUG_MODE
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.isHoldingButton(Button.CROUCH)

    destroyAllDummies()
    createDummy(Hero.ANA, getOppositeTeam(eventPlayer.getTeam()), -1, eventPlayer, eventPlayer) # feel free to change it to whatever character your testing. but always and i mean always
                                                                                                # set it back to the same old ana and opposite team
rule "[debug.opy] damage player":
    @Event eachPlayer
    @Condition DEBUG_MODE
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)

    eventPlayer.setStatusEffect(null, Status.UNKILLABLE, 2)
    damage(eventPlayer, null, Math.INFINITY)
    #wait()
    #if RULE_CONDITION:
        #goto RULE_START

rule "[debug.opy] heal player":
    @Event eachPlayer
    @Condition DEBUG_MODE
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)

    heal(eventPlayer, null, 1)
    wait()
    if RULE_CONDITION:
        goto RULE_START
