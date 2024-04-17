#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/hanzo/storm.opy"
#!include "heroes/hanzo/wall_climb.opy"

rule "[hanzo/init_hanzo.opy] init hanzo":
    @Event eachPlayer
    @Hero hanzo
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(HANZO_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(HANZO_ULT_COST)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to hanzo":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    

rule "[hanzo.opy]: Deal more primary fire damage":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.ABILITY_1]
    
    damage(victim, attacker, eventDamage*(HANZO_ARROW_DAMAGE/OW2_HANZO_ARROW_DAMAGE)-eventDamage)