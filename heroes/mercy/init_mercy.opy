#!mainFile "../main.opy"

#!include "heroes/mercy/guardian.opy"


rule "[mercy/init_mercy.opy]: Detect switch to Mercy":
    @Event eachPlayer
    @Hero mercy

    eventPlayer.call_init = true


rule "[mercy/init_mercy.opy]: Initialize Mercy":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.call_init
    
    newHero(MERCY_HEALTH, 0, 0)
    setUltCost(MERCY_ULT_COST)
    eventPlayer.setAmmo(0, MERCY_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0, MERCY_CLIP_SIZE)

    eventPlayer.is_using_guardian_angel = false
    eventPlayer.is_slingshotting = false
    eventPlayer.call_init = false