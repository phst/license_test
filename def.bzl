# Copyright 2025 Philipp Stephani
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# The docstring below gets copied into README.md, so it describes this
# repository rather than this file.

"""# The `license_test` Bazel repository

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
    tag = "0.0.1",
    remote = "https://github.com/phst/license_test.git",
)
```

Replace the tag with a recent tag of the repository.

Then you can use the [`license_test`](#license_test) rule described below.

This approach is inspired by
[`buildifier_test`](https://github.com/bazelbuild/buildtools/blob/main/buildifier/buildifier.bzl)
with `no_sandbox`.
"""

load(":private.bzl", _license_test = "license_test")

visibility("public")

# Implementation note: We have to use a wrapper macro to modify the tags.  It's
# not possible to do so in a rule, and we also can't pass the "external"
# constraint as an execution requirement using testing.ExecutionInfo.  See the
# logic in the Bazel class com.google.devtools.build.lib.packages.TargetUtils,
# especially the methods getExecutionInfo and isExternalTestRule.

def license_test(*, name, marker, ignore = None, **kwargs):
    """Verifies that all files in the repository have a license header.

    The repository is determined by a [marker file](#license_test-marker).  The
    test runs unsandboxed to have access to all repository files without
    requiring the [`glob`
    function](https://bazel.build/reference/be/functions#glob).

    Args:
      name: A unique name for this rule.
      marker: One of the [repository boundary marker
        files](https://bazel.build/concepts/build-ref#repositories).
        `license_test` needs the location of this file to find the actual
        repository root.
      ignore: File name patterns to ignore.  The patterns are passed to
        the `-ignore` flag of the `addlicense` program and therefore use
        [doublestar syntax](https://github.com/bmatcuk/doublestar#patterns).
      **kwargs: Common attributes; see [Attributes common to all build
        rules](https://bazel.build/reference/be/common-definitions#common-attributes)
        and [Attributes common to all test
        rules](https://bazel.build/reference/be/common-definitions#common-attributes-tests).
    """
    _license_test(
        name = name,
        marker = marker,
        ignore = ignore,
        tags = kwargs.pop("tags", []) + [
            # Don't run the test in a sandbox.  It requires access to the
            # source tree.
            "no-sandbox",
            # Don't cache test results.  The files in the repository aren't
            # declared inputs to the test rule, so we have to rerun the test in
            # case any of them has changed.
            "no-cache",
            # See https://github.com/bazelbuild/bazel/issues/15516.
            "external",
        ],
        **kwargs
    )

# Starlark files are Latin-1-encoded.  Specify this explicitly so that we don't
# accidentally add UTF-8 characters, which would get messed up in the Stardoc
# output.

# Local Variables:
# coding: iso-8859-1-unix
# End:
