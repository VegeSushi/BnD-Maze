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

    player0x = 24
    player0y = 25

    dim level = 0

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

    player2:
    %00000000
    %00000000
    %00000110
    %00000110
    %01111110
    %11111110
    %01111110
    %01100110
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

    player2color:
    $12
    $12
    $12
    $12
    $12
    $12
    $12
    $12
end

__Main_Menu
    drawscreen

    if switchreset then gosub __Load_Level : goto __Main_Loop

    goto __Main_Menu

__Main_Loop

    a = player0x
    b = player0y
    c = player1x
    d = player1y

    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 1
    if joy0left then player0x = player0x - 1
    if joy0right then player0x = player0x + 1

    drawscreen

    if collision(player0, playfield) then player0x = a : player0y = b

    goto __Main_Loop

__Load_Level
    if level = 0 then goto __Level_One
    return

__Level_One

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
    return
