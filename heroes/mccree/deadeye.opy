#!mainFile "../main.opy"

rule "[mccree/deadeye.opy]: remove dmg reduction and dmg":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.isUsingUltimate()

    eventPlayer.setDamageDealt(percent(MCCREE_DEADEYE_DAMAGE/OW2_MCCREE_DEADEYE_DAMAGE))
    eventPlayer.setDamageReceived(percent(100/(100-OW2_MCCREE_DEADEYE_DAMAGE_REDUCTION)))
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setDamageDealt(percent(eventPlayer._base_damage_scalar))
    eventPlayer.setDamageReceived(100)
