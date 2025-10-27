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

load("@bazel_skylib//rules:diff_test.bzl", "diff_test")
load("@stardoc//stardoc:stardoc.bzl", "stardoc")

stardoc(
    name = "def",
    out = "def.gen.md",
    input = "//:def.bzl",
    deps = [
        "//:def",
        # FIXME: Remove the following dependencies once
        # https://github.com/bazel-contrib/rules_go/issues/4394,
        # https://github.com/bazelbuild/stardoc/issues/300, and
        # https://github.com/bazelbuild/rules_cc/issues/279 are fixed.
        "@rules_cc//cc:find_cc_toolchain_bzl",
        "@rules_cc//cc:core_rules",
    ],
)

diff_test(
    name = "def_test",
    timeout = "short",
    failure_message = "Run “bazel build //docs:def.gen.md” and copy the output to //docs:def.md.",
    file1 = "def.md",
    file2 = "def.gen.md",
)
