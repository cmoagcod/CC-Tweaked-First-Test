-- configurations
print("Modem Position: ")
ModemPos = tostring(read())

print("Controller Protocol: ")
Protocol = read()

print("Controller ID: ")
Id = tonumber(read())

function Quarry(size)
    size = tonumber(size)
    shell.run("excavate ",size)
end

function Fuel(parameter)
    if parameter == "plein" then
        turtle.refuel()
    elseif parameter == "niveau" then
        print(turtle.getFuelLevel())
        rednet.send(Id, turtle.getFuelLevel(), "quarry")
    end
end

function MineBouge(direction)
    if direction == "bougeMineAvant" then
        if turtle.detect then
            turtle.dig()
        end
        turtle.forward()
    elseif direction == "bougeMineBas" then
        if turtle.detectDown then
            turtle.digDown()
        end
        turtle.down()
    elseif direction == "bougeMineHaut" then
        if turtle.detectUp then
            turtle.digUp()
        end
        turtle.up()
    elseif direction == "bougeMineDroite" then
        turtle.turnRight()
        if turtle.detect then
            turtle.dig()
        end
        turtle.forward()
    elseif direction == "bougeMineGauche" then
        turtle.turnLeft()
        if turtle.detect then
            turtle.dig()
        end
        turtle.forward()
    elseif direction == "bougeMineArrière" then
        turtle.turnLeft()
        turtle.turnLeft()
        if turtle.detect then
            turtle.dig()
        end
        turtle.forward()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function Tourne(direction)
    if direction == "tourneGauche" then
        turtle.turnLeft()
    elseif direction == "tourneDroite" then
        turtle.turnRight()
    end
end

function Bouge(direction)
    if direction == "avant" then
        turtle.forward()
    elseif direction == "bas" then
        turtle.down()
    elseif direction == "haut" then
        turtle.up()
    elseif direction == "droite" then
        turtle.turnRight()
        turtle.forward()
    elseif direction == "gauche" then
        turtle.turnLeft()
        turtle.forward()
    elseif direction == "arrière" then
        turtle.back()
    end
end

function Mine(direction)
    if direction == "mineAvant" then
        if turtle.detect then
            turtle.dig()
        end
    elseif direction == "mineBas" then
        if turtle.detectDown then
            turtle.digDown()
        end
    elseif direction == "mineHaut" then
        if turtle.detectUp then
            turtle.digUp()
        end
    elseif direction == "mineDroite" then
        turtle.turnRight()
        if turtle.detect then
            turtle.dig()
        end
        turtle.turnLeft()
    elseif direction == "mineGauche" then
        turtle.turnLeft()
        if turtle.detect then
            turtle.dig()
        end
        turtle.turnRight()
    elseif direction == "mineArrière" then
        turtle.turnLeft()
        turtle.turnLeft()
        if turtle.detect then
            turtle.dig()
        end
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function MineBougeH3(direction)
    if direction == "mineBougeH3Avant" then
        if turtle.detect then
            turtle.dig()
        end
        turtle.forward()
        if turtle.detectUp then
            turtle.digUp()
        end
        if turtle.detectDown then
            turtle.digDown()
        end
    end
end


-- main
local exitCode = 0

rednet.open(ModemPos)

while exitCode == 0 do
    local id, message = rednet.receive(Protocol)
    print("Reçu de #",id," le message suivant: ",message)
    if id == Id then

        if message == "exit" then
            exitCode = 1
        end

        if message == "avant" or message == "arrière" or message == "gauche" or message == "droite" or message == "haut" or message == "bas" then
            Bouge(message)
        end

        if message == "bougeMineAvant" or message == "bougeMineArrière" or message == "bougeMineGauche" or message == "bougeMineDroite" or message == "bougeMineHaut" or message == "bougeMineBas" then
            MineBouge(message)
        end

        if message == "tourneDroite" or message == "tourneGauche" then
            Tourne(message)
        end

        if message == "mineAvant" or message == "mineArrière" or message == "mineGauche" or message == "mineDroite" or message == "mineHaut" or message == "mineBas" then
            Mine(message)
        end

        if message == "mineBougeH3Avant" then
            MineBougeH3(message)
        end

        if message == "plein" or message == "niveau" then
            Fuel(message)
        end

        if message == "position" then
            rednet.send(Id,gps.locate(),"quarry")
        end

        if message == "quarry" then
            Quarry(16)
        end

    end
end