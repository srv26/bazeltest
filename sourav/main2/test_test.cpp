#include <gtest/gtest.h>
#include"test.h"

// Demonstrate some basic assertions.
TEST(Testtest, testthetest) {
	// Expect two strings not to be equal.
	int x = print();
	EXPECT_EQ(x, 1);
}
