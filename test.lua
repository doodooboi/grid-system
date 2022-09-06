local function MakeGrid(Width, Height)
  local TestGrid = {}
  
  for Y = 1, Height do
    TestGrid[y] = {}
    for X = 1, Width do
        TestGrid[y][x] = {255,255,255}
    end 
  end
  return TestGrid
end
