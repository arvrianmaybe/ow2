#!mainFile "../main.opy"


rule "[ana/sleep.opy]: Sleep tanks for longer duration":
    @Event playerDealtDamage
    @Hero ana
    @Condition eventAbility == Button.ABILITY_1
    # @Condition victim.getCurrentHero() in getTankHeroes()
    
    victim.setStatusEffect(null, Status.HACKED, 0.5)
    waitUntil(victim.hasStatusEffect(Status.ASLEEP), Math.INFINITY)
    while (victim.hasStatusEffect(Status.ASLEEP)):
        wait(0.5)
        victim.clearStatusEffect(Status.ASLEEP)

    wait()
    victim.setStatusEffect(
        attacker, 
        Status.ASLEEP, 
        (5))
    victim.clearStatusEffect(Status.HACKED)