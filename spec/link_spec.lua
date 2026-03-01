---@diagnostic disable: undefined-field, param-type-mismatch, need-check-nil
local link = require("core.link")
local spec_utils = require("spec.spec_utils")

describe("resolve_link", function()

  local temp_dir = spec_utils.make_tmp_dir()

  it("resolves a link without anchor", function()
    -- arrange
    local path = temp_dir .. "/note.md"
    local file = io.open(path, "w")
    file:write("content")
    file:close()

    -- act
    local result = link.resolve_link("note", temp_dir)

    -- assert
    assert.is_not_nil(result)
    assert.are.equal(path, result.path)
    assert.is_nil(result.anchor)
    assert.is_true(result.exists)
  end)

  it("resolves a link with anchor", function()
    -- arrange
    local path = temp_dir .. "/note-with-anchor.md"
    local file = io.open(path, "w")
    file:write("content")
    file:close()

    -- act
    local result = link.resolve_link("note-with-anchor#section-2", temp_dir)

    -- assert
    assert.are.equal(path, result.path)
    assert.are.equal("section-2", result.anchor)
    assert.is_true(result.exists)
  end)

  it("returns exists=false when file does not exist", function()
    -- act
    local result = link.resolve_link("nonexistent", temp_dir)

    -- assert
    assert.are.equal(temp_dir .. "/nonexistent.md", result.path)
    assert.is_false(result.exists)
    assert.is_nil(result.anchor)
  end)

  it("errors if link contains .md extension", function()
    -- act & assert
    assert.has_error(function()
      link.resolve_link("note.md", temp_dir)
    end)
  end)

  it("errors if anchor contains invalid characters", function()
    -- act & assert
    assert.has_error(function()
      link.resolve_link("note#Section 2", temp_dir)
    end)
  end)

  it("errors if anchor contains uppercase letters", function()
    -- act & assert
    assert.has_error(function()
      link.resolve_link("note#Section-2", temp_dir)
    end)
  end)

  it("errors if vault_root is not a string", function()
    -- act & assert
    assert.has_error(function()
      link.resolve_link("note", 123)
    end)
  end)

  it("errors if link is not a string", function()
    -- act & assert
    assert.has_error(function()
      link.resolve_link(123, temp_dir)
    end)
  end)

end)
