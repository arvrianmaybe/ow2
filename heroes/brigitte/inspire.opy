#!mainFile "../main.opy"

playervar inspire 


rule "[brigitte/inspire.opy] inspire detection":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition (eventAbility == Button.PRIMARY_FIRE or eventAbility == Button.ABILITY_1) == true
    
    eventPlayer.inspire = getPlayersInRadius(eventPlayer, 20, eventPlayer.getTeam(), LosCheck.SURFACES)
    wait(6, Wait.RESTART_WHEN_TRUE)
    eventPlayer.inspire = null


rule "[brigitte/inspire.opy] inspire start":
    @Event eachPlayer
    @Hero brigitte
    @Condition getNumberOfDamageModificationIds() < 1
    @Condition eventPlayer in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam()).inspire == true
    
    eventPlayer.setDamageDealt(BRIGITTE_INSPIRE_DAMAGE)
    waitUntil(not eventPlayer in getPlayersOnHero(Hero.BRIGITTE, eventPlayer.getTeam()).inspire, 99999)
    eventPlayer.setDamageDealt(BASE_DAMAGE)