#!mainFile "../main.opy"

#!include "heroes/orisa/fusion_driver.opy"
#!include "heroes/orisa/fortify.opy"
#!include "heroes/orisa/exterminate.opy"
#!include "heroes/orisa/halt.opy"
#!include "heroes/orisa/debuff.opy"

rule "[orisa/init.opy]: Detect switch to Orisa":
    @Event eachPlayer
    @Hero orisa

    eventPlayer.call_init = true


rule "[orisa/init.opy]: Initialize Orisa":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.call_init
    
    newHero(ORISA_HEALTH, ORISA_HEALTH_ARMOR, 0)
    setUltCost(ORISA_ULT_COST)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    # Below variables are also declared and initialized in reset_hero.opy

    resetFusionDriver()
    showOrisaAmmoHud()
    eventPlayer.is_orisa_reloading = false
    setBaseDamage(eventPlayer, ORISA_GUN_DAMAGE/OW2_ORISA_FUSION_DRIVER_DAMAGE)
    eventPlayer.setProjectileSpeed(percent(ORISA_GUN_PROJECTILE_SPEED/OW2_ORISA_GUN_PROJECTILE_SPEED))

    removeTankPassive()

    removePassiveHealing()

    eventPlayer.call_init = false


rule "[orisa/init.opy]: Clean up Orisa":
    @Event eachPlayer
    @Condition eventPlayer.getCurrentHero() == Hero.ORISA

    waitUntil(eventPlayer.getCurrentHero() != Hero.ORISA, Math.INFINITY)
    endDebuff()
    hideOrisaAmmoHud()
    hideExterminate()
