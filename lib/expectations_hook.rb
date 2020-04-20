class CExpectationsHook < Mumukit::Templates::MulangExpectationsHook
  include_smells false

  def language
    'C'
  end
end
