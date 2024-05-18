#!mainFile "../main.opy"

rule "[venture/dash.opy] shorter dash":
    @Event eachPlayer
    @Hero venture
    #sadly venture isnt out yet completly and also cause the program wont recognize venture
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    wait(0.25)
    eventPlayer.cancelPrimaryAction()
    #eventPlayer.setStatusEffect(null, Status.STUNNED, 0.1) # useless