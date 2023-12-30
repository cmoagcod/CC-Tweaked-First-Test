print("Modem Position:")
ModemPos = tostring(read())


term.clear()
print("Remote Controller v0.1 par ato")
print("---")
print("quarry: lance les quarry")
print("exit: sort les turtle du mode réseau")
print("stop: stop le programme")
print("---")


rednet.open(ModemPos)

while true do
    print("Commande: ")
    local cmd = tostring(read())
    if cmd == "stop" then
        return
    end
    rednet.broadcast(cmd,"quarry")
end