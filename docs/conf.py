from recommonmark.parser import CommonMarkParser

source_parsers = {
    '.md': CommonMarkParser,
}

latex_elements = {
  'extraclassoptions': 'openany,oneside'
}

source_suffix = ['.rst', '.md']

master_doc = 'index'
project = u'yocto-docker-build-guide'
