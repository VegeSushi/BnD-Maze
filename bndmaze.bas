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
    missile0y = 255

    player0x = 24
    player0y = 25

    player1x = 0
    player1y = 0

    dim level = l
    dim last_dir = f
    dim missile_dir = i
    dim shooting = s
    dim moved = m
    dim spawned = e
    dim enemy_dir = n
    dim finished = h

    shooting = 0
    moved = 0
    spawned = 0

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
    if switchreset then level = 0 : gosub __Load_Level : goto __Main_Loop
    goto __Main_Menu

__Main_Loop

    a = player0x
    b = player0y

    if joy0up then player0y = player0y - 1 : last_dir = 1 : moved = 1
    if joy0down then player0y = player0y + 1 : last_dir = 3 : moved = 1
    if joy0left then player0x = player0x - 1 : last_dir = 4 : moved = 1
    if joy0right then player0x = player0x + 1 : last_dir = 2 : moved = 1

    if joy0fire && moved = 1 && missile0y > 200 then missile0y = player0y : missile0x = player0x + 4 : missile_dir = last_dir : shooting = 1

    if shooting = 1 then gosub __Shooting
    if spawned = 1 then gosub __Enemy_Move

    drawscreen

    if collision(player0, playfield) then player0x = a : player0y = b

    if collision(player1, playfield) && spawned = 0 then gosub __Spawn_Enemy
    if !collision(player1, playfield) && spawned = 0 then spawned = 1

    if collision(player1, playfield) && spawned = 1 then gosub __Enemy_Back

    if collision(missile0, playfield) then missile0y = 255 : shooting = 0
    if collision(player0, player1) then goto __Main_Menu
    if collision(player1, missile0) then finished = 1

    if finished = 1 then gosub __Next_Level

    goto __Main_Loop

__Next_Level
    finished = 0
    level = level + 1
    gosub __Load_Level
    return

__Enemy_Back
    if enemy_dir = 1 then player1y = player1y + 2
    if enemy_dir = 3 then player1y = player1y - 2
    if enemy_dir = 2 then player1x = player1x - 2
    if enemy_dir = 4 then player1x = player1x + 2
    enemy_dir = (rand&3) + 1
    return

__Enemy_Move
    if (rand&31) = 0 then enemy_dir = (rand&3) + 1

    if enemy_dir = 1 then player1y = player1y - 2
    if enemy_dir = 3 then player1y = player1y + 2
    if enemy_dir = 2 then player1x = player1x + 2
    if enemy_dir = 4 then player1x = player1x - 2
    return

__Spawn_Enemy
    enemy_dir = (rand&3) + 1
    player1x = (rand&127) + 16
    player1y = (rand&127) + (rand&31) + 32
    return

__Shooting
    if missile_dir = 1 then missile0y = missile0y - 4
    if missile_dir = 3 then missile0y = missile0y + 4
    if missile_dir = 2 then missile0x = missile0x + 2
    if missile_dir = 4 then missile0x = missile0x - 2
    return

__Load_Level
    spawned = 0
    missile0y = 255
    shooting = 0

    gosub __Spawn_Enemy

    if level = 0 then gosub __Level_One
    if level = 1 then gosub __Level_Two
    if level = 2 then gosub __Level_Three
    if level = 3 then gosub __Level_Four
    if level = 4 then gosub __Level_Five
    if level = 5 then gosub __Level_Six
    if level = 6 then gosub __Level_Seven
    if level = 7 then gosub __Level_Eight
    if level = 8 then gosub __Level_Nine
    if level = 9 then gosub __Level_Ten

    if level > 9 then level = 0 : gosub __Level_One

    return

__Level_One
    player0x = 24
    player0y = 24

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

