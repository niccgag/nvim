return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "thatnerdjosh/nvim-ketho-wow",
      "jose-elias-alvarez/null-ls.nvim",
      "MunifTanjim/prettier.nvim",
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim"
    },
    config = function()
      local util = require("lspconfig.util")
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require("mason").setup()
      require("mason-nvim-dap").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "ts_ls" },
        automatic_installation = true,
      }

      require("lspconfig").lua_ls.setup { capabilities = capabilities }
      require("nvim-ketho-wow").setup()
      require("lspconfig").ts_ls.setup {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        hostInfo = "neovim"
      }
      require("lspconfig").rust_analyzer.setup{
        settings = {
          ["rust_analyzer"] = {
            diagnostics = {
              enable = false;
            }
          }
        }
      }
      require("lspconfig").gopls.setup{}
      require("lspconfig").phpactor.setup({
        filetypes = { "php", "blade"},
      })
      require("lspconfig").zls.setup{}


      local null_ls = require("null-ls")

      local group = vim.api.nvim_create_augroup("lsp_formate_on_save", { clear = false })
      local event = "BufWritePre"
      local async = event == "BufWritePost"

      null_ls.setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = async })
              end,
              desc = "[lsp] format on save",
            })
          end

          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end
        end
      })

      require("prettier").setup({
        bin = "prettier",
        filetypes = {
          "css",
          "html",
          "javascript",
          "javascriptreact",
          "json",
          "typescript",
          "typescriptreact",
          "yaml",
        },
      })
    end
  } }
