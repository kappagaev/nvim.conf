local dap = require('dap')

dap.defaults.fallback.terminal_win_cmd = '20split new'
vim.fn.sign_define('DapBreakpoint',
	{ text = '🟥', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected',
	{ text = '🟦', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped',
	{ text = '⭐️', texthl = '', linehl = '', numhl = '' })

vim.keymap.set('n', '<leader>b',
	function() require "dap".toggle_breakpoint() end)
vim.keymap.set('n', '<leader>dH',
	":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set({ 'n', 't' }, '<A-k>', function() require "dap".step_out() end)
vim.keymap.set({ 'n', 't' }, "<A-l>", function() require "dap".step_into() end)
vim.keymap.set({ 'n', 't' }, '<A-j>', function() require "dap".step_over() end)
vim.keymap.set({ 'n', 't' }, '<A-h>', function() require "dap".continue() end)
vim.keymap.set('n', '<leader>dn', function() require "dap".run_to_cursor() end)
vim.keymap.set('n', '<leader>dc', function() require "dap".terminate() end)
vim.keymap.set('n', '<leader>dR',
	function() require "dap".clear_breakpoints() end)
vim.keymap.set('n', '<leader>de',
	function() require "dap".set_exception_breakpoints({ "all" }) end)
vim.keymap.set('n', '<leader>da', function() require "debugHelper".attach() end)
vim.keymap.set('n', '<leader>dA',
	function() require "debugHelper".attachToRemote() end)
vim.keymap
		.set('n', '<leader>di', function() require "dap.ui.widgets".hover() end)
vim.keymap.set('n', '<leader>d?', function()
	local widgets = require "dap.ui.widgets";
	widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<leader>dk', ':lua require"dap".up()<CR>zz')
vim.keymap.set('n', '<leader>dj', ':lua require"dap".down()<CR>zz')
vim.keymap.set('n', '<leader>dr',
	':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

-- jester maps
vim.keymap.set('n', '<leader>rd', function()
	require("dap-go").debug_test()
end, { desc = "Run Debug, current pointer test" })

vim.keymap.set('n', '<leader>rr', function()
	require("dap-go").debug_last_test()
end, { desc = "ReRun last debug test" })

vim.keymap.set('n', '<leader>du', function()
	vim.cmd("NvimTreeClose")
	require("dapui").toggle({});
end)

require('persistent-breakpoints').setup {
	save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
	-- when to load the breakpoints? "BufReadPost" is recommanded.
	load_breakpoints_event = nil,
	-- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
	perf_record = false,
}
