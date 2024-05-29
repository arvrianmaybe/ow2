#!mainFile "../main.opy"
#!include "utilities/custom_hp.opy"

subroutine cancelDuplication

playervar remember_echo_pvar

#!define ECHO_DUP_VOICELINE_DRUATION 1.2

rule "[echo/duplicate.opy]: accurate dup":
    @Event eachPlayer
    #@Hero echo
    @Condition eventPlayer.isDuplicatingAHero()

    eventPlayer.remember_echo_pvar = true # Remember Echo Dup
    wait(ECHO_DUP_VOICELINE_DRUATION)
    eventPlayer.startForcingHero(eventPlayer.getHeroOfDuplication())
    eventPlayer.preloadHero(eventPlayer.getHeroOfDuplication())


rule "[echo/duplicate.opy]: Correct duplicate ultimate charge rate":
    @Event eachPlayer
    @Condition eventPlayer.remember_echo_pvar
    @Condition eventPlayer.getUltCharge() == 0

    wait()
    eventPlayer.setUltCharge((percent(1 - (OW2_ECHO_DUPLICATE_ULT_CHARGE_MULTIPLIER/ECHO_DUPLICATE_ULT_CHARGE_MULTIPLIER)))/OW2_ECHO_DUPLICATE_ULT_CHARGE_MULTIPLIER)

rule "[echo/duplcation.opy]: Reduce ultimate duration":
    @Event eachPlayer
    @Condition eventPlayer.remember_echo_pvar
     
    wait(ECHO_DUPLICATE_DURATION, Wait.ABORT_WHEN_FALSE)
    cancelDuplication()
    
rule "[echo/duplcation.opy]: death on dup":
    @Event eachPlayer
    @Condition eventPlayer.getHealth() <= 1
    @Condition not eventPlayer.call_init
    @Condition eventPlayer.remember_echo_pvar
 
    eventPlayer.resurrect()
    cancelDuplication()

def cancelDuplication():
    @Name "[echo/duplcation.opy]: cancelDuplication()"

    #kill(eventPlayer,eventPlayer)
    eventPlayer.startForcingHero(Hero.ECHO)
    eventPlayer.preloadHero(Hero.ECHO)
    eventPlayer.stopForcingCurrentHero()
    eventPlayer.remember_echo_pvar = false # Stop echo dup
