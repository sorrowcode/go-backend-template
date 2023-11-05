package version

import (
	"fmt"
	"os"
	"path/filepath"
)

var defaultValue string = "unknown"

var buildVersion string = defaultValue
var buildCommit string = defaultValue
var buildTimestamp string = defaultValue

func GetVersionString() string {
	app := defaultValue
	executable, err := os.Executable()
	if err == nil {
		app = filepath.Base(executable)
	}
	return fmt.Sprintf("%s on %s (%s) built %s", app, buildVersion, buildCommit, buildTimestamp)
}
