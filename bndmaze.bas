    set kernel DPC+

    goto start bank2

    bank 2
start
    DF0FRACINC = 31
    DF1FRACINC = 31
    DF2FRACINC = 31
    DF3FRACINC = 31
    DF4FRACINC = 31
    DF6FRACINC = 31

    player0x = 25
    player0y = 55
    player1x = 125
    player1y = 55

    bkcolors:
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
end

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX..XX....................XX..XX
    XX..XX....................XX..XX
    XX..XX..XXXXXX....XXXXXX..XX..XX
    XX..XX..XXXXXX....XXXXXX..XX..XX
    XX......XX............XX......XX
    XX......XX............XX......XX
    XXXXXXXXXX..XX....XX..XXXXXXXXXX
    XXXXXXXXXX..XX....XX..XXXXXXXXXX
    XX......XX............XX......XX
    XX......XX............XX......XX
    XX..XX..XXXXXX....XXXXXX..XX..XX
    XX..XX..XXXXXX....XXXXXX..XX..XX
    XX..XX....................XX..XX
    XX..XX....................XX..XX
    XX..XXXXXXXXXX....XXXXXXXXXX..XX
    XX..XXXXXXXXXX....XXXXXXXXXX..XX
    XX......XX............XX......XX
    XX......XX............XX......XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

    pfcolors:
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
    $C4
    $C8
end

    player0:
    %00100100
    %01111110
    %01100110
    %00111100
    %00111100
    %01111110
    %00111100
    %00100100
end

    player1:
    %00010000
    %00111000
    %01111100
    %00111110
    %00111100
    %01111110
    %00111100
    %00100100
end

    player0color:
    $9A
    $9A
    $9A
    $9A
    $9A
    $9A
    $9A
    $9A
end

    player1color:
    $00
    $00
    $00
    $00
    $00
    $00
    $00
    $00
end

__Main_Loop

    a = player0x
    b = player0y
    c = player1x
    d = player1y

    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 1
    if joy0left then player0x = player0x - 1
    if joy0right then player0x = player0x + 1

    if joy1up then player1y = player1y - 1
    if joy1down then player1y = player1y + 1
    if joy1left then player1x = player1x - 1
    if joy1right then player1x = player1x + 1

    drawscreen

    if collision(player0, playfield) then player0x = a : player0y = b
    if collision(player1, playfield) then player1x = c : player1y = d

    goto __Main_Loop
