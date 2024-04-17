#!mainFile "../main.opy"

rule "[doomfist/powored_punch.opy]: heal overtime if blocking":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2() == true
    @Condition eventPlayer.getHealth() < eventPlayer.getMaxHealth()
    
    eventPlayer.startHoT(eventPlayer, DOOMFIST_POWER_BLOCK_DURATION, DOOMFIST_POWER_BLOCK_HEAL)
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    eventPlayer.stopAllHoT()

/*
rule "[doomfist/powered_block.opy]: Remove Empowered Punch from powered blocked":
    @Event eachPlayer
    @Hero doomfist
    @Condition eventPlayer.isUsingAbility2()
    
    eventPlayer.disallowButton(Button.ABILITY_2)
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    eventPlayer.startForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.016)
    eventPlayer.stopForcingButton(Button.SECONDARY_FIRE)
    eventPlayer.setSecondaryFireEnabled(false)
    wait()
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ABILITY_2)
*/