#!mainFile "../main.opy"

playervar double_abilitys_one 


rule "[ashe/couch_gun.opy] double couch gun":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.isUsingAbility1() == true
    @Condition eventPlayer.double_abilitys_one <= 1
    
    eventPlayer.setDamageDealt(150)
    wait(0.18)
    eventPlayer.setDamageDealt(100)
    eventPlayer.double_abilitys_one = eventPlayer.double_abilitys_one + 1


rule "[ashe/couch_gun.opy] double couch restart":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.double_abilitys_one >= 2
    
    wait(0.5)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 20)
    wait(20)
    eventPlayer.double_abilitys_one = 0


rule "[ashe/couch_gun.opy] double couch reset cooldown":
    @Event eachPlayer
    @Hero ashe
    @Condition eventPlayer.double_abilitys_one == 1
    
    wait(0.4)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)