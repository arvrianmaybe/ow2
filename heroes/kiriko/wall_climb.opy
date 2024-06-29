#!mainFile "../../main.opy"

rule "[kiriko/wall_climb.opy] remove wall climnb passive":
    @Event eachPlayer
    @Hero kiriko
    @Condition eventPlayer.isOnWall()

    eventPlayer.cancelPrimaryAction()
