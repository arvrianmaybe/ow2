#!mainFile ".,./../main.opy"

globalvar  health_pool

playervar hero_id_duplicated

#!define cancelDuplication()\
 kill(eventPlayer,eventPlayer)

rule "[echo/duplicate.opy]: Table of all heroes with custom hp":
    # tanks
    health_pool[heroID(Hero.DVA)] = [DVA_HEALTH,DVA_ARMOR,0]
    health_pool[heroID(Hero.HAMMOND)] = [WRECKING_BALL_HEALTH,WRECKING_BALL_ARMOR,0]
    health_pool[heroID(Hero.JUNKER_QUEEN)] = [JUNKERQUEEN_HEALTH,JUNKERQUEEN_ARMOR,0]
    health_pool[heroID(Hero.MAUGA)] = [MAUGA_HEALTH,0,0]
    health_pool[heroID(Hero.ORISA)] = [ORISA_HEALTH,ORISA_HEALTH_ARMOR,0]
    health_pool[heroID(Hero.RAMATTRA)] = [RAMATTRA_HEALTH,0,RAMATTRA_SHIELDS]
    health_pool[heroID(Hero.REINHARDT)] = [REINHARDT_HEALTH,REINHARDT_ARMOR,0]
    health_pool[heroID(Hero.ROADHOG)] = [ROADHOG_HEALTH,0,0]
    health_pool[heroID(Hero.SIGMA)] = [SIGMA_HEALTH,0,SIGMA_SHIELDS]
    health_pool[heroID(Hero.WINSTON)] = [WINSTON_HEALTH,WINSTON_ARMOR,0]
    health_pool[heroID(Hero.ZARYA)] = [ZARYA_HEALTH,0,ZARYA_SHIELDS]

    # damage
    health_pool[heroID(Hero.ASHE)] = [ASHE_HEALTH,0,0]
    health_pool[heroID(Hero.BASTION)] = [BASTION_HEALTH,BASTION_ARMOR,0]
    health_pool[heroID(Hero.MCCREE)] = [MCCREE_HEALTH,0,0]
    health_pool[heroID(Hero.DOOMFIST)] = [DOOMFIST_HEALTH,0,0]
    health_pool[heroID(Hero.GENJI)] = [GENJI_HEALTH,0,0]
    health_pool[heroID(Hero.HANZO)] = [HANZO_HEALTH,0,0]
    health_pool[heroID(Hero.JUNKRAT)] = [JUNKRAT_HEALTH,0,0]
    health_pool[heroID(Hero.MEI)] = [MEI_HEALTH,0,0]
    health_pool[heroID(Hero.PHARAH)] = [PHARAH_HEALTH,0,0]
    health_pool[heroID(Hero.REAPER)] = [REAPER_HEALTH,0,0]
    health_pool[heroID(Hero.SOLDIER)] = [SOLDIER_HEALTH,0,0]
    health_pool[heroID(Hero.SOJOURN)] = [SOJOURN_HEALTH,0,0]
    health_pool[heroID(Hero.SOMBRA)] = [SOMBRA_HEALTH,0,0]
    health_pool[heroID(Hero.SYMMETRA)] = [SYMMETRA_HEALTH,0,SYMMETRA_SHIELDS]
    health_pool[heroID(Hero.TORBJORN)] = [TORBJORN_HEALTH,TORBJORN_ARMOR,0]
    health_pool[heroID(Hero.TRACER)] = [TRACER_HEALTH,0,0]
    health_pool[heroID(Hero.VENTURE)] = [VENTURE_HEALTH,0,0]
    health_pool[heroID(Hero.WIDOWMAKER)] = [WIDOWMAKER_HEALTH,0,0]

    # supports
    health_pool[heroID(Hero.ANA)] = [ANA_HEALTH,0,0]
    health_pool[heroID(Hero.BAPTISTE)] = [BAPTISTE_HEALTH,0,0]
    health_pool[heroID(Hero.BRIGITTE)] = [BRIGITTE_HEALTH,BRIGITTE_HEALTH_ARMOR,0]
    health_pool[heroID(Hero.ILLARI)] = [ILLARI_HEALTH,0,0]
    health_pool[heroID(Hero.KIRIKO)] = [KIRIKO_HEALTH,0,0]
    health_pool[heroID(Hero.LIFEWEAVER)] = [LIFEWEAVER_HEALTH,0,0]
    health_pool[heroID(Hero.LUCIO)] = [LUCIO_HEALTH,0,0]
    health_pool[heroID(Hero.MERCY)] = [MERCY_HEALTH,0,0]
    health_pool[heroID(Hero.MOIRA)] = [MOIRA_HEALTH,0,0]
    health_pool[heroID(Hero.ZENYATTA)] = [ZENYATTA_HEALTH,0,ZENYATTA_SHIELDS]

rule "[echo/duplicate.opy]: Set Life for echo when duplicating a tank":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.isDuplicatingAHero()
    
    clearCustomHp()
    eventPlayer.hero_id_duplicated = heroID(eventPlayer.getHeroOfDuplication())
    wait(1)
    setCustomHp(
        health_pool[eventPlayer.hero_id_duplicated][0],
        health_pool[eventPlayer.hero_id_duplicated][1],
        health_pool[eventPlayer.hero_id_duplicated][2],
    )

rule "[echo/duplicate.opy]: Reinitialize echo after exiting duplicate":
    @Event eachPlayer
    @Hero echo
    @Condition not eventPlayer.isDuplicatingAHero()

    resetHero()
    eventPlayer.call_init = true

rule "[echo/duplicate.opy]: Correct duplicate ultimate charge rate":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.isDuplicatingAHero()
    @Condition eventPlayer.getUltCharge() == 0

    wait()
    eventPlayer.setUltCharge((percent(1 - (OW2_ECHO_DUPLICATE_ULT_CHARGE_MULTIPLIER/ECHO_DUPLICATE_ULT_CHARGE_MULTIPLIER)))/OW2_ECHO_DUPLICATE_ULT_CHARGE_MULTIPLIER)

rule "[echo/duplcation.opy]: Reduce ultimate duration":
    @Event eachPlayer
    @Hero echo
    @Condition eventPlayer.isDuplicatingAHero()
        
    wait(ECHO_DUPLICATE_DURATION, Wait.ABORT_WHEN_FALSE)
    cancelDuplication()
