#!mainFile "main.opy"

playervar stat_helper_pvar
#!defineMember _base_damage_scalar stat_helper_pvar[0]

#!define setBaseDamage(player, scalar) \
    player._base_damage_scalar = scalar \
    player.setDamageDealt(percent(player._base_damage_scalar))


rule "[stat_helper.opy]: melee damage":
    @Event playerDealtDamage
    @Condition eventAbility == Button.MELEE
    @Condition eventPlayer.getCurrentHero() not in [Hero.BRIGITTE, Hero.REINHARDT]

    heal(victim, null, eventDamage - (MELEE_DAMAGE/MELEE_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar))
    damage(victim, attacker, ((MELEE_DAMAGE/MELEE_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar) - eventDamage)/eventPlayer._base_damage_scalar)