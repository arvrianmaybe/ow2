#!mainFile "../../dev_main.opy"

#!include "heroes/zenyatta/transc.opy"
#!include "heroes/zenyatta/discord.opy"

rule "[zenyatta/init.opy]: Initialize Zenyatta":
    @Event eachPlayer
    @Hero zenyatta
    @Condition eventPlayer._call_init

    setCustomHp(ZENYATTA_HEALTH, 0, ZENYATTA_SHIELDS)
    setUltCost(ZENYATTA_ULT_COST)
    removeSelfHealing()
    
    eventPlayer.setKnockbackDealt(percent(ZENYATTA_KNOCKBACK/OW2_ZENYATTA_KNOCKBACK))
    
    eventPlayer.setAmmo(0, ZENYATTA_CLIP_SIZE)
    eventPlayer.setMaxAmmo(0, ZENYATTA_CLIP_SIZE)
    eventPlayer._call_init = false


rule "[zenyatta/init.opy]: OW1 Zenyatta melee damage":
    @Event playerDealtDamage
    @Hero zenyatta
    @Condition eventAbility == null # for some reason, zenyatta melee doesn't show up as melee
    @Condition eventPlayer.isMeleeing()

    heal(victim, null, eventDamage - (MELEE_DAMAGE/OW2_ZENYATTA_MELEE_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar))
