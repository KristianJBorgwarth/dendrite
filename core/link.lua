local M = {}

--- Resolve a link to an absolute file path within the vault.
--- @param link any
--- @param vault_root any
function M.resolve(link, vault_root)
  assert(type(link) == "string", "link must be a string")
  assert(type(vault_root) == "string", "vault_root must be a string")
  return vault_root .. "/" .. link .. ".md"
end

return M
