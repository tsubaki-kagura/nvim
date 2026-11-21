require('vim._core.ui2').enable({
    enable = true,
    msg = {
        target = 'msg',
        targets = {
            emsg = 'pager',
            echoerr = 'pager',
            lua_error = 'pager',
            rpc_error = 'pager',
            list_cmd = 'pager',
            shell_cmd = 'pager',
            shell_out = 'pager',
            shell_ret = 'pager',
            shell_err = 'pager',
            verbose = 'pager',
        },
        msg = { height = 0.3, timeout = 5000 },
        pager = { height = 0.5 },
    },
})

require('tiny-cmdline').setup({
    width = { value = '70%' },
    position = { x = '50%', y = '25%' },
    title = { enabled = true, pos = 'left' },
})
