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
  
  local SizeX = RecursiveData.SizeX or 1
  local SizeY = RecursiveData.SizeY or 1

  local CurrentX = StartX
  local CurrentY = StartY
  
  local Direction = "X"

  local CurrentCell = OriginalGrid[CurrentY][CurrentX]
  local NeighboringCell = nil

  if StartX + 1 > GridX then
    if OriginalGrid[CurrentY+1] then
      CurrentY = StartY+1
      Direction = "Y"
     -- print("Moved Y")
    else
      print("Y"..CurrentY+1 .." does not exist")
      return RecursiveData
    end
  elseif CurrentY + 1 > GridY then
    print("Reached end of grid")
    return RecursiveData
  end

  if Direction == "X" then
    NeighboringCell = OriginalGrid[CurrentY][CurrentX+1]
   -- print("Moved X")
  else
    NeighboringCell = OriginalGrid[StartY+1][StartX]
    --print("Moved Y")
  end

  print(CurrentY, CurrentX)

  if not CurrentCell or not NeighboringCell then
    print("Not Exist")
    return RecursiveData
  end
  
  if CellsAreSame(CurrentCell, NeighboringCell) then
    if Direction == "X" then
      SizeX = SizeX + 1
    else
      SizeY = SizeY + 1
    end

    local RecurseData = {
     ["SizeY"] = SizeY,
     ["SizeX"] = SizeX
    }
    
    return GreedyMesh(CurrentY, CurrentX, RecurseData)
  else
    print("Not Same")
    return RecursiveData
  end
end
--OriginalGrid[4][5] = {255,254,255}

local Data = GreedyMesh(1,5)

print(Data.SizeY, Data.SizeX)
