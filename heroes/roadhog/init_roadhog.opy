#!mainFile "../../main.opy"

#!include "heroes/roadhog/breather.opy"
#!include "heroes/roadhog/wholehog.opy"
#!include "heroes/roadhog/scrap_gun.opy"
#!include "heroes/roadhog/hook.opy"

rule "[roadhog/init_roadhog.opy] init roadhog":
    @Event eachPlayer
    @Hero roadhog
    
    defaultHero()
    newHero(ROADHOG_HEALTH, 0, 0)
    removePassiveHealing()
    removeTankPassive()
    setUltCost(ROADHOG_ULT_COST)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setHealingDealt(percent(ROADHOG_BREATHER_HEAL_TOTAL/OW2_ROADHOG_BREATHER_HEAL_TOTAL))

rule "[hero_switch.opy]: Detect switch to roadhog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
