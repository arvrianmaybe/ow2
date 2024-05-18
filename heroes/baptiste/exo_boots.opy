#!mainFile "../main.opy"

playervar isExoCharged 


rule "[baptiste/exo_boots.opy] start exo boots if bap is standing and crouching and is fully charged":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.isOnGround() == true
    @Condition eventPlayer.isCrouching() == true
    
    wait(0.7, Wait.ABORT_WHEN_FALSE)
    eventPlayer.isExoCharged = true


rule "[baptiste/exo_boots.opy] any direction exo boots cancel if not crouching":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.isCrouching() == false
    
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.isExoCharged = false


rule "[baptiste/exo_boots.opy] any direction exo boots inward":
    @Event eachPlayer
    @Condition eventPlayer.isJumping() == true
    @Condition eventPlayer.isExoCharged == true
    
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), 20, Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)


rule "[baptiste/exo_boots.opy] any direction exo boots false":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BAPTISTE
    @Condition eventPlayer.isInAir() == true
    
    eventPlayer.isExoCharged = false