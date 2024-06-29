#!mainFile "../../main.opy"

rule "[hanzo/init_hanzo.opy] init hanzo":
    @Event eachPlayer
    @Hero hanzo
    
    defaultHero()
    newHero(HANZO_HEALTH, 0, 0)
    removePassiveHealing()
    setUltCost(HANZO_ULT_COST)

rule "[hero_switch.opy]: Detect switch to hanzo":
    @Event eachPlayer
    @Hero hanzo
    @Condition eventPlayer._hero_switched
           
    eventPlayer.call_init = true    

rule "[hanzo.opy]: Deal more primary fire damage":
    @Event playerDealtDamage
    @Hero hanzo
    @Condition eventAbility in [Button.PRIMARY_FIRE, Button.ABILITY_1]
    
    damage(victim, attacker, eventDamage*(HANZO_ARROW_DAMAGE/OW2_HANZO_ARROW_DAMAGE)-eventDamage)
