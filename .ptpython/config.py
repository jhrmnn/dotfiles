from ptpython.layout import CompletionVisualisation


def configure(repl):
    repl.show_docstring = True
    repl.completion_visualisation = CompletionVisualisation.POP_UP
    repl.use_code_colorscheme('native')
    repl.confirm_exit = False
    repl.show_status_bar = False
    repl.prompt_style = 'classic'
    repl.vi_mode = True
    repl.show_line_numbers = False
