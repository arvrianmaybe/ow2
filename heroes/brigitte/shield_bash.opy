#!mainFile "../../main.opy"

rule "[brigitte/shield_bash.opy] bring back stun":
    @Event playerDealtDamage
    @Hero brigitte
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    victim.setStatusEffect(eventPlayer, Status.STUNNED, BRIGITTE_STUN_DURATION)
    eventPlayer.clearStatusEffect(Status.STUNNED)
