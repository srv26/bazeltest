load("@rules_cc//cc:defs.bzl","cc_binary","cc_library")

def myccbinary(myname, mysrcs, mydeps):
    cc_binary(
        name = myname,
        srcs =mysrcs,
        deps =mydeps,
    )

def _impl(ctx):
    myfile = ctx.actions.declare_file('file.txt')
    ctx.actions.write(
		content=ctx.attr.text,
		output=myfile
	)



myrule = rule(
	implementation = _impl,
	attrs={
	   "text":attr.string(mandatory=True),
	}
	)