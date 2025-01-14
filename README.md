<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# The `license_test` Bazel repository

This repository contains a [Bazel rule](https://bazel.build/extending/rules)
`license_test` that verifies that all source files in your repository have a
license header.  It makes use of the
[`addlicense`](https://github.com/google/addlicense) program.  To use it, add a
dependency like this to your [MODULE.bazel
file](https://bazel.build/external/overview#bzlmod):

```starlark
bazel_dep(name = "phst_license_test", version = "0", dev_dependency = True)
git_override(
    module_name = "phst_license_test",
    commit = "1fcefa2b1fcc52117d57ee1c432e3b57b2f83f29",
    remote = "https://github.com/phst/license_test.git",
)
```

Replace the commit hash with an actual hash of a recent commit of the
repository.

Then you can use the [`license_test`](#license_test) rule described below.

This approach is inspired by
[`buildifier_test`](https://github.com/bazelbuild/buildtools/blob/main/buildifier/buildifier.bzl)
with `no_sandbox`.

<a id="license_test"></a>

## license_test

<pre>
load("@phst_license_test//:def.bzl", "license_test")

license_test(*, <a href="#license_test-name">name</a>, <a href="#license_test-marker">marker</a>, <a href="#license_test-ignore">ignore</a>, <a href="#license_test-kwargs">**kwargs</a>)
</pre>

Verifies that all files in the repository have a license header.

The repository is determined by a [marker file](#license_test-marker).  The
test runs unsandboxed to have access to all repository files without
requiring the [`glob`
function](https://bazel.build/reference/be/functions#glob).


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="license_test-name"></a>name |  A unique name for this rule.   |  none |
| <a id="license_test-marker"></a>marker |  One of the [repository boundary marker files](https://bazel.build/concepts/build-ref#repositories). `license_test` needs the location of this file to find the actual repository root.   |  none |
| <a id="license_test-ignore"></a>ignore |  File name patterns to ignore.  The patterns are passed to the `-ignore` flag of the `addlicense` program and therefore use [doublestar syntax](https://github.com/bmatcuk/doublestar#patterns).   |  `None` |
| <a id="license_test-kwargs"></a>kwargs |  Common attributes; see [Attributes common to all build rules](https://bazel.build/reference/be/common-definitions#common-attributes) and [Attributes common to all test rules](https://bazel.build/reference/be/common-definitions#common-attributes-tests).   |  none |


