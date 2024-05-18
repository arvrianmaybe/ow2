#!mainFile "../main.opy"

/*
rule "[lucio/soundwave.opy]: Soundwave damage increase":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    heal(victim, null, eventDamage - eventDamage*(LUCIO_SOUNDWAVE_DAMAGE/OW2_LUCIO_SOUNDWAVE_DAMAGE))
*/

rule "[lucio/soundwave.opy] boop knocks you forward base on your speed":
    @Event eachPlayer
    @Condition eventPlayer.isFiringSecondaryFire() == true
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == false
    
    eventPlayer.applyImpulse(eventPlayer.getFacingDirection(), eventPlayer.getSpeed(), Relativity.TO_WORLD, Impulse.CANCEL_CONTRARY_MOTION)