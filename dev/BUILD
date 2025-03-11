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

load("@buildifier_prebuilt//:rules.bzl", "buildifier_test")
load("@gazelle//:def.bzl", "DEFAULT_LANGUAGES", "gazelle", "gazelle_binary", "gazelle_test")
load("@rules_go//go:def.bzl", "TOOLS_NOGO", "nogo")

buildifier_test(
    name = "buildifier_test",
    timeout = "short",
    lint_mode = "warn",
    lint_warnings = ["all"],
    no_sandbox = True,
    workspace = "//:WORKSPACE",
)

gazelle(
    name = "gazelle",
    gazelle = ":gazelle_binary",
)

gazelle_test(
    name = "gazelle_test",
    timeout = "short",
    gazelle = ":gazelle_binary",
    workspace = "//:WORKSPACE",
)

gazelle_binary(
    name = "gazelle_binary",
    languages = DEFAULT_LANGUAGES + ["@bazel_skylib_gazelle_plugin//bzl"],
)

nogo(
    name = "nogo",
    visibility = ["//visibility:public"],
    deps = TOOLS_NOGO,
)
