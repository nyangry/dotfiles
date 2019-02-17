# REF: https://github.com/Shougo/unite.vim/blob/master/autoload/unite/filters/matcher_context.vim

import re

from denite.filter.base import Base
from denite.util import split_input, debug


class Filter(Base):
    def __init__(self, vim):
        super().__init__(vim)

        self.vim = vim
        self.name = 'matcher/unite_style'
        self.description = 'unite style matcher'

    def filter(self, context):
        candidates = context['candidates']
        ignorecase = context['ignorecase']

        # debug(self.vim, context)

        if context['input'] == '':
            return candidates

        pattern = context['input']
        if ignorecase:
            pattern = pattern.lower()
            candidates = [x for x in candidates
                          if pattern in x['word'].lower()]
        else:
            candidates = [x for x in candidates if pattern in x['word']]
        return candidates

    def convert_pattern(self, input_str):
        return '|'.join([re.escape(x) for x in split_input(input_str)])
