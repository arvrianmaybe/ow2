#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/roadhog/breather.opy"
#!include "heroes/roadhog/wholehog.opy"
#!include "heroes/roadhog/scrap_gun.opy"
#!include "heroes/roadhog/hook.opy"


rule "[roadhog/init_roadhog.opy] init roadhog":
    @Event eachPlayer
    @Hero roadhog
    #@Condition eventPlayer.call_init == true
    
    removeTankPassive()
    defaultHero()
    newHero(ROADHOG_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(ROADHOG_ULT_COST)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.setHealingDealt(percent(ROADHOG_BREATHER_HEAL_TOTAL/OW2_ROADHOG_BREATHER_HEAL_TOTAL))

rule "[hero_switch.opy]: Detect switch to roadhog":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    
