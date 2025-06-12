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

"""Internal definitions."""

load("@rules_go//go:def.bzl", "GoInfo", "go_context", "new_go_info")

visibility("//")

# Implementation note: We move the rule definition into a separate file so that
# the rule kind shows up as "license_test" in bazel query instead of
# "_license_test".

def _license_test_impl(ctx):
    go = go_context(ctx, include_deprecated_properties = False)
    main = go.declare_file(go, ext = ".go")
    go.actions.expand_template(
        template = ctx.file._main,
        output = main,
        substitutions = {
            "`[addlicense]`": _go_string(_rlocation(ctx, ctx.executable._addlicense)),
            "`[flags]`": _go_strings(["-check"] + ["-ignore=" + p for p in ctx.attr.ignore]),
            "`[marker]`": _go_string(_rlocation(ctx, ctx.file.marker)),
            "`[source_repo]`": _go_string(ctx.workspace_name),
        },
    )
    info = new_go_info(
        go,
        struct(
            deps = ctx.attr._deps,
            data = [ctx.attr.marker, ctx.attr._addlicense],
        ),
        generated_srcs = [main],
        is_main = True,
    )
    _, out, runfiles = go.binary(go, ctx.label.name, info)
    runfiles = ctx.attr._addlicense[DefaultInfo].default_runfiles.merge(runfiles)
    return DefaultInfo(executable = out, runfiles = runfiles)

license_test = rule(
    test = True,
    # @unsorted-dict-items
    attrs = {
        "marker": attr.label(
            mandatory = True,
            allow_single_file = ["MODULE.bazel", "REPO.bazel", "WORKSPACE", "WORKSPACE.bazel"],
        ),
        "ignore": attr.string_list(),
        "_main": attr.label(
            allow_single_file = [".go"],
            default = Label("//private:main.go"),
        ),
        "_deps": attr.label_list(
            providers = [GoInfo],
            default = ["@rules_go//go/runfiles"],
        ),
        "_addlicense": attr.label(
            allow_single_file = True,
            executable = True,
            cfg = "exec",
            default = Label("@addlicense"),
        ),
        "_go_context_data": attr.label(
            default = Label("@rules_go//:go_context_data"),
        ),
    },
    toolchains = ["@rules_go//go:toolchain"],
    implementation = _license_test_impl,
)

def _rlocation(ctx, file):
    if file.short_path.startswith("../"):
        return file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _go_string(string):
    # See https://go.dev/ref/spec#String_literals.
    if "`" in string or "\r" in string:
        fail("Cannot pass string %r to Go" % string)
    return "`" + string + "`"

def _go_strings(strings):
    return ", ".join([_go_string(s) for s in strings])
