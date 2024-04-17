#!mainFile "../main.opy"

rule "[dva/gun.opy]: pilot dva dmg":
    @Event playerDealtDamage
    @Hero dva
    @Condition eventPlayer.call_init
    @Condition eventPlayer.isInAlternateForm()
    
    eventPlayer.setDamageDealt(DVA_PILOT_DAMAGE)
    heal(victim, null, DVA_GUN_DAMAGE)

rule "[dva/gun.opy] abort if pilot dva not in alternative form":
    @Event eachPlayer
    @Hero dva

    @Condition eventPlayer.call_init
    @Condition eventPlayer.isInAlternateForm() == false

    eventPlayer.setDamageDealt(DVA_DAMAGE)