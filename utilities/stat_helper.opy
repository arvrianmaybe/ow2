#!mainFile "../main.opy"

playervar stat_helper_pvar
#!defineMember _base_damage_scalar stat_helper_pvar[0]
#!defineMember _base_healing_scalar stat_helper_pvar[1]
#!defineMember _base_movement_scalar stat_helper_pvar[2]
#!defineMember _base_defense_scalar stat_helper_pvar[3]

#!define setBaseDamage(player, scalar) \
    player._base_damage_scalar = scalar \
    player.setDamageDealt(percent(player._base_damage_scalar))

#!define setBaseDefense(player, scalar) \
    player._base_defense_scalar = scalar \
    player.setDamageReceived(percent(player._base_defense_scalar))

#!define setBaseMovement(player, scalar) \
    player._base_movement_scalar = scalar \
    player.setMoveSpeed(percent(player._base_movement_scalar))

rule "[utilities/stat_helper.opy]: melee damage":
    @Event playerDealtDamage
    @Condition eventAbility == Button.MELEE
    @Condition eventPlayer.getCurrentHero() not in [Hero.BRIGITTE, Hero.REINHARDT, Hero.ZENYATTA]

    heal(victim, null, eventDamage - (MELEE_DAMAGE/OW2_MELEE_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar))
    damage(victim, attacker, ((MELEE_DAMAGE/OW2_MELEE_DAMAGE)*(eventDamage/eventPlayer._base_damage_scalar) - eventDamage)/eventPlayer._base_damage_scalar)
