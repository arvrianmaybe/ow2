#!mainFile "../../main.opy"

rule "[ramattra/nemesis.opy]: Disable Block during nemesis":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.isUsingAbility1()

    eventPlayer.setSecondaryFireEnabled(false)


rule "[ramattra/nemesis.opy]: Enable shield when not in nemesis":
    @Event eachPlayer
    @Hero ramattra
    @Condition not (eventPlayer.isUsingAbility1())

    eventPlayer.setSecondaryFireEnabled(true)
