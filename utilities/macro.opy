#!mainFile "main.opy"

#!define heroID(h) (getAllHeroes().index(h))

#!define isHero(player, hero) ((player.getCurrentHero() == hero) or (player.getHeroOfDuplication() == hero))

#!define percent(p) (100*p)

#!define roundedPercent(p) (round(percent(p)))


#!define percentOf(p, n) ((p)/100*(n))

#!define toRadians(deg) ((Math.PI/180)*deg)

#!define getForwardDirection(player) (worldVector(Vector.FORWARD, player, Transform.ROTATION))

#!define rotateRelativeToYAxis(v, angle_in_degrees) (vect((v.x*cosDeg(angle_in_degrees) + v.z*sinDeg(angle_in_degrees)), (v.y), (-v.x*sinDeg(angle_in_degrees) + v.z*cosDeg(angle_in_degrees))))

#!define cancelMomentum(player) (player.applyImpulse(player.getVelocity(), -player.getSpeed(), Relativity.TO_WORLD, Impulse.INCORPORATE_CONTRARY_MOTION))

#!define centerMass(player) ((player.getPosition() + player.getEyePosition())/2)


#!define isCCd(player) (player.hasStatusEffect(Status.STUNNED) \
                     or player.hasStatusEffect(Status.HACKED) \
                     or player.hasStatusEffect(Status.ASLEEP) \
                     or player.hasStatusEffect(Status.FROZEN) \
                     or player.hasStatusEffect(Status.KNOCKED_DOWN))