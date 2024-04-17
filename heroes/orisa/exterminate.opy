#!mainFile "../main.opy"

playervar exterminate_enabled

rule "[exterminate.opy]":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.exterminate_enabled == 0
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.isAlive()
    @Condition not isCCd(eventPlayer)

    eventPlayer.exterminate_enabled = 1
    eventPlayer.setDamageDealt(ORISA_EXTERMINATE_DAMAGE)
    #wait(ORISA_EXTERMINATE_DURATION)#, Wait.ABORT_WHEN_FALSE)
    #wait()
    #eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0) # reset exterminate cd
    wait(ORISA_EXTERMINATE_DURATION, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setDamageDealt(BASE_DAMAGE)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, ORISA_EXTERMINATE_COOLDOWN)

rule "[exterminate.opy] cancel exterminate":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.exterminate_enabled == 1
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    #@Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.isAlive()
    @Condition not isCCd(eventPlayer)

    eventPlayer.exterminate_enabled = 0
    eventPlayer.setDamageDealt(ORISA_EXTERMINATE_DAMAGE)
    eventPlayer.setDamageDealt(BASE_DAMAGE)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, ORISA_EXTERMINATE_COOLDOWN)