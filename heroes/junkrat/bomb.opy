#!mainFile "../../main.opy"

rule "[junkrat/bomb.opy]: Throw projectile when pressing e":
    @Event eachPlayer
    @Hero junkrat
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition not eventPlayer.isFiringPrimaryFire()
    @Condition not isCCd(eventPlayer)

    createProjectile(Projectile.ORB, 
                     eventPlayer, 
                     null, 
                     null, 
                     Relativity.TO_WORLD, 
                     ModifyHealth.DAMAGE, 
                     getOppositeTeam(eventPlayer.getTeam()), 
                     JUNKRAT_BOMB_DAMAGE, 
                     1, 
                     JUNKRAT_BOMB_RADIUS, 
                     DynamicEffect.BAD_EXPLOSION, 
                     DynamicEffect.EXPLOSION_SOUND, 
                     0, 
                     JUNKRAT_BOMB_SPEED, 
                     JUNKRAT_BOMB_RANGE/JUNKRAT_BOMB_SPEED, 
                     0, 
                     0, 
                     1)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, JUNKRAT_BOMB_COOLDOWN)
    playEffect(getAllPlayers(), DynamicEffect.EXPLOSION_SOUND, Color.YELLOW, eventPlayer, 100)
