#!mainFile "../main.opy"

playervar hack_timer

#!define isHacked(player) (player.hack_timer > 0)

rule "[sombra/hack.opy]: Apply OW1 hack on top of OW2 hack":
    @Event eachPlayer
    @Condition eventPlayer.hasStatusEffect(Status.HACKED)

    eventPlayer.setStatusEffect(eventPlayer.enemy_sombra_player, Status.HACKED, SOMBRA_HACK_ENEMY_DURATION)
    eventPlayer.hack_timer = SOMBRA_HACK_ENEMY_DURATION
    chase(eventPlayer.hack_timer, 0, rate=1, ChaseReeval.NONE)