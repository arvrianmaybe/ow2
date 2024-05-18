#!mainFile "../main.opy"
#!include "heroes/baptiste/reg_boost.opy"
#!include "heroes/baptiste/exo_boots.opy"

rule "[baptiste/baptiste.opy] init baptiste":
    @Event eachPlayer
    @Hero baptiste
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(BAPTISTE_HEALTH, 0, 0)
    #eventPlayer.hp_health = 200
    #applyCustomHealth()
    setUltCost(BAPTISTE_ULT_COST)
    eventPlayer.setAmmo(0,BAPTISTE_CLIP1_SIZE)
    eventPlayer.setMaxAmmo(0,BAPTISTE_CLIP1_SIZE)
    setBaseDamage(eventPlayer, BAPTISTE_PRIMARY_DAMAGE/OW2_BAPTISTE_PRIMARY_DAMAGE)
    eventPlayer.setAmmo(1, BAPTISTE_CLIP2_SIZE)
    eventPlayer.setMaxAmmo(1, BAPTISTE_CLIP2_SIZE)
    removePassiveHealing()
    wait()
    eventPlayer.disallowButton(Button.ABILITY_1)

rule "[hero_switch.opy]: Detect switch to baptiste":
    @Event eachPlayer
    @Hero baptiste
    @Condition eventPlayer._hero_switched
               
    eventPlayer.call_init = true    