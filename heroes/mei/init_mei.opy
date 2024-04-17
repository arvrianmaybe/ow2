#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/mei/blaster.opy"
##!include "heroes/mei/flashbang.opy"

rule "[mei/init_mei.opy] init mei":
    @Event eachPlayer
    @Hero mei
    #@Condition eventPlayer.call_init == true

    defaultHero()
    newHero(MEI_HEALTH, 0, 0)
    #eventPlayer.hp_health = 225
    removePassiveHealing()
    setUltCost(MEI_ULT_COST)
    eventPlayer.setAmmo(0,MEI_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0,MEI_CLIP_SIZE)
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to mei":
    @Event eachPlayer
    @Hero mei
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    

#Well [KRISPY KREME] Here We Are, Why Are You Playing Satan? I SPAMTON G SPAMTON Dont Approve Play Something Else [KRISPY KREME] Like Lucio!
# I SPAMTON G SPAMTON Does Not Approve Mei! Even Junkrat Is Better