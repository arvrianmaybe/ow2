#!mainFile "../main.opy"

rule "[pharah/concussive.opy]: no Concussive Blast damage":
    @Event playerDealtDamage
    @Hero pharah
    @Condition eventAbility == Button.ABILITY_2

    heal(victim, null, eventDamage)