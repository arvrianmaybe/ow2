#!mainFile "../main.opy"

# rule "[venture/burrow.opy]: 8 seconds on burrow":
    # @Event eachPlayer
    # @Hero venture
    # @Condition eventPlayer.isUsingAbility1()
    # @Condition eventPlayer.isHoldingButton(Button.SECONDARY_FIRE)
    # @Condition eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0

    # wait(OW2_VENTURE_BORROW_DRILL_DASH_DURATION, Wait.ABORT_WHEN_FALSE)
    # eventPlayer.setAbilityCooldown(Button.SECONDARY_FIRE, OW2_VENTIRE_DRILL_DASH_COOLDOWN)