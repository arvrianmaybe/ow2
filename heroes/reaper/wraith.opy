rule "[reaper/wraith.opy]: fly":
    @Event eachPlayer
    @Hero reaper
    @Condition eventPlayer.isUsingAbility1()
    @Condition eventPlayer.isHoldingButton(Button.JUMP)

    eventPlayer.applyImpulse(Vector.UP, 5, Relativity.TO_PLAYER, Impulse.CANCEL_CONTRARY_MOTION)
    wait()
    if RULE_CONDITION:
        goto RULE_START