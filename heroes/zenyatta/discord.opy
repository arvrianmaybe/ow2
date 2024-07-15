#!mainFile "../../dev_main.opy"

playervar discord_orb_damage

rule "[zenyatta/discord.opy]: Set discord orb":
    @Event eachPlayer
    @Hero zenyatta
    @Condition eventPlayer.isUsingAbility2()

    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.016) # just leave this so they dont accidentally got the wrong target
    eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())).setDamageReceived(percent(OW2_ZENYATTA_DISCORD_ORB_TAKEN))
    eventPlayer.getPlayerClosestToReticle(getOppositeTeam(eventPlayer.getTeam())).discord_orb_damage = true
    waitUntil(not eventPlayer.isUsingAbility2(), Math.INFINITY)
    if (not eventPlayer.discord_orb_damage).exclude(true):
        eventPlayer.discord_orb_damage = false

rule "[zenyatta/discord.opy]: stop discord orb if no longer using it.":
    @Event eachPlayer
    @Condition not eventPlayer.discord_orb_damage
    
    eventPlayer.setDamageReceived(100)

rule "[zenyatta/discord.opy]: stop discord orb if victim died":
    @Event playerDied
    @Condition eventPlayer.discord_orb_damage
    
    waitUntil(eventPlayer.isAlive(), Math.INFINITY)
    eventPlayer.setDamageReceived(100)