#!mainFile "../main.opy"

globalvar ULT_DURATION_WORKSHOP_SETTINGS = createWorkshopSetting(int[1:20], "Ramattra ult", "Annihilation duration", 4, 0)
globalvar ULT_DURATION_MAX = ULT_DURATION_WORKSHOP_SETTINGS 

playervar ult_duration 
playervar current_hero 
playervar progress_bar 

rule "[ramattra/annihilation.opy]: increase annahilation damaage":
    @Event playerDealtDamage
    @Hero ramattra
    #@Condition eventAbility == Button.ABILITY_2
    @Condition eventPlayer.isUsingUltimate()
    
    damage(victim, null, eventDamage - (RAMATTRA_ANNIHILATION_DAMAGE/OW2_RAMATTRA_VORTEX_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar))

# thanks for Mathemann69 for letting me use this code (workshop.codes/PK7BH)

rule "[ramattra/annihilation.opy]: spawn":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    
    eventPlayer.current_hero = eventPlayer.getCurrentHero()
    destroyProgressBarHud(eventPlayer.progress_bar)
    stopChasingVariable(eventPlayer.ult_duration)
    eventPlayer.ult_duration = ULT_DURATION_WORKSHOP_SETTINGS


rule "[ramattra/annihilation.opy]: invis hud":
    #That pushes the main hud down
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 1, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 2, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 3, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 4, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 5, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 6, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 7, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 8, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 9, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)
    hudText(getAllPlayers(), null, " ", " ", HudPosition.TOP, 10, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY, SpecVisibility.NEVER)


rule "[ramattra/annihilation.opy]: start ult and chase variables":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    
    #eventPlayer.setAllowedHeroes(eventPlayer.getCurrentHero())
    eventPlayer.ult_duration = ULT_DURATION_WORKSHOP_SETTINGS
    progressBarHud(eventPlayer, eventPlayer.ult_duration * (100 / ULT_DURATION_MAX), "{0}s".format(round(eventPlayer.ult_duration)), HudPosition.TOP, 1000, Color.WHITE, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.NEVER)
    eventPlayer.progress_bar = getLastCreatedText()
    wait()
    chase(eventPlayer.ult_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    stopChasingVariable(eventPlayer.ult_duration)
    destroyProgressBarHud(eventPlayer.progress_bar)
    wait()
    eventPlayer.ult_duration = ULT_DURATION_WORKSHOP_SETTINGS
    #eventPlayer.setAllowedHeroes(getAllHeroes())


rule "[ramattra/annihilation.opy]: dealt dmg stop chase variables":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventAbility != Button.PRIMARY_FIRE
    @Condition eventAbility != Button.ABILITY_2
    @Condition eventAbility != Button.MELEE
    @Condition eventAbility != null
    
    stopChasingVariable(eventPlayer.ult_duration)
    wait(0.25, Wait.RESTART_WHEN_TRUE)
    chase(eventPlayer.ult_duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)


rule "[ramattra/annihilation.opy]: stop ult if varb hits 0":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.ult_duration <= 0
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait()
    if RULE_CONDITION:
        goto RULE_START
