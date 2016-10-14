class CTestHook < Mumukit::Templates::FileHook
  isolated true
  structured true

  def tempfile_extension
    '.c'
  end

  def command_line(filename)
    "runcspec #{filename}"
  end

  def post_process_file(file, result, status)
    if result.include? '!!TEST FINISHED WITH COMPILATION ERROR!!'
      [result, :errored]
    else
      super
    end
  end

  def compile_file_content(request)
    <<EOF
#include <cspecs/cspec.h>

int main(void) {
  return report(JSON);
}

context (mumuki_test) {

    describe ("Mumuki test") {

        #{request.extra}

        #{request.content}

        #{request.test}

    } end

}
EOF
  end


  def to_structured_result(result)
    result = result.split("===========\nJSON REPORT\n===========").last
    transform(super(result)['examples'])
  end

  def transform(examples)
    examples.map { |e| [e['title'], e['status'].to_sym, e['result']] }
  end
end