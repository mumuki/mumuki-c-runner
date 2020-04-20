class CExpectationsHook < Mumukit::Templates::MulangExpectationsHook
  include_smells true

  def language
    'C'
  end

  def default_smell_exceptions
    LOGIC_SMELLS + FUNCTIONAL_SMELLS + OBJECT_ORIENTED_SMELLS + ['HasWrongCaseIdentifiers']
  end

  def parse_response(response)
    super.uniq
  end
end
