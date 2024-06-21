#!mainFile "../main.opy"

#!define MCCREE_FLASHBANG_DAMAGE_CORRECTION 20

rule "[mccree/flashbang.opy]: Stun flashed enemy":
    @Event playerDealtDamage
    @Hero mccree
    @Condition eventAbility == Button.ABILITY_2


    heal(victim, null, MCCREE_FLASHBANG_COOLDOWN)
    victim.setStatusEffect(eventPlayer, Status.STUNNED, MCCREE_FLASHBANG_STUN_DURATION)
