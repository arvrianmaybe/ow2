#!mainFile "main.opy"

playervar ult_charge_pvar
#Hey Guys Is Me SPAMTON G SPAMTON! Are You Looking For [KROMER]? 
#Well If So Then Join My [KROMER] Gang To Stop That
#[Queen Bee] And [CLOWN AROUND TOWN But We Cant Stop Them All By Ourselfs! So Use [ABILITY]

#!defineMember _missing_ult_points ult_charge_pvar[0]
#!defineMember _ult_cost ult_charge_pvar[1]
#!defineMember _new_ult_percent ult_charge_pvar[2]

#!define getUltPoints(player)\
    (percentOf(player.getUltCharge(), player._ult_cost))

#!define setUltCost(cost)\
    (eventPlayer._ult_cost = cost)

#!define resetUltCharge()\
    eventPlayer._missing_ult_points = 0\
    eventPlayer._ult_cost = 0\
    waitUntil(eventPlayer.getUltCharge() > 0, 1)\
    eventPlayer.setUltCharge(0)