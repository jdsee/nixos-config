local npairs = require 'nvim-autopairs'
local Rule = require 'nvim-autopairs.rule'
-- local cond = require 'nvim-autopairs.conds'

npairs.setup {
  disable_filetype = { 'TelescopePrompt' },
}

-- local double_quote_rule = npairs.get_rule('"')
-- npairs.remove_rule('"')
-- npairs.add_rule(double_quote_rule:with_pairs(cond.not_filetypes { 'tex', 'latex' }))

-- local single_quote_rule = npairs.get_rule("'")
-- npairs.remove_rule("'")
-- npairs.add_rule(single_quote_rule:with_pairs(cond.not_filetypes { 'clojure' }))

npairs.add_rules {
  Rule('$$', '$$', { 'latex', 'tex' }),
}
