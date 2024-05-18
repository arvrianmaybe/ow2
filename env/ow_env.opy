#!mainFile "../main.opy"

# Environment Variables
#!define GAMEMODE_VERSION "Balanced Edition"
#!define GAMEMODE_NAME "Remastered Overwatch"
#!define GAMEMODE_DESCRIPTION (GAMEMODE_NAME + " " + GAMEMODE_VERSION + "\n" + \
                               "\n" + \
                               "Reimagined Overwatch 2 (FYTZG)" + "\n" + \
                               "old version of this gamemode." + "\n" + \
                               "\n" + \
                               "Main build: " + GAMEMODE_CODE + "\n" + \
                               "Staging build: " + STAGING_CODE + "\n" + \
                               "\n" + \
                               "Codebase Contributors:" + "\n" + \
                               "viper" + "\n" + \
                               "pepperminthe_" + "\n" + \
                               "highrezolution42#0927" + "\n" + \
                               "\n" + \
                               "workshop.codes/remastered" + "\n" + \
                               "\n" + \
                               "Discord:" + "\n" + \
                               DISCORD_SHORT_LINK + "\n" + \
                               DISCORD_LONG_LINK + "\n" + \
                               "\n" + \
                               "Source code:" + "\n" + \
                               "https://shorter.me/Q4Se9")
#!define GAMEMODE_CODE "WS8C5"
#!define STAGING_CODE "KR56M"
#!define DISCORD_SHORT_LINK "dsc.gg/runece"
#!define DISCORD_LONG_LINK "discord.gg/vb5r2gfNTQ"

rule "Copyright (c) 2024 Remastered Overwatch. See https://github.com/arvrianmaybe/ow2 for license to use this code.":
    @Disabled
    # this code has been forked by overwatch 1 emulator, please also check theres https://gitlab.com/MaxwellJung/ow1_emulator/-/tree/staging?ref_type=heads
    disableInspector()
