local term = peripheral.find("monitor")

local function centerText(text)
    local x,y = term.getSize()
    local x1,y1 = term.getCursorPos()
    term.setCursorPos((math.floor(x/2) - (math.floor(#text/2))), y1)
    term.write(text)
  end
centerText("teste")