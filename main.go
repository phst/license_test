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

package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/bazelbuild/rules_go/go/runfiles"
)

func main() {
	log.SetFlags(0)
	rf, err := runfiles.New(runfiles.SourceRepo(`[source_repo]`))
	if err != nil {
		log.Fatal(err)
	}
	addlicense, err := rf.Rlocation(`[addlicense]`)
	if err != nil {
		log.Fatal(err)
	}
	marker, err := rf.Rlocation(`[marker]`)
	if err != nil {
		log.Fatal(err)
	}
	marker, err = filepath.EvalSymlinks(marker)
	if err != nil {
		log.Fatal(err)
	}
	root := filepath.Dir(marker)
	cmd := exec.Command(addlicense, `[flags]`, "--", ".")
	cmd.Dir = root
	cmd.Env = append(os.Environ(), rf.Env()...)
	cmd.Stderr = os.Stderr
	if out, err := cmd.Output(); err != nil {
		if len(out) != 0 {
			fmt.Printf("The following files are missing license headers:\n%s", out)
		}
		if err, ok := err.(*exec.ExitError); ok && err.Exited() && !err.Success() {
			os.Exit(err.ExitCode())
		}
		log.Fatal(err)
	}
}
