#!mainFile "../main.opy"

rule "[utilities/anticrash.opy] anti-crash":
    @Condition getServerLoad() > 230
    
    #thanks for rooky for the code, workshop.codes/KHYA7


    smallMessage(getAllPlayers(), "Anti-Crash Enabled.")
    setSlowMotion(10)
    waitUntil(getServerLoad() < 175, 99999)
    smallMessage(getAllPlayers(), "Anti-Crash Disabled.")
    setSlowMotion(100)