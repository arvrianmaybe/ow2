#!mainFile "../main.opy"

rule "[exterminate.opy]":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    @Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.isAlive()
    @Condition not isCCd(eventPlayer)

    eventPlayer.setDamageDealt(ORISA_EXTERMINATE_DAMAGE)
    eventPlayer.setMoveSpeed(ORISA_EXTERMINATE_SPEED)
    eventPlayer.setDamageReceived(ORISA_EXTERMINATE_DEFENSE)
    #wait(ORISA_EXTERMINATE_DURATION)#, Wait.ABORT_WHEN_FALSE)
    #wait()
    #eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0) # reset exterminate cd
    wait(ORISA_EXTERMINATE_DURATION, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setDamageDealt(200)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, ORISA_EXTERMINATE_COOLDOWN)

rule "[exterminate.opy] cancel exterminate":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2)
    #@Condition eventPlayer.getAbilityCooldown(Button.ABILITY_2) <= 0
    @Condition eventPlayer.isAlive()
    @Condition not isCCd(eventPlayer)

    eventPlayer.setDamageDealt(ORISA_EXTERMINATE_DAMAGE)
    eventPlayer.setDamageDealt(100)
    eventPlayer.setMoveSpeed(100)
    eventPlayer.setDamageReceived(100)
    eventPlayer.setAbilityCooldown(Button.ABILITY_2, ORISA_EXTERMINATE_COOLDOWN)
