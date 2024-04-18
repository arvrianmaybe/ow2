#!mainFile "../main.opy"

rule "[venture/dash.opy] shorter dash":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == false #so drill dash also just randomly get canceled.
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    wait(0.25)
    eventPlayer.cancelPrimaryAction()
