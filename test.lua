local function MakeGrid(Width, Height)
  local TestGrid = {}
  
  for Y = 1, Height do
    TestGrid[Y] = {}
    for X = 1, Width do
        TestGrid[Y][X] = {255,255,255}
    end 
  end
  
  return TestGrid
end

local OriginalGrid = MakeGrid(5,5)

for Index, Value in ipairs(OriginalGrid) do
  local blah = {}
  for Value2, _ in ipairs(Value) do
      table.insert(blah, Value2)
  end 
  print(Index, table.concat(blah, " "))
end 
