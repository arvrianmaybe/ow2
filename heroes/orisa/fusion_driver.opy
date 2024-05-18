#!mainFile "../main.opy"

playervar orisa_ammo
playervar orisa_ammo_hud
playervar is_orisa_reloading

subroutine resetFusionDriver
subroutine reloadFusionDriver

subroutine showOrisaAmmoHud
subroutine hideOrisaAmmoHud

#!define updateAmmo() eventPlayer.setAmmo(0, eventPlayer.orisa_ammo + 1)


rule "[orisa/ammo.opy]: Decrease ammo when shooting gun":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.is_orisa_reloading
    @Condition not eventPlayer.isMeleeing()
    @Condition eventPlayer.orisa_ammo > 0
    
    eventPlayer.orisa_ammo -= 1
    wait(1/ORISA_GUN_FIRE_RATE)
    if RULE_CONDITION:
        goto RULE_START


rule "[orisa/ammo.opy]: Reload gun after respawning":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isDead()

    waitUntil(eventPlayer.isInSpawnRoom(), Math.INFINITY)
    resetFusionDriver()


rule "[orisa/ammo.opy]: Update ammo when shooting gun":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.is_orisa_reloading
    
    updateAmmo()


rule "[orisa/ammo.opy]: Reload when out of ammo":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.orisa_ammo <= 0
    
    reloadFusionDriver()


rule "[orisa/ammo.opy]: Reload on key press":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)
    @Condition eventPlayer.orisa_ammo < ORISA_CLIP_SIZE
    
    reloadFusionDriver()


def reloadFusionDriver():
    @Name "[orisa/ammo.opy]: reloadFusionDriver()"

    if eventPlayer.orisa_ammo >= ORISA_CLIP_SIZE: return # Abort if ammo already full

    eventPlayer.setAmmo(0, 0) # Play reload animation
    eventPlayer.is_orisa_reloading = true
    waitUntil(eventPlayer.isHoldingButton(Button.MELEE), ORISA_RELOAD_TIME)
    if eventPlayer.isHoldingButton(Button.MELEE):
        eventPlayer.setAmmo(0, ORISA_CLIP_SIZE + 1) # Exit reload animation
        eventPlayer.forceButtonPress(Button.MELEE)
    else:
        resetFusionDriver()
    eventPlayer.is_orisa_reloading = false


def resetFusionDriver():
    @Name "[orisa/ammo.opy]: resetFusionDriver()"

    eventPlayer.setMaxAmmo(0, ORISA_CLIP_SIZE + 1)
    eventPlayer.orisa_ammo = ORISA_CLIP_SIZE
    updateAmmo()


def showOrisaAmmoHud():
    @Name "[orisa/ammo.opy]: showOrisaAmmoHud()"
    
    if eventPlayer.orisa_ammo_hud == null:
        createInWorldText(eventPlayer, 
                        "{0}|{1}".format(ceil(eventPlayer.orisa_ammo), ORISA_CLIP_SIZE),
                        updateEveryTick(eventPlayer.getEyePosition() + \
                        (100 * (3.3 * worldVector(Vector.RIGHT, eventPlayer, Transform.ROTATION) + \
                        ((-1.3 - 0.2) * (angleToDirection(horizontalAngleOfDirection(eventPlayer.getFacingDirection()), 
                        verticalAngleOfDirection(eventPlayer.getFacingDirection()) - 90))) + 3 * eventPlayer.getFacingDirection()))), 
                        2, 
                        Clip.NONE, 
                        WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, 
                        Color.WHITE, 
                        SpecVisibility.DEFAULT)
        eventPlayer.orisa_ammo_hud = getLastCreatedText()


def hideOrisaAmmoHud():
    @Name "[orisa/ammo.opy]: hideOrisaAmmoHud()"

    destroyInWorldText(eventPlayer.orisa_ammo_hud)
    eventPlayer.orisa_ammo_hud = null


rule "[orisa/ammo.opy]: Slow down Orisa when shooting":
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.is_orisa_reloading

    eventPlayer.setMoveSpeed(100-percent(ORISA_MOVEMENT_PENALTY))
    waitUntil(not eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.is_orisa_reloading, Math.INFINITY)
    eventPlayer.setMoveSpeed(100)

rule "[orisa/ammo.opy]: Back to normal when Orisa stop shotting": #i found an issue where if you fire in fortify it cancels back to the nerfs.
    @Event eachPlayer
    @Hero orisa
    @Condition eventPlayer.isUsingAbility1()
    @Condition eventPlayer.isHoldingButton(Button.PRIMARY_FIRE)
    @Condition not eventPlayer.is_orisa_reloading
    eventPlayer.setMoveSpeed(100-percent(ORISA_MOVEMENT_PENALTY))
    waitUntil(not eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.is_orisa_reloading, Math.INFINITY)
    eventPlayer.setMoveSpeed(percent(ORISA_FORITFY_MOVEMENT_BONUS/OW2_ORISA_FORTIFY_MOVEMENT_DECREASE))
    waitUntil(not eventPlayer.isUsingAbility1(), Math.INFINITY) # Just to be safe when player fires at last second to still gain movement speed
    eventPlayer.setMoveSpeed(100)
