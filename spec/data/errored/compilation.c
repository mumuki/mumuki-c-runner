#include <cspecs/cspec.h>

context (mumuki_test) {

    describe ("Mumuki test")

        char _true = 0;

        _true = 0;

        it ("is true") { should_bool(_true) be truthy; } end
    } end
}