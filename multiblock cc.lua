-- Lista pre-definida de itens para comparacao
local listaDesejada = {
  ["minecraft:diamond"] = 64,
  ["minecraft:iron_ingot"] = 128,
  -- Adicione mais itens conforme necessário
}

-- Funcao para listar todos os itens do baú adjacente
function ListarItens()
  local chest = peripheral.find("minecraft:chest")
  if chest then
    local items = chest.list()
    for slot, item in pairs(items) do
      print(slot .. ": " .. item.name .. " x" .. item.count)
    end
  else
    print("Nenhum bau encontrado. Por favor, coloque adjacente ao computador.")
  end
end

-- Funcao para comparar o conteudo do bau com a lista desejada
function CompararComListaDesejada()
  local chest = peripheral.find("minecraft:chest")
  if chest then
    local items = chest.list()
    for nomeItem, qtdDesejada in pairs(listaDesejada) do
      local qtdEncontrada = 0
      for slot, item in pairs(items) do
        if item.name == nomeItem then
          qtdEncontrada = qtdEncontrada + item.count
        end
      end
      if qtdEncontrada < qtdDesejada then
        print("Faltam " .. (qtdDesejada - qtdEncontrada) .. " de " .. nomeItem)
      else
        print("Quantidade suficiente de " .. nomeItem)
      end
    end
  else
    print("Nenhum bau encontrado. Por favor, coloque adjacente ao computador.")
  end
end

-- Chamada das funções
ListarItens()
CompararComListaDesejada()
