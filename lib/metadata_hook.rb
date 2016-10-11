class CMetadataHook < Mumukit::Hook
  def metadata
    {language: {
        name: 'c',
        icon: {type: 'devicon', name: 'c'},
        extension: 'c',
        ace_mode: 'c_cpp'
    },
     test_framework: {
         name: 'cspec',
         test_extension: 'c'
     }}
  end
end
