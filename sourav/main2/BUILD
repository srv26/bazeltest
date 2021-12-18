load("@rules_cc//cc:defs.bzl","cc_binary","cc_library")
load(":my.bzl","myrule")
cc_library(
    name = "test_lib",
    srcs = ["source/test.cpp"],
    hdrs = ["header/include/test.h"],
	strip_include_prefix = "header/include",
	deps = select({
        "@platforms//os:linux":[],
    }),
	target_compatible_with = ["@platforms//os:linux"],
) 
cc_binary(
    name = "test",
    srcs = ["source/test.cpp"],
	deps = [":test_lib"],
) 

cc_test(
  name = "hello_test",
  srcs = ["test_test.cpp"],
  deps = ["@com_google_googletest//:gtest_main",
		":test_lib"],
)

platform(
    name = "linux_x86",
    constraint_values = [
        "@platforms//os:windows",
		"@platforms//cpu:x86_64",
    ],
)
myrule(
	name = "test4",
	text = "helloWorld",
	)

