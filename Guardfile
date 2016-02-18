guard :rubocop do
  watch(/.+\.rb/)
  watch(%r{(?:.+/)?.rubocop.yml$}) { |m| File.dirname(m[0]) }
end

guard 'foodcritic', cookbook_paths: '.', :all_on_start => false do
  watch(%r{attributes/.+.rb})
  watch(%r{providers\/.+\.rb})
  watch(%r{recipes/.+.rb})
  watch(%r{resources/.+.rb})
end

guard :bundler do
  watch('Gemfile')
end

guard :rspec, cmd: 'bundle exec rspec --color --require spec_helper', :all_on_start => false do
  watch(%r{^spec/(.+)_spec.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^(recipes)/(.+).rb$}) { 'spec' }
  watch(%r{^(attributes)/(.+).rb$}) { 'spec' }
  watch(%r{^(providers)/(.+).rb$}) { 'spec' }
  watch(%r{^(resources)/(.+).rb$}) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }
end
