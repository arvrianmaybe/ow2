#!mainFile "../main.opy"

rule "[mccree/flashbang.opy]: Stun flashed enemy":
    @Event playerDealtDamage
    @Hero mccree
    @Condition eventAbility == Button.ABILITY_2

    victim.setStatusEffect(eventPlayer, Status.STUNNED, MCCREE_FLASHBANG_STUN_DURATION)
