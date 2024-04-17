#!mainFile "../main.opy"

rule "[sprint.opy] soldier sprint indicaator":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isStanding() == true

    eventPlayer.setAbility1Enabled(false)

rule "[sprint.opy] soldier sprint indicator false":
    @Event eachPlayer
    @Hero soldier
    @Condition eventPlayer.isStanding() == false

    eventPlayer.setAbility1Enabled(true)