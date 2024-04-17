#!mainFile "../main.opy"

rule "[lucio/soundwave.opy]: Soundwave damage increase":
    @Event playerDealtDamage
    @Hero lucio
    @Condition eventAbility == Button.SECONDARY_FIRE
    
    heal(victim, null, eventDamage - eventDamage*(LUCIO_SOUNDWAVE_DAMAGE/OW2_LUCIO_SOUNDWAVE_DAMAGE))