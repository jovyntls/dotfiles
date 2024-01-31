return {
  {
    'jovyntls/seoul256.vim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.seoul256_background = 235
      vim.cmd.colorscheme('seoul256')

      -- define colours for nvim-cmp

      local recolour = function(highlight_group, fg, opts)
        opts = opts or {} -- default value
        opts.ctermfg = fg
        vim.api.nvim_set_hl(0, highlight_group, opts)
      end

      local clr = {
        mutegray = 145,
        deepblue = 68,
        neutralblue = 109,
        neutralgreen = 108,
        orangeyellow = 179,
        orange = 173,
        yellow = 222,
        hotpink = 168,
        lilac = 146,
      }

      recolour("CmpPmenu", 'None', { ctermbg = 233 })
      recolour("CmpCursorLine", 'None', { ctermbg = 238 })

      recolour("CmpItemAbbrDeprecated", clr.mutegray, { strikethrough = true })
      recolour("CmpItemMenu", clr.mutegray, { italic = true })
      recolour("CmpItemAbbrMatch", clr.deepblue, { bold = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })

      recolour("CmpItemKindFunction", clr.neutralblue)
      recolour("CmpItemKindMethod", clr.neutralblue)

      recolour("CmpItemKindConstant", clr.neutralgreen, { bold = true })
      recolour("CmpItemKindVariable", clr.neutralgreen)
      recolour("CmpItemKindText", clr.neutralgreen)

      recolour("CmpItemKindConstructor", clr.orangeyellow, { italic = true })
      recolour("CmpItemKindClass", clr.orangeyellow)
      recolour("CmpItemKindInterface", clr.orangeyellow)
      recolour("CmpItemKindStruct", clr.orangeyellow)

      recolour("CmpItemKindField", clr.orangeyellow)
      recolour("CmpItemKindProperty", clr.orangeyellow)

      recolour("CmpItemKindModule", clr.orange)

      recolour("CmpItemKindOperator", clr.yellow)
      recolour("CmpItemKindTypeParameter", clr.yellow)
      recolour("CmpItemKindEnum", clr.yellow)
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { link = "CmpItemKindEnum" })

      recolour("CmpItemKindKeyword", clr.hotpink)

      recolour("CmpItemKindFile", clr.lilac)
      recolour("CmpItemKindFolder", clr.lilac)
      recolour("CmpItemKindSnippet", clr.lilac)

      recolour("CmpItemKindEvent", clr.mutegray)
      recolour("CmpItemKindReference", clr.mutegray)
      recolour("CmpItemKindValue", clr.mutegray)
      recolour("CmpItemKindUnit", clr.mutegray)
      recolour("CmpItemKindColor", clr.mutegray)
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
  }
}
