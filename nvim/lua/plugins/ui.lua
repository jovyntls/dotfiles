local set_fg = function(highlight_group, fg, opts)
  opts = opts or {} -- default value
  opts.ctermfg = fg
  opts.fg = fg
  vim.api.nvim_set_hl(0, highlight_group, opts)
end

local recolour = function(highlight_group, opts)
  opts = opts or {} -- default value
  if opts.fg then
    opts.ctermfg = opts.fg
  end
  if opts.bg then
    opts.ctermbg = opts.bg
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
      vim.g.seoul256_background = 235
      vim.cmd.colorscheme('seoul256')

      -- fix comment overriding todo highlight
      vim.api.nvim_set_hl(0, '@lsp.type.comment', {})

      -- define colours for nvim-cmp
      recolour("CmpPmenu", { ctermbg = clr.darkerbg })
      recolour("CmpCursorLine", { ctermbg = clr.lighterbg })
      recolour('NormalFloat', { ctermbg = clr.darkerbg }) -- for diagnostics float

      set_fg("CmpItemAbbrDeprecated", clr.mutegray, { strikethrough = true })
      set_fg("CmpItemMenu", clr.mutegray, { italic = true })
      set_fg("CmpItemAbbrMatch", clr.deepblue, { bold = true })
      recolour("CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

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
      recolour("CmpItemKindEnumMember", { link = "CmpItemKindEnum" })

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
          -- hex_color       = hipatterns.gen_highlighter.hex_color(),
          todo            = { pattern = { '%f[%w]()TODO()%f[%W]', '%f[%w]()todo()%f[%W]' }, group = 'MiniHipatternsTodo' },
          fixme           = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack            = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          note            = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          merge_conflicts = { pattern = { '^()<<<<<<<()%s%w', '^()=======()%s%w', '^()>>>>>>>()%s%w' }, group = 'MiniHipatternsNote' },
        },
      })

      recolour('MiniHipatternsTodo', { fg = 'white', bg = clr.hotpink, bold=true, italic=true })
      recolour('MiniHipatternsHack', { fg = clr.darkerbg, bg = clr.orangeyellow, bold=true })
      recolour('MiniHipatternsFixme', { fg = clr.darkerbg, bg = clr.orange, bold=true })
      recolour('MiniHipatternsNote', { fg = clr.darkerbg, bg = clr.neutralblue, bold=true })
    end
  }
}
