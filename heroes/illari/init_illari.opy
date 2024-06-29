#!mainFile "../../main.opy"

#!include "heroes/illari/sun.opy"
#!include "heroes/illari/solar_rifle.opy"

rule "[illari/init_illari.opy] init illari":
    @Event eachPlayer
    @Hero illari
    
    defaultHero()
    newHero(ILLARI_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(ILLARI_ULT_COST)
    eventPlayer.setAmmo(0,ILLARI_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0,ILLARI_CLIP_SIZE)

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
