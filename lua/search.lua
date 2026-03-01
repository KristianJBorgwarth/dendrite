local M = {}

function M.search_notes(query, vault_root)
  assert(type(query) == "string", "query must be a string")
  assert(type(vault_root) == "string", "vault_root must be a string")

  local results = {}
  local p = io.open('find "' .. vault_root .. '" -type f -name "*.md"')

  if not p then
    error("Could not open vault directory: " .. vault_root)
  end

  for file in p:lines() do
    local content = io.open(file):read("*all")
    if content:lower():find(query:lower()) then
      table.insert(results, file)
    end
  end
  p:close()

  return results
end

return M
