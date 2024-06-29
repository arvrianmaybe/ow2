#!mainFile "../../main.opy"

rule "[lifeweaver/parting_gift.opy] parting gift passive":
    @Event playerDied
    @Hero lifeweaver

    createProjectile(Projectile.ORB, 
                     eventPlayer, 
                     null, 
                     null, 
                     Relativity.TO_WORLD, 
                     ModifyHealth.HEAL, 
                     (eventPlayer.getTeam()), 
                     LIFEWEAVER_PARTING_GIFT_HEAL, 
                     1, 
                     LIFEWEAVER_PARTING_GIFT_RANGE, 
                     DynamicEffect.GOOD_EXPLOSION, 
                     DynamicEffect.EXPLOSION_SOUND, 
                     0, 
                     LIFEWEAVER_PARTING_GIFT_SPEED, 
                     LIFEWEAVER_PARTING_GIFT_RANGE/LIFEWEAVER_PARTING_GIFT_SPEED, 
                     0, 
                     0, 
                     0)
