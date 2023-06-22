return {
  "lvimuser/lsp-inlayhints.nvim",
  event = "LspAttach",
  enabled = function()
    return rnv.opt.lsp_inlayhints
  end,
  config = function(_, opts)
    require("lsp-inlayhints").setup(opts)
    vim.api.nvim_create_augroup("LspAttachInlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = "LspAttachInlayhints",
      callback = function(args)
        if not (args.data and args.data.client_id) then
          return
        end
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        require("lsp-inlayhints").on_attach(client, args.buf, false)
      end,
    })
  end,
}
