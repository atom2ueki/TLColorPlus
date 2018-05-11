Pod::Spec.new do |s|

  s.name = 'TLColorPlus'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'easy to use UIColor for fill with hex & generate gradient background color'
  s.description = <<-DESCRIPTION
                  easy to use UIColor for fill with hex & generate gradient background color
                  DESCRIPTION

  s.homepage = 'https://bitbucket.org/sphitd/TLColorPlus'
  s.author = { 'Tony Li' => 'atom2ueki@gmail.com' }
  s.social_media_url = 'https://github.com/atom2ueki/TLColorPlus/'

  s.source = {
    :git => 'https://github.com/atom2ueki/TLColorPlus.git',
    :tag => '1.0.0'
  }

  s.ios.deployment_target  = '9.0'
  s.osx.deployment_target  = '9.0'

  s.source_files = 'Sources/**/*'

end