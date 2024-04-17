#!mainFile "../main.opy"

rule "[barrage.opy] shorter barrage":
    @Event eachPlayer
    @Hero pharah
    @Condition eventPlayer.isUsingUltimate()

    wait(PHARAH_ULT_DURATION)
    #eventPlayer.setStatusEffect(null, Status.STUNNED, 0.1)
    eventPlayer.cancelPrimaryAction()