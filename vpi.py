import re
import sys
import vim


def set_option(name, value):
    try:
        vim.options[name] = value
    except KeyError:
        try:
            vim.current.window.options[name] = value
        except KeyError:
            vim.current.buffer.options[name] = value


class FlagValue:
    def __init__(self, byte_str):
        self.string = byte_str.decode('utf-8')

    def __add__(self, other):
        return f'{self.string}{other}'

    def __sub__(self, other):
        return ''.join([flag for flag in self.string if flag not in other])


class ListValue:
    def __init__(self, list_str):
        self.string = list_str.decode('utf-8')

    def __add__(self, other):
        return f'{self.string}{"," if self.string else ""}{other}'


class VPIModeMappings:
    def __getitem__(self, key):
        return VPIKeyMappings(key)


class VPIKeyMappings:
    def __init__(self, mode):
        self.mode = 'v' if mode == VPI.MODE_VISUAL else mode

    def __getitem__(self, key):
        vim.command(f'redir => g:vpi_mapping | silent {self.mode}map {key} | redir END')
        mapping = vim.vars['vpi_mapping'].decode('utf-8').split('\n')[-1][3:]
        return re.search(r'(?<=\s)\S.*', mapping).group()

    def __setitem__(self, key, value):
        if isinstance(value, str):
            vim.command(f'{self.mode}{"nore" if value[0:6] != "<Plug>" else ""}map {key} {value}')
        else:
            vim.command(f'{self.mode}noremap {" ".join(value[1:])} {key} {value[0]}')


class VPI:
    COMPLETE_CURRENT_AND_INCLUDED = 'i'

    ENCODING_UTF8 = 'utf-8'

    FORMATOPTIONS_REMOVE_COMMENT_LEADER = 'j'

    GUICURSOR_SHAPE_BLOCK = 'block'
    GUICURSOR_SHAPE_HORIZONTAL = 'hor'
    GUICURSOR_SHAPE_VERTICAL = 'ver'

    GUIOPTIONS_MENU_BAR = 'm'
    GUIOPTIONS_TOOLBAR = 'T'
    GUIOPTIONS_RIGHT_SCROLLBAR = 'r'
    GUIOPTIONS_LEFT_SCROLLBAR = 'L'
    GUIOPTIONS_BOTTOM_SCROLLBAR = 'b'
    GUIOPTIONS_TAB_PAGES = 'e'
    GUIOPTIONS_EXTERNAL_COMMANDS = '!'
    GUIOPTIONS_CONSOLE_DIALOGS = 'c'

    LASTSTATUS_ALWAYS = 2

    MODE_NORMAL = 'n'
    MODE_VISUAL = 'v'
    MODE_OPERATOR = 'o'
    MODE_INSERT = 'i'
    MODE_REPLACE = 'r'
    MODE_COMMAND_LINE = 'c'
    MODE_COMMAND_LINE_INSERT = 'ci'
    MODE_COMMAND_LINE_REPLACE = 'cr'
    MODE_COMMAND_SHOWMATCH = 'sm'
    MODE_TERMINAL = 't'
    MODE_ALL = 'a'

    def __getattr__(self, name):
        value = None

        if name == 'mappings':
            value = VPIModeMappings()
        elif name == 'colorscheme':
            value = vim.vars['colors_name']
        else:
            try:
                value = vim.options[name]
            except KeyError:
                value = vim.current.buffer.options[name]

        if name == 'runtimepath':
            value = ListValue(value)
        elif isinstance(value, bytes):
            value = FlagValue(value)

        return value

    def __setattr__(self, name, value):
        if name == 'colorscheme':
            vim.command(f'colorscheme {value}')
        elif name == 'termguicolors':
            if int(vim.eval("has('termguicolors')")):
                set_option(name, value)
        elif name == 'guicursor':
            set_option(name, ','.join([f'{mode_list}:{"-".join(argument_list)}' for mode_list, argument_list in value.items()]))
        else:
            set_option(name, value)

    def mode_list(self, modes):
        return '-'.join(modes)

    def set_defaults(self):
        vim.command('source $VIMRUNTIME/defaults.vim')

sys.modules[__name__] = VPI()
