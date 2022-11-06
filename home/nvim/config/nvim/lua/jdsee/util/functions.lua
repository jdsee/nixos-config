-- NVIM FUNCTIONS

local function extend_opt(lh, rh)
  if lh then
    return vim.tbl_extend("force", lh, rh)
  else
    return rh
  end
end

local function map(mode, lhs, rhs, opts)
  local options = { silent = true }
  options = extend_opt(opts, options)
  vim.keymap.set(mode, lhs, rhs, options)
end


local function bmap(mode, lhs, rhs, opts)
  local options = { silent = true, buffer = true }
  options = extend_opt(opts, options)
  map(mode, lhs, rhs, opts)
end

return {
  map = map,
  bmap = bmap
}

