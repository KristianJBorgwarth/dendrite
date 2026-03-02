local M = {}

--- List all markdown notes in a vault recursively.
---@param vault_root string the root directory of the vault
---@return table a list of absolute file paths to .md files
function M.list_notes(vault_root)
  assert(type(vault_root) == "string", "vault_root must be a string")

  local results = {}
  local p = io.popen('find "' .. vault_root .. '" -type f -name "*.md"')
  if not p then
    error("Could not list notes in vault: " .. vault_root)
  end

  for path in p:lines() do
    table.insert(results, path)
  end
  p:close()

  return results
end

return M
