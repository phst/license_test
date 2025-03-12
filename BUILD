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

load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load(":def.bzl", "license_test")

# This rule also serves as an example.  The “ignore” and “tags” attributes are
# not useful in this case, they only serve as illustration.
license_test(
    name = "license_test",
    timeout = "short",
    ignore = ["**/go.sum"],
    marker = "MODULE.bazel",
    tags = ["my-tag"],
)

bzl_library(
    name = "def",
    srcs = ["def.bzl"],
    visibility = ["//visibility:public"],
    deps = ["//private:def"],
)

exports_files(
    ["def.bzl"],
    visibility = ["//visibility:public"],
)

exports_files(
    ["WORKSPACE"],
    visibility = ["//dev:__pkg__"],
)
