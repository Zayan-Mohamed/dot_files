-- Configuration for molten-nvim
-- See: https://github.com/benlubas/molten-nvim

-- Set molten to use image.nvim for image rendering
vim.g.molten_image_provider = "image.nvim"

-- Enable virtual text output
vim.g.molten_virt_text_output = true

-- Adjust virtual lines to account for padding
vim.g.molten_virt_lines_off_by_1 = true

-- Automatically open output window when output is available
vim.g.molten_auto_open_output = true

-- Set output window max height
vim.g.molten_output_win_max_height = 20

-- Set output window max width
vim.g.molten_output_win_max_width = 80

-- Hide output window when leaving
vim.g.molten_output_win_hide_on_leave = true

-- Output window border style
vim.g.molten_output_win_border = { "", "━", "", "" }

-- Show execution time
vim.g.molten_output_show_exec_time = true

-- Wrap output text
vim.g.molten_wrap_output = true

-- Save output to a directory
vim.g.molten_save_path = vim.fn.stdpath("data") .. "/molten"

-- Use border highlights for output
vim.g.molten_use_border_highlights = true

-- Highlight settings
vim.g.molten_output_show_more = false
vim.g.molten_output_virt_lines = false

-- Copy output to clipboard
vim.g.molten_copy_output = false

-- Cover empty lines in notebook cells
vim.g.molten_cover_empty_lines = false

-- Keybindings for molten
local keymap = vim.keymap

-- Initialize a kernel
keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", {
  desc = "Initialize Molten",
  silent = true,
})

-- Evaluate operator (use with motions, e.g., <localleader>eip for paragraph)
keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", {
  desc = "Molten evaluate operator",
  silent = true,
})

-- Evaluate current line
keymap.set("n", "<localleader>el", ":MoltenEvaluateLine<CR>", {
  desc = "Molten evaluate line",
  silent = true,
})

-- Re-evaluate cell
keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", {
  desc = "Molten re-evaluate cell",
  silent = true,
})

-- Evaluate visual selection
keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", {
  desc = "Molten evaluate visual",
  silent = true,
})

-- Open output window
keymap.set("n", "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", {
  desc = "Molten open output",
  silent = true,
})

-- Hide output
keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", {
  desc = "Molten hide output",
  silent = true,
})

-- Delete cell
keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", {
  desc = "Molten delete cell",
  silent = true,
})

-- Show/Hide output for all cells
keymap.set("n", "<localleader>oa", ":MoltenShowOutput<CR>", {
  desc = "Molten show all output",
  silent = true,
})

-- Automatically initialize molten with the correct kernel for python files in venv
keymap.set("n", "<localleader>ip", function()
  local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
  if venv ~= nil then
    -- Extract venv name from path
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd("MoltenInit python3")
  end
end, {
  desc = "Initialize Molten for Python",
  silent = true,
})

-- Import outputs from ipynb files
keymap.set("n", "<localleader>mo", ":MoltenImportOutput<CR>", {
  desc = "Molten import output",
  silent = true,
})

-- Export outputs to ipynb files
keymap.set("n", "<localleader>mx", ":MoltenExportOutput<CR>", {
  desc = "Molten export output",
  silent = true,
})

-- Interrupt kernel
keymap.set("n", "<localleader>mk", ":MoltenInterrupt<CR>", {
  desc = "Molten interrupt kernel",
  silent = true,
})

-- Restart kernel
keymap.set("n", "<localleader>mr", ":MoltenRestart<CR>", {
  desc = "Molten restart kernel",
  silent = true,
})

-- Automatically import output chunks from a jupyter notebook
local imb = function(e)
  vim.schedule(function()
    local kernels = vim.fn.MoltenAvailableKernels()
    local try_kernel_name = function()
      local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
      return metadata.kernelspec.name
    end
    local ok, kernel_name = pcall(try_kernel_name)
    if not ok or not vim.tbl_contains(kernels, kernel_name) then
      kernel_name = nil
      local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
      if venv ~= nil then
        kernel_name = string.match(venv, "/.+/(.+)")
      end
    end
    if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
      vim.cmd(("MoltenInit %s"):format(kernel_name))
    end
    vim.cmd("MoltenImportOutput")
  end)
end

-- Auto-import when opening ipynb files
vim.api.nvim_create_autocmd("BufAdd", {
  pattern = { "*.ipynb" },
  callback = imb,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ipynb" },
  callback = function(e)
    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
      imb(e)
    end
  end,
})

-- Automatically export output chunks to a jupyter notebook on write
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ipynb" },
  callback = function()
    if require("molten.status").initialized() == "Molten" then
      vim.cmd("MoltenExportOutput!")
    end
  end,
})

-- Change Molten settings for regular Python files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    if require("molten.status").initialized() == "Molten" then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
      vim.fn.MoltenUpdateOption("virt_text_output", false)
    else
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_virt_text_output = false
    end
  end,
})

-- Restore settings when entering markdown/notebook files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.qmd", "*.md", "*.ipynb" },
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    if require("molten.status").initialized() == "Molten" then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
      vim.fn.MoltenUpdateOption("virt_text_output", true)
    else
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_output = true
    end
  end,
})
