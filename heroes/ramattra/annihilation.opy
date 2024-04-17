#!mainFile "../main.opy"

globalvar ULT_DURATION_WORKSHOP_SETTINGS = createWorkshopSetting(int[1:20], "Ramattra ult", "Annihilation duration", 4, 0)
globalvar ULT_DURATION_MAX = ULT_DURATION_WORKSHOP_SETTINGS 

playervar Ult_Duration 
playervar Progress_Bar 

rule "[ramattra/annihilation.opy]: increase annahilation damaage":
    @Event playerDealtDamage
    @Hero ramattra
    #@Condition eventAbility == Button.ABILITY_2
    @Condition eventPlayer.isUsingUltimate()
    
    damage(victim, null, eventDamage - (RAMATTRA_ANNIHILATION_DAMAGE/OW2_RAMATTRA_VORTEX_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar))

# thanks for Mathemann69 for letting me use this code (workshop.codes/PK7BH)

rule "[ramattra/annihilation.opy]: has spawned":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned() == true
    
    destroyProgressBarHud(eventPlayer.Progress_Bar)
    stopChasingVariable(eventPlayer.Ult_Duration)
    eventPlayer.Ult_Duration = ULT_DURATION_WORKSHOP_SETTINGS


rule "[ramattra/init_ramattra.opy] Invisible HUDs, to push down the progress bar":
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


rule "[ramattra/annihilation.opy]: init ultimate and chase variables":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.Ult_Duration = ULT_DURATION_WORKSHOP_SETTINGS
    progressBarHud(eventPlayer, eventPlayer.Ult_Duration * (100 / ULT_DURATION_MAX), "{0}s".format(round(eventPlayer.Ult_Duration)), HudPosition.TOP, 1000, Color.WHITE, Color.WHITE, ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, SpecVisibility.NEVER)
    eventPlayer.Progress_Bar = getLastCreatedText()
    wait()
    chase(eventPlayer.Ult_Duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    waitUntil(not eventPlayer.isUsingUltimate(), 99999)
    stopChasingVariable(eventPlayer.Ult_Duration)
    destroyProgressBarHud(eventPlayer.Progress_Bar)
    wait()
    eventPlayer.Ult_Duration = ULT_DURATION_WORKSHOP_SETTINGS


rule "[ramattra/annihilation.opy]: stop chasing if dealing damage":
    @Event playerDealtDamage
    @Hero ramattra
    @Condition eventAbility == Button.ULTIMATE
    @Condition eventAbility != Button.PRIMARY_FIRE
    @Condition eventAbility != Button.ABILITY_2
    @Condition eventAbility != Button.MELEE
    @Condition eventAbility != null
    
    stopChasingVariable(eventPlayer.Ult_Duration)
    wait(0.25, Wait.RESTART_WHEN_TRUE)
    chase(eventPlayer.Ult_Duration, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)


rule "[ramattra/annihilation.opy]: camcel ult if hit 0":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.Ult_Duration <= 0
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.forceButtonPress(Button.ABILITY_1)
    wait()
    if RULE_CONDITION:
        goto RULE_START