#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/genji/blade.opy"

rule "[genji/init_genji.opy] init genji":
    @Event eachPlayer
    @Hero genji
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(GENJI_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(GENJI_ULT_COST)
    eventPlayer.setAmmo(0,GENJI_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0,GENJI_CLIP_SIZE)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()

rule "[hero_switch.opy]: Detect switch to genji":
    @Event eachPlayer
    @Hero genji
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    


rule "[genji.opy]: Deal more shuriken damage":
    @Event playerDealtDamage
    @Hero genji
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.SECONDARY_FIRE]
    
    damage(victim, attacker, eventDamage*(GENJI_SHURIKEN_DAMAGE/OW2_GENJI_SHURIKEN_DAMAGE)-eventDamage)
    