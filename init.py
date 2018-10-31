import os
import sys
import vim

sys.path.append(os.path.dirname(vim.eval('$MYVIMRC')))

import vpi


vpi.set_defaults()

vpi.autoindent = True
vpi.autoread = True

# Add the directory where the colorscheme exists. This is temporary for now until plugin support is added.
vpi.runtimepath += '~/vimfiles/plugged/base16-vim'
vpi.colorscheme = 'base16-default-dark'

vpi.complete -= vpi.COMPLETE_CURRENT_AND_INCLUDED

# Make it easier to find cursor.
vpi.cursorline = True

# Required by youcompleteme.
vpi.encoding = vpi.ENCODING_UTF8

# Always insert spaces.
vpi.expandtab = True

vpi.formatoptions += vpi.FORMATOPTIONS_REMOVE_COMMENT_LEADER

vpi.guicursor = {
    vpi.mode_list([
        vpi.MODE_NORMAL,
        vpi.MODE_VISUAL,
        vpi.MODE_COMMAND_LINE
    ]): [vpi.GUICURSOR_SHAPE_BLOCK],
    vpi.mode_list([vpi.MODE_OPERATOR]): [f'{vpi.GUICURSOR_SHAPE_HORIZONTAL}15'],
    vpi.mode_list([vpi.MODE_INSERT, vpi.MODE_COMMAND_LINE_INSERT]): [f'{vpi.GUICURSOR_SHAPE_VERTICAL}10'],
}

# Do not use up screen space with menu, tool or scroll bars.
# Keep GUI interface similar to terminal.
vpi.guioptions -= vpi.GUIOPTIONS_MENU_BAR + vpi.GUIOPTIONS_TOOLBAR + vpi.GUIOPTIONS_RIGHT_SCROLLBAR + vpi.GUIOPTIONS_LEFT_SCROLLBAR + vpi.GUIOPTIONS_BOTTOM_SCROLLBAR + vpi.GUIOPTIONS_TAB_PAGES
vpi.guioptions += vpi.GUIOPTIONS_EXTERNAL_COMMANDS + vpi.GUIOPTIONS_CONSOLE_DIALOGS

vpi.laststatus = vpi.LASTSTATUS_ALWAYS

# Improve speed for line-based movements. Do not show number to reduce space taken up by line number column.
vpi.relativenumber = True

# Always round indents to multiple of shiftwidth
vpi.shiftround = True

vpi.smarttab = True

# When window is split, move to the created window.
vpi.splitbelow = True
vpi.splitright = True

# Mode can generally be determined from cursor shape.
vpi.showmode = False

vpi.termguicolors = True

# Make tilde behave like operator.
vpi.tildeop = True

vpi.wrapscan = False


# Improve <C-L>.
vpi.mappings[vpi.MODE_NORMAL]['<C-L>'] = (':nohlsearch<C-R>=has("diff")?"<Bar>diffupdate":""<CR><CR><C-L>', '<silent>')

for mode in [vpi.MODE_NORMAL, vpi.MODE_VISUAL, vpi.MODE_OPERATOR]:
    # s and S should always be sneak motion.
    vpi.mappings[mode]['s'] = '<Plug>Sneak_s'
    vpi.mappings[mode]['S'] = '<Plug>Senak_S'

    # <C-N> and <C-P> in normal are already implemented by j and k and their usual functionality is compatible with n and N.
    # Search repeat movements should always move in the same direction.
    vpi.mappings[mode]['<C-N>'] = ('"Nn"[v:searchforward]', '<expr>')

# Better than default <C-N> and <C-P> in command-line mode.
vpi.mappings[vpi.MODE_COMMAND_LINE]['<C-N>'] = '<Down>'
vpi.mappings[vpi.MODE_COMMAND_LINE]['<C-P>'] = '<Up>'

# <Esc> always goes to normal mode.
vpi.mappings[vpi.MODE_TERMINAL]['<Esc>'] = '<C-\><C-N>'

# Provide functionality to send <Esc> to terminal.
vpi.mappings[vpi.MODE_TERMINAL]['<C-`>'] = '<Esc>'

# Do not lose selection after shift.
for shift in ['<', '>']:
    vpi.mappings[vpi.MODE_VISUAL][shift] = f'{shift}gv'