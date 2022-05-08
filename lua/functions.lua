local cmd = vim.cmd
function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function RunWith(executor_binary)
    cmd(':w')
    cmd(
      string.format(
        ':call VimuxRunCommandInDir("clear;time PATH=$PATH %s", 1)',
        executor_binary
      )
    )
end
