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
         test_extension: 'c',
         template: <<c
describe ("{{ test_template_group_description }}") {
  it ("{{ test_template_sample_description }}") {
    should_bool(true) be equal to(true);
  } end
} end
c
     }}
  end
end
