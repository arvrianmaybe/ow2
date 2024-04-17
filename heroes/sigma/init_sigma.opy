#!mainFile "../main.opy"

##!include "heroes/sigma/nemesis.opy"
##!include "heroes/sigma/vortex.opy"
##!include "heroes/sigma/annihilation.opy"

rule "[sigma/init_sigma.opy]: Detect switch to sigma":
    @Event eachPlayer
    @Hero sigma

    eventPlayer.call_init = true


rule "[sigma/init_sigma.opy]: Initialize sigma":
    @Event eachPlayer
    @Hero sigma
    @Condition eventPlayer.call_init
    
    newHero(SIGMA_HEALTH,0,SIGMA_SHIELDS)
    setUltCost(SIGMA_ULT_COST)

    removeTankPassive()

    removePassiveHealing()

    eventPlayer.call_init = false

rule "[sigma.opy]: Change accretion damage":
    @Event playerDealtDamage
    @Hero sigma
    @Condition eventAbility == Button.ABILITY_2
    @Condition eventDamage > OW2_SIGMA_ACCRETION_DIRECT_HIT_DAMAGE
    
        damage(victim, attacker, eventDamage*(SIGMA_ACCRETION_DAMAGE/OW2_SIGMA_ACCRETION_DAMAGE)-eventDamage)