local GridX = 5
local GridY = 5

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

local function PrintGrid(grid)
  for Index, Value in ipairs(grid) do
  local blah = {}
  for Value2, _ in ipairs(Value) do
      table.insert(blah, Value2)
  end 
  print(Index, table.concat(blah, " "))
end 
end

local OriginalGrid = MakeGrid(5,5)
local Visited = {}

local function CellsAreSame(cell1, cell2) 
  if #cell1 ~= #cell2 then return false end
  
  for Index, _ in ipairs(cell1) do
    if cell1[Index] ~= cell2[Index] then return false end
  end 

  return true
end

local function GreedyMesh(StartY, StartX, RecursiveData)
  RecursiveData = RecursiveData or {}
  
  local SizeX = RecursiveData.SizeX or 0
  local SizeY = RecursiveData.SizeY or 0

  local Direction = RecursiveData.Direction or "X"

  local CurrentCell = OriginalGrid[StartY][StartX]
  local NeighboringCell = nil

  if StartX + 1 > GridX then
    if OriginalGrid[StartY+1] then
      StartY = StartY+1
      print("Going down")
    else
      print("Could not move down because Y"..StartY+1 .." does not exist")
      return
    end
  elseif StartY + 1 > GridY then
    print("Reached end of grid")
    return RecursiveData
  else
    print("Moved over x")
  end

  if Direction == "X" then
    NeighboringCell = OriginalGrid[StartY][StartX+1]
  else
    NeighboringCell = OriginalGrid[StartY+1][StartX]
  end

  print(CellsAreSame(CurrentCell, NeighboringCell))
end
OriginalGrid[4][5] = {255,254,255}

GreedyMesh(4,4)
