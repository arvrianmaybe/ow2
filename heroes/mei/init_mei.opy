#!mainFile "../../main.opy"

#!include "utilities/hero_switched.opy"
#!include "heroes/mei/blaster.opy"

rule "[mei/init_mei.opy] init mei":
    @Event eachPlayer
    @Hero mei

    defaultHero()
    newHero(MEI_HEALTH, 0, 0)
    removePassiveHealing() 
    setUltCost(MEI_ULT_COST)
    eventPlayer.setAmmo(0,MEI_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0,MEI_CLIP_SIZE)

rule "[hero_switch.opy]: Detect switch to mei":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true
