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

load("@aspect_bazel_lib//lib:docs.bzl", "stardoc_with_diff_test", "update_docs")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("@buildifier_prebuilt//:rules.bzl", "buildifier_test")
load("@rules_go//go:def.bzl", "TOOLS_NOGO", "go_binary", "nogo")
load(":def.bzl", "license_test")

license_test(
    name = "license_test",
    timeout = "short",
    ignore = ["**/go.sum"],
    marker = "MODULE.bazel",
    tags = ["my-tag"],
)

go_binary(
    name = "main",
    srcs = ["main.go"],
    deps = ["@rules_go//go/runfiles"],
)

bzl_library(
    name = "def",
    srcs = ["def.bzl"],
    deps = [":private"],
)

bzl_library(
    name = "private",
    srcs = ["private.bzl"],
    deps = [
        "@aspect_bazel_lib//lib:paths",
        "@rules_go//go:def",
        # FIXME: The following dependency shouldn’t be needed.  Bug in Stardoc?
        "@rules_cc//cc:find_cc_toolchain.bzl",
    ],
)

stardoc_with_diff_test(
    name = "README",
    bzl_library_target = ":def",
)

update_docs()

buildifier_test(
    name = "buildifier_test",
    timeout = "short",
    lint_mode = "warn",
    lint_warnings = ["all"],
    no_sandbox = True,
    workspace = "WORKSPACE",
)

nogo(
    name = "nogo",
    visibility = ["//visibility:public"],
    deps = TOOLS_NOGO,
)
