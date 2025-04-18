// Copyright 2025 Philipp Stephani
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// See
// https://go.dev/wiki/Modules#how-can-i-track-tool-dependencies-for-a-module
// and
// https://github.com/go-modules-by-example/index/blob/master/010_tools/README.md.

// FIXME: Delete this file once
// https://github.com/bazel-contrib/bazel-gazelle/issues/2031 is fixed.

//go:build tools

package tools

import _ "github.com/google/addlicense"
