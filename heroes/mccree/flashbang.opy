#!mainFile "../main.opy"

rule "[mccree/flashbang.opy]: Stun flashed enemy":
    @Event playerDealtDamage
    @Hero mccree
    @Condition eventAbility == Button.ABILITY_2


    victim.setStatusEffect(eventPlayer, Status.STUNNED, MCCREE_FLASHBANG_STUN_DURATION)
    heal(victim, null, OW2_MCCREE_FLASHBANG_DAMAGE - MCCREE_FLASHBANG_DAMAGE)
    victim.setMoveSpeed(percent(1/OW2_MCCREE_FLASHBANG_SPEED_REDUCTION))
    wait(OW2_MCCREE_FLASHBANG_HINDER_DURATION)
    victim.setMoveSpeed(100)
