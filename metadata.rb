name 'optoro_skel'
maintainer 'Optoro'
maintainer_email 'devops@optoro.com'
license 'MIT'
description 'This is a skeleton'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.23'

supports 'ubuntu', '= 14.04'

provides 'optoro_skel::default'

recipe 'optoro_skel::default', 'This is the default recipe for optoro_skel'
