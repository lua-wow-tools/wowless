return (function(self, parent)
  if type(parent) == 'string' then
    parent = api.env[parent]
  end
  UpdateVisible(self, function()
    api.SetParent(self, parent)
  end)
end)(...)
