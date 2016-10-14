#include <cspecs/cspec.h>

int main(void) {
  return report(JSON);
}

context (mumuki_test) {

    describe ("Mumuki test")

        char foo  = 0;

        foo  = 0;

        it ("is true") { should_bool(foo ) be truthy; } end
    } end
}