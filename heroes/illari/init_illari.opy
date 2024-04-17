#!mainFile "../main.opy"

#!include "utilities/reset.opy"
#!include "utilities/custom_hp.opy"
#!include "utilities/hero_switched.opy"
#!include "heroes/illari/sun.opy"
#!include "heroes/illari/solar_rifle.opy"
#!include "heroes/illari/pylon.opy"

rule "[illari/init_illari.opy] init illari":
    @Event eachPlayer
    @Hero illari
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(ILLARI_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(ILLARI_ULT_COST)
    eventPlayer.setAmmo(0,ILLARI_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0,ILLARI_CLIP_SIZE)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()

    setBaseDamage(eventPlayer, ILLARI_RIFLE_DAMAGE/OW2_ILLARI_RIFLE_DAMAGE)

    eventPlayer.call_init = false

rule "[hero_switch.opy]: Detect switch to illari":
    @Event eachPlayer
    @Hero illari
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    

rule "[illari/init.opy]: Correct Outburst damage":
    @Event playerDealtDamage
    @Hero illari
    @Condition eventAbility == Button.ABILITY_1
      
    damage(victim, attacker, eventDamage*(ILLARI_OUTBURST_DAMAGE)-eventDamage)