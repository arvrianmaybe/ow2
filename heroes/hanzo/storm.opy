#!mainFile "../main.opy"

rule "[hanzo/storm.opy]:  storm arrow increase damage":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition eventAbility == Button.ABILITY_2

    damage(victim, null, eventDamage - eventDamage*(HANZO_STORM_DAMAGE/OW2_HANZO_STORM_DAMAGE))