__Level_Two
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX..XXXX....XXXX....XXXX....XXXX
    XX..XXXX....XXXX....XXXX....XXXX
    XX............................XX
    XX............................XX
    XX..XXXX....XXXX....XXXX....XXXX
    XX..XXXX....XXXX....XXXX....XXXX
    XX............................XX
    XX............................XX
    XX..XXXX....XXXX....XXXX....XXXX
    XX..XXXX....XXXX....XXXX....XXXX
    XX............................XX
    XX............................XX
    XX..XXXX....XXXX....XXXX....XXXX
    XX..XXXX....XXXX....XXXX....XXXX
    XX............................XX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Three
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX............................XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX............................XX
    XX............................XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX............................XX
    XX............................XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX............................XX
    XX............................XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Four
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX......XX......XX......XX....XX
    XX......XX......XX......XX....XX
    XX..XX..XX..XX..XX..XX..XX..XXXX
    XX..XX..XX..XX..XX..XX..XX..XXXX
    XX..XX......XX......XX......XXXX
    XX..XX......XX......XX......XXXX
    XX..XXXXXX..XXXXXX..XXXXXX..XXXX
    XX..XXXXXX..XXXXXX..XXXXXX..XXXX
    XX..XX......XX......XX......XXXX
    XX..XX......XX......XX......XXXX
    XX..XX..XX..XX..XX..XX..XX..XXXX
    XX..XX..XX..XX..XX..XX..XX..XXXX
    XX......XX......XX......XX....XX
    XX......XX......XX......XX....XX
    XX..XXXXXX..XXXXXX..XXXXXX..XXXX
    XX..XXXXXX..XXXXXX..XXXXXX..XXXX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Five
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX............................XX
    XX..XXXXXXXXXX....XXXXXXXXXX..XX
    XX..XXXXXXXXXX....XXXXXXXXXX..XX
    XX..XX....................XX..XX
    XX..XX....................XX..XX
    XX..XX....XXXXXXXXXXXX....XX..XX
    XX........XXXXXXXXXXXX........XX
    XX........XXXXXXXXXXXX........XX
    XX..XX....XXXXXXXXXXXX....XX..XX
    XX..XX....................XX..XX
    XX..XX....................XX..XX
    XX..XXXXXXXXXX....XXXXXXXXXX..XX
    XX..XXXXXXXXXX....XXXXXXXXXX..XX
    XX............................XX
    XX............................XX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Six
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXX..XX
    XX..XX........................XX
    XX..XX..XXXXXXXXXXXXXXXXXXXX..XX
    XX..XX..XXXXXXXXXXXXXXXXXXXX..XX
    XX..XX..XX....................XX
    XX..XX..XX..XXXXXXXXXXXXXX....XX
    XX..XX..XX..XXXXXXXXXXXXXX....XX
    XX..XX..XX..XX..........XX....XX
    XX..XX..XX..XX..XXXXXX..XX....XX
    XX..XX..XX..XX..XXXXXX..XX....XX
    XX..XX..XX..XX..........XX....XX
    XX..XX..XX..XXXXXXXXXXXXXX....XX
    XX..XX..XX....................XX
    XX..XX..XXXXXXXXXXXXXXXXXXXX..XX
    XX..XX........................XX
    XX..XXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Seven
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX....XX....XX....XX....XX....XX
    XX....XX....XX....XX....XX....XX
    XX..XX....XX....XX....XX....XXXX
    XX..XX....XX....XX....XX....XXXX
    XX....XX....XX....XX....XX....XX
    XX....XX....XX....XX....XX....XX
    XX..XX....XX....XX....XX....XXXX
    XX..XX....XX....XX....XX....XXXX
    XX....XX....XX....XX....XX....XX
    XX....XX....XX....XX....XX....XX
    XX..XX....XX....XX....XX....XXXX
    XX..XX....XX....XX....XX....XXXX
    XX....XX....XX....XX....XX....XX
    XX....XX....XX....XX....XX....XX
    XX..XX....XX....XX....XX....XXXX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Eight
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX..XXXXXX............XXXXXX..XX
    XX..XXXXXX............XXXXXX..XX
    XX......XXXXXX....XXXXXX......XX
    XX......XXXXXX....XXXXXX......XX
    XX..........XXXXXXXX..........XX
    XX..........XXXXXXXX..........XX
    XX............XXXX............XX
    XX............XXXX............XX
    XX..........XXXXXXXX..........XX
    XX..........XXXXXXXX..........XX
    XX......XXXXXX....XXXXXX......XX
    XX......XXXXXX....XXXXXX......XX
    XX..XXXXXX............XXXXXX..XX
    XX..XXXXXX............XXXXXX..XX
    XX............................XX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Nine
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX............................XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX..X..X..X..X....X..X..X..X..XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX............................XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX..X..X..X..X....X..X..X..X..XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX............................XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX..X..X..X..X....X..X..X..X..XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX............................XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX..X..X..X..X....X..X..X..X..XX
    XX..XXXX..XXXX....XXXX..XXXX..XX
    XX............................XX
    XX............................XX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return

__Level_Ten
    player0x = 24
    player0y = 24

    playfield:
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    XX..........................XXXX
    XX..XXXXXXXXXXXXXXXXXXXXXX..XXXX
    XX..XXXXXXXXXXXXXXXXXXXXXX..XXXX
    XX..XX..................XX..XXXX
    XX..XX..XXXXXXXXXXXXXX..XX..XXXX
    XX..XX..XXXXXXXXXXXXXX..XX..XXXX
    XX..XX..XX..........XX..XX..XXXX
    XX..XX..XX..XXXXXX..XX..XX..XXXX
    XX..XX..XX..XXXXXX..XX..XX..XXXX
    XX..XX..XX..XX..XX..XX..XX..XXXX
    XX..XX..XX..XX..XX..XX..XX..XXXX
    XX..XX..XX......XX..XX..XX..XXXX
    XX..XX..XXXXXXXXXX..XX..XX..XXXX
    XX..XX..............XX..XX..XXXX
    XX..XXXXXXXXXXXXXXXXXX..XX..XXXX
    XX......................XX..XXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXX..XXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXX..XXXX
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
    return
