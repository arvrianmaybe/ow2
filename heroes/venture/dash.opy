#!mainFile "../main.opy"

/*
rule "[venture/dash.opy] shorter dash":
    @Event eachPlayer
    @Hero venture
    @Condition eventPlayer.isUsingAbility1() == false #so drill dash also just randomly get canceled.
    @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE) == true
    
    wait(VENTURE_DRILL_DASH_DURATION)
    eventPlayer.cancelPrimaryAction()
*/
