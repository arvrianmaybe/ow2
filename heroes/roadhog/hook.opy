#!mainFile "../main.opy"


playervar time_hook_was_active


rule "[roadhog/hook.opy]: Set custom hook cooldown":
    @Event eachPlayer
    @Hero roadhog
    @Condition eventPlayer.isUsingAbility1()
    
    eventPlayer.time_hook_was_active = 0
    chase(eventPlayer.time_hook_was_active, 3, rate=1, ChaseReeval.NONE)
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, ROADHOG_HOOK_COOLDOWN_TIME - eventPlayer.time_hook_was_active)

rule "[roadhog/hook.opy]:  hook damage":
    @Event playerDealtDamage
    @Hero roadhog
    @Condition eventAbility == Button.ABILITY_1

    damage(
        victim, 
        attacker, 
        (ROADHOG_HOOK_DAMAGE/OW2_ROADHOG_HOOK_DAMAGE) * eventDamage - eventDamage)