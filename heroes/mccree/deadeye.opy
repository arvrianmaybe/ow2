#!mainFile "../main.opy"

rule "[mccree/deadeye.opy]: Remove damage reduction during deadeye":
    @Event eachPlayer
    @Hero mccree
    @Condition eventPlayer.isUsingUltimate()
    
    eventPlayer.setDamageDealt(MCCREE_DEADEYE_DAMAGE)
    waitUntil(not eventPlayer.isUsingUltimate(), Math.INFINITY)
    eventPlayer.setDamageDealt(BASE_DAMAGE)