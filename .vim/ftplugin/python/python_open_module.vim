" vim: ts=4 shiftwidth=4 expandtab fdm=marker
" author: tocer tocer.deng@gmail.com
" version: 1.0.2
" lastchange: 2008-12-16


if !has('python')
    echohl ErrorMsg | echomsg "Required vim compiled with +python" | echohl None
    finish
endif

" the following is python code {{{
python << eof

import vim
if vim.eval('exists("g:pom_key_open")') == '0':
    key_open = '<C-]>'
else:
    key_open = vim.eval('g:pom_key_open')
if vim.eval('exists("g:pom_key_open_in_win")') == '0':
    key_open_in_win = '<LocalLeader>ow'
else:
    key_open_in_win = vim.eval('g:pom_key_open_in_win')
if vim.eval('exists("g:pom_key_open_in_tab")') == '0':
    key_open_in_tab = '<LocalLeader>ot'
else:
    key_open_in_tab = vim.eval('g:pom_key_open_in_tab')

cmd_open = 'noremap <buffer> %s :py pymoduleopner.open()<CR>' % key_open
cmd_open_in_win = 'noremap <buffer> %s :py pymoduleopner.open_in_win()<CR>' % key_open_in_win
cmd_open_in_tab = 'noremap <buffer> %s :py pymoduleopner.open_in_tab()<CR>' % key_open_in_tab
vim.command(cmd_open)
vim.command(cmd_open_in_win)
vim.command(cmd_open_in_tab)

eof
" }}}

if exists("g:loaded_pymoduleopner")
    finish
endif
let g:loaded_pymoduleopner=1

" the following is python code {{{
python << END

import vim
import inspect
import compiler
from types import FunctionType, ClassType, ModuleType, MethodType

class ImportVisitor(object):
    def __init__(self):
        self.imports = {}

    def visitFrom(self, node):
        for name, alias in node.names:
            _name = alias or name
            self.imports[_name] = "%s.%s" % (node.modname, name)

    def visitImport(self, node):
        for name, alias in node.names:
            _name = alias or name
            self.imports[_name] = name

class PyModuleOpener(object):
    def __init__(self):
        self.visitor = ImportVisitor()

    def get_imports(self):
        source = vim.current.buffer[:]
        _source = [line.strip() for line in source if line.strip().startswith(('import', 'from'))]
        if _source:
            tree = compiler.parse('\n'.join(_source))
            compiler.walk(tree, self.visitor, verbose=1)
            return self.visitor.imports

    def get_real_mod(self, modname):
        imports = self.get_imports()
        if imports:
            for _mod, _real in imports.items():
                if modname.startswith(_mod):
                    real_mod = _real + modname.split(_mod)[-1]
                    return real_mod

    def importmod(self, modname):
        if not modname:
            raise ImportError
        modlist = modname.split('.')
        _modname = modlist[0]
        mod = __import__(_modname, {})
        if len(modlist) > 1:
            for m in modlist[1:]:
                if hasattr(mod, m):
                    _mod = getattr(mod, m)
                    if type(_mod) in (FunctionType, ClassType, ModuleType, MethodType):
                        mod = _mod
                    else:
                        break
                else:
                    break
        return mod

    def locate(self, mod):
        fname = inspect.getsourcefile(mod)
        _, linenum = inspect.getsourcelines(mod)
        return fname, linenum

    def open(self):
        fname, linenum = self._open()
        if fname:
            cmd = 'hide edit %s | %d' % (fname, linenum+1)
            vim.command(cmd)

    def open_in_win(self):
        fname, linenum = self._open()
        if fname:
            cmd = 'new %s | %d' % (fname, linenum+1)
            vim.command(cmd)

    def open_in_tab(self):
        fname, linenum = self._open()
        if fname:
            cmd = 'tabnew %s | %d' % (fname, linenum+1)
            vim.command(cmd)

    def _open(self):
        try:
            modname = vim.eval("expand('<cfile>')")
            real_mod = self.get_real_mod(modname)
            mod = self.importmod(real_mod)
            fname, linenum = self.locate(mod)
            return fname, linenum
        except TypeError, e:
            msg = 'Can not open source because it is a buildin module.'
            vim.command('echohl ErrorMsg | echomsg "%s" | echohl None' % msg)
            return None, None
        except Exception, e:
            msg = 'Can not open source, maybe it is not a valid module, class or function.'
            vim.command('echohl ErrorMsg | echomsg "%s" | echohl None' % msg)
            return None, None


pymoduleopner = PyModuleOpener()


END
" }}}
