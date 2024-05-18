#!mainFile "../main.opy"

#!include "heroes/bastion/self_repair.opy"
#!include "heroes/bastion/machine_gun.opy"
#!include "heroes/bastion/configuration.opy"

rule "[bastion/init_bastion.opy] init bastion":
    @Event eachPlayer
    @Hero bastion
    #@Condition eventPlayer.call_init == true
    
    defaultHero()
    newHero(BASTION_HEALTH,BASTION_HEALTH_ARMOUR, 0)
    setUltCost(BASTION_ULT_COST)
    #eventPlayer.hp_health = 225
    #eventPlayer.hp_armour = 75
    #applyCustomHealth()
    #eventPlayer.setSecondaryFireEnabled(false)
     
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    applyCustomHp()
    removePassiveHealing()

rule "[hero_switch.opy]: Detect switch to bastion":
    @Event eachPlayer
    @Hero bastion
    @Condition eventPlayer._hero_switched
       
    eventPlayer.call_init = true    

rule "[bastion/init.opy]: Clean up Bastion":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.BASTION
    
    waitUntil(eventPlayer.getCurrentHero() != Hero.BASTION, Math.INFINITY)
    hideMachineGunAmmo()