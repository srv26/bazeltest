# //depsets/foo.bzl

# A provider with one field, transitive_sources.
FooFiles = provider(fields = ["transitive_sources1"])

def get_transitive_srcs(srcs, deps):
  """Obtain the source files for a target and its transitive dependencies.

  Args:
    srcs: a list of source files
    deps: a list of targets that are direct dependencies
  Returns:
    a collection of the transitive sources
  """
  return depset(
        srcs,
        transitive = [dep[FooFiles].transitive_sources1 for dep in deps])

def _foo_library_impl(ctx):
  trans_srcs = get_transitive_srcs(ctx.files.srcs, ctx.attr.deps)
  #print("*******")
  #print([FooFiles(transitive_sources1=trans_srcs)])
  #print("*******")
  return [FooFiles(transitive_sources1=trans_srcs)]

foo_library = rule(
    implementation = _foo_library_impl,
    attrs = {
        "srcs": attr.label_list(allow_files=True),
        "deps": attr.label_list(),
    },
	#provides =[FooFiles],
)

def _foo_binary_impl(ctx):
  foocc = ctx.executable._foocc
  #print(foocc)
  out = ctx.outputs.out1
  trans_srcs = get_transitive_srcs(ctx.files.srcs, ctx.attr.deps)
  srcs_list = trans_srcs.to_list()
  print("*************")
  print(srcs_list)
  print("*************")
  ctx.actions.run(executable = foocc,
                  arguments = [out.path], #+ [src.path for src in srcs_list],
                  inputs = [],
                  outputs = [out])
  #return [FooFiles(transitive_sources1=trans_srcs)]

foo_binary = rule(
    implementation = _foo_binary_impl,
    attrs = {
        "srcs": attr.label_list(allow_files=True),
        "deps": attr.label_list(),
        "_foocc": attr.label(default=Label("//depsets:foocc"),
                             allow_files=True, executable=True, cfg="host")
    },
    outputs = {"out1": "%{name}.out"},
)