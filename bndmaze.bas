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

    missile0height = 8
    missile1height = 8

    missile0y = 255
    missile1y = 255

    dim level = e
    dim last_dir = f
    dim missile_dir = g
    dim missilet_dir = h
    dim shooting = s
    dim shootingt = t
    dim moved = m
    dim loaded = l
    dim lastt_dir = o
    dim movedt = n

    bkcolors:
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
    $C4
end

    pfcolors:
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
    $04
    $02
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

    if joy0up then player0y = player0y - 1 : last_dir = 1 : moved = 1
    if joy0down then player0y = player0y + 1 : last_dir = 3 : moved = 1
    if joy0left then player0x = player0x - 1 : last_dir = 4 : moved = 1
    if joy0right then player0x = player0x + 1 : last_dir = 2 : moved = 1
    if joy1up then player1y = player1y - 1 : lastt_dir = 1 : movedt = 1
    if joy1down then player1y = player1y + 1 : lastt_dir = 3 : movedt = 1
    if joy1left then player1x = player1x - 1 : lastt_dir = 4 : movedt = 1
    if joy1right then player1x = player1x + 1 : lastt_dir = 2 : movedt = 1

    if joy0fire && moved = 1 && missile0y > 200 then missile0y = player0y : missile0x = player0x + 4 : missile_dir = last_dir : shooting = 1
    if joy1fire && movedt = 1 && missile1y > 200 then missile1y = player1y : missile1x = player1x + 4 : missilet_dir = lastt_dir : shootingt = 1

    if shooting = 1 then gosub __Shooting
    if shootingt = 1 then gosub __Shootingt

    drawscreen

    if collision(player0, playfield) then player0x = a : player0y = b
    if collision(player1, playfield) then player1x = c : player1y = d
    if collision(player0, missile1) then score = score + 10
    if collision(player1, missile0) then score = score - 10
    if collision(missile0, playfield) then missile0y = 255 : shooting = 0
    if collision(missile1, playfield) then missile1y = 255 : shootingt = 0

    goto __Main_Loop

__Shooting
    if missile_dir = 1 then missile0y = missile0y - 4
    if missile_dir = 3 then missile0y = missile0y + 4
    if missile_dir = 2 then missile0x = missile0x + 2
    if missile_dir = 4 then missile0x = missile0x - 2
    return

__Shootingt
    if missilet_dir = 1 then missile1y = missile1y - 4
    if missilet_dir = 3 then missile1y = missile1y + 4
    if missilet_dir = 2 then missile1x = missile1x + 2
    if missilet_dir = 4 then missile1x = missile1x - 2
    return

__Load_Level
    if level = 0 then goto __Level_One
    return

__Level_One

    player0x = 24
    player0y = 25

    player1x = 128
    player1y = 155

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
