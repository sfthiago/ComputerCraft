print("Hello World!")

term = peripheral.find("monitor")
local function centerText(text)
    x,y = term.getSize()
    x1,y1 = term.getCursorPos()
    term.setCursorPos((math.floor(x/2) - (math.floor(#text/2))), y1)
    term.write(text)
  end