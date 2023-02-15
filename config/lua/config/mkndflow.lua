require('mkdnflow').setup({
    mappings = {
        MkdnEnter = {{'i', 'n', 'v'}, '<CR>'} -- This monolithic command has the aforementioned
            -- insert-mode-specific behavior and also will trigger row jumping in tables. Outside
            -- of lists and tables, it behaves as <CR> normally does.
        -- MkdnNewListItem = {'i', '<CR>'} -- Use this command instead if you only want <CR> in
            -- insert mode to add a new list item (and behave as usual outside of lists).
    }
})
