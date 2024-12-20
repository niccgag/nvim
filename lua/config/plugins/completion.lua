return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets', { "L3MON4D3/LuaSnip" } },

    version = 'v0.*',

    opts = {
      keymap = { preset = 'default' },

      snippets = {
        expand = function(snippet) require("luassnip").lsp_expand(snippet) end,
        aactive = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction) require("luasnip").jump(direction) end,
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true }
    },
  },
}