local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without updating the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit<CR>")
keymap.set("n", "<tab>", ":tabnext<CR>", opts)
keymap.set("n", "<s-tab>", ":tabprev<CR>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", { noremap = true, silent = true, desc = "Split window horizontaly" })
keymap.set("n", "sv", ":vsplit<Return>", { noremap = true, silent = true, desc = "Split window verticaly" })
-- Move window
keymap.set("n", "sh", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "sk", "<C-w>k", { desc = "Move to upper window" })
keymap.set("n", "sj", "<C-w>j", { desc = "Move to lower window" })
keymap.set("n", "sl", "<C-w>l", { desc = "Move to right window" })

-- Yank current file path
keymap.set("n", "<Leader>yf", function()
	require("utils.editor").yank_relative_path_with_line()
end, { desc = "Yank relative path with line number" })

keymap.set("n", "<Leader>yp", function()
	require("utils.editor").yank_absolute_path_with_line()
end, { desc = "Yank absolute path with line number" })

keymap.set("v", "<Leader>cc", ":<C-u>lua require('craftzdog.utils.editor').copy_as_codeblock()<CR>")

keymap.set("n", "<Leader>j", function()
	require("utils.editor").open_package_json()
end, { desc = "Open package.json in floating window" })

keymap.set("n", "<Leader>bd", function()
	require("utils.editor").delete_hidden_buffers()
end, { desc = "Delete hidden buffers" })

--Toggle Inlay hints

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspInlayHints", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if not client or not client:supports_method("textDocument/inlayHint") then
			return
		end

		-- Enable inlay hints
		vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

		-- Toggle inlay hints
		vim.keymap.set("n", "<leader>ch", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({
				bufnr = ev.buf,
			})

			vim.lsp.inlay_hint.enable(not enabled, {
				bufnr = ev.buf,
			})
		end, {
			buffer = ev.buf,
			desc = "Toggle Inlay Hints",
		})
	end,
})
