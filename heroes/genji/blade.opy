#!mainFile "../main.opy"
#Bugged for some reason
/*
rule "[genji/blade.opy] genji blade double damage":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.setDamageDealt(percent(GENJI_BLADE/OW2_GENJI_BLADE))
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setDamageDealt(percent(eventPlayer._base_damage_scalar))


rule"[genji/blade.opy] 4 second cooldown on swift strike":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer.isUsingUltimate()
    @Condition eventAbility.isUsingAbility1()

    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 4)
*/