from recommonmark.parser import CommonMarkParser

source_parsers = {
    '.md': CommonMarkParser,
}

latex_elements = {
  'extraclassoptions': 'openany,oneside'
}

source_suffix = ['.rst', '.md']

master_doc = 'index'
project = u'Dockerized build environment for yocto based i.MX images'
author = u'Till S. Witt'
