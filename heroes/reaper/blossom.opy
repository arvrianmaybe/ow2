#!mainFile "../main.opy"

rule "[reaper/blossom.opy]:  deal less Death Blossom damage":
    @Event playerDealtDamage
    @Hero reaper
    @Condition eventAbility == Button.ULTIMATE

    heal(victim, null, eventDamage - (REAPER_DEATH_BLOSSON_DAMAGE/OW2_REAPER_DEATH_BLOSSON_DAMAGE) * eventDamage)

rule "[reaper/blossom.opy]:  no reaping passive during ult":
    @Event playerDealtDamage
    @Hero reaper
    @Condition eventPlayer.isUsingUltimate() == true
    
    eventPlayer.setHealingDealt(0)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setHealingDealt(100)
