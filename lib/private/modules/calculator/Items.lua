Items = {}
Items.value = {}

local ts = tostring

function Items:set(names)
  if not self.value then
    self.value = {}
  end
  for name, value in pairs(names) do
    if self.value[name] ~= nil then
      self.value[name] = math.min(self.value[name], value)
    else 
      self.value[name] = value
    end
  end
end

function Items:delete(names)
  if not self.value then return end
  for _, name in pairs(names) do
    self.value[name] = nil
  end
end

function Items:hasValue(key)
  return self.value[key] ~= nil
end

function Items:hasValues(keys)
  local has_values = (#keys > 0) and (self:getLength() > 0)
  for _, key in pairs(keys) do
    has_values = has_values and (self.value[key] ~= nil)
  end
  return has_values
end

function Items:printDataset()
  local dataset = '\nTable of values:'
  for key, value in pairs(self.value) do
    dataset = dataset .. '\n' .. ts(key) .. string.rep(' ', 40-#ts(key)) .. string.format('%.3f', value)
  end
  log(dataset)
end

function Items:printItems()
  for key, value in pairs(self.value) do
    log(ts(key) .. string.format('%.3f', value))
  end
end

function Items:getLength()
  local count = 0
  for i, _ in pairs(self.value) do
    count = count + 1
  end
  return count
end