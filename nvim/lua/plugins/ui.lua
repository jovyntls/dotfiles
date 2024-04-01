local rgb_map = require('plugins.colormap')

local set_fg = function(highlight_group, fg, opts)
  opts = opts or {} -- default value
  opts.ctermfg = fg
  opts.fg = rgb_map[fg]
  vim.api.nvim_set_hl(0, highlight_group, opts)
end

local set_hl = function(highlight_group, opts)
  if opts.fg then
    opts.ctermfg = opts.fg
    opts.fg = rgb_map[opts.fg] or opts.fg
  end
  if opts.bg then
    opts.ctermbg = opts.bg
    opts.bg = rgb_map[opts.bg] or opts.bg
  end
  vim.api.nvim_set_hl(0, highlight_group, opts)
end

local clr = {
  darkerbg = 233,
  lighterbg = 238,
  mutegray = 59,
  deepblue = 68,
  neutralblue = 109,
  neutralgreen = 108,
  orangeyellow = 179,
  orange = 173,
  yellow = 222,
  hotpink = 168,
  lilac = 146,
}

return {
  {
    'jovyntls/seoul256.vim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.seoul256_background = 234
      vim.opt.termguicolors = true
      vim.cmd.colorscheme('seoul256')

      -- fix comment overriding todo highlight
      vim.api.nvim_set_hl(0, '@lsp.type.comment', {})

      -- define colours for nvim-cmp
      set_hl("CmpPmenu", { bg = clr.darkerbg })
      set_hl("CmpCursorLine", { bg = clr.lighterbg })
      set_hl('NormalFloat', { bg = clr.darkerbg }) -- for diagnostics float

      set_fg("CmpItemAbbrDeprecated", clr.mutegray, { strikethrough = true })
      set_fg("CmpItemMenu", clr.mutegray, { italic = true })
      set_fg("CmpItemAbbrMatch", clr.deepblue, { bold = true })
      set_hl("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

      set_fg("CmpItemKindFunction", clr.neutralblue)
      set_fg("CmpItemKindMethod", clr.neutralblue)

      set_fg("CmpItemKindConstant", clr.neutralgreen, { bold = true })
      set_fg("CmpItemKindVariable", clr.neutralgreen)
      set_fg("CmpItemKindText", clr.neutralgreen)

      set_fg("CmpItemKindConstructor", clr.orangeyellow, { italic = true })
      set_fg("CmpItemKindClass", clr.orangeyellow)
      set_fg("CmpItemKindInterface", clr.orangeyellow)
      set_fg("CmpItemKindStruct", clr.orangeyellow)

      set_fg("CmpItemKindField", clr.orangeyellow)
      set_fg("CmpItemKindProperty", clr.orangeyellow)

      set_fg("CmpItemKindModule", clr.orange)

      set_fg("CmpItemKindOperator", clr.yellow)
      set_fg("CmpItemKindTypeParameter", clr.yellow)
      set_fg("CmpItemKindEnum", clr.yellow)
      set_hl("CmpItemKindEnumMember", { link = "CmpItemKindEnum" })

      set_fg("CmpItemKindKeyword", clr.hotpink)

      set_fg("CmpItemKindFile", clr.lilac)
      set_fg("CmpItemKindFolder", clr.lilac)
      set_fg("CmpItemKindSnippet", clr.lilac)

      set_fg("CmpItemKindEvent", clr.mutegray)
      set_fg("CmpItemKindReference", clr.mutegray)
      set_fg("CmpItemKindValue", clr.mutegray)
      set_fg("CmpItemKindUnit", clr.mutegray)
      set_fg("CmpItemKindColor", clr.mutegray)
    end
  },

  {
    'itchyny/lightline.vim',
    config = function()
      vim.g.lightline = {
        active = {
          left = {
            { 'mode',     'paste' },
            { 'readonly', 'filename', 'modified' }
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'filetype' }
          }
        },
        inactive = {
          left = {
            { 'filename' }
          },
          right = {}
        },
        colorscheme = 'seoul256'
      }
    end
  },

  {
    'echasnovski/mini.hipatterns',
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          hex_color       = hipatterns.gen_highlighter.hex_color(),
          todo            = { pattern = { '%f[%w]()TODO()%f[%W]', '%f[%w]()todo()%f[%W]' }, group = 'MiniHipatternsTodo' },
          fixme           = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack            = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          note            = { pattern = '%f[%w]()XXX()%f[%W]', group = 'MiniHipatternsNote' },
          merge_conflicts = { pattern = { '^<<<<<<<%s.+', '^=======$', '^()>>>>>>>%s.+' }, group = 'MiniHipatternsStandout' },
        },
      })

      set_hl('MiniHipatternsTodo', { fg = 'white', bg = clr.hotpink, bold=true, italic=true })
      set_hl('MiniHipatternsHack', { fg = clr.darkerbg, bg = clr.orangeyellow, bold=true })
      set_hl('MiniHipatternsFixme', { fg = clr.darkerbg, bg = clr.orange, bold=true })
      set_hl('MiniHipatternsNote', { fg = clr.darkerbg, bg = clr.neutralblue, bold=true })
      set_hl('MiniHipatternsStandout', { fg = clr.darkerbg, bg = 'white', bold=true })
    end
  }
}
