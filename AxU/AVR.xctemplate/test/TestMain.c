#include "unity.h"

void test_Test1(void) {
	TEST_FAIL();
}

int main(int argc, char **argv) {
	
	UNITY_BEGIN();
	
	RUN_TEST(test_Test1);
	
    return UNITY_END();
}
