#!mainFile "../main.opy"

/*
rule "[shotgun.opy] reset ammo when earning elimination":
    @Event playerEarnedElimination
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == false

    eventPlayer.setAmmo(0, REAPER_AMMO_CLIP)
*/
