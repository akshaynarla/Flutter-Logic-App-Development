## Golang tour (A Tour of Go)

In this repository, learnings from tour of go is documented. Functionality of each feature/concept is commented/documented on the individual go files. 

### Setting up Golang in local workspace

- Install Go extension in VS Code
- Also download and install the Golang binary from the official [website](https://go.dev/dl/)
- To run Go from VS Code, it is necessary to initialize the go module. This can be done by running `go mod init [PACKAGE_NAME]` within a folder or wherever you want to run the go module. This creates go.mod in the package.
- To setup a workspace like this repository, it is necessary to configure a work package like this `go work use ./[PACKAGE_NAME]`. This will create a go.work file with necessary modules for the workspace.
- To run your go file, run `go run [FILE_NAME].go` from terminal.

### Learnings

- Understand golang syntax and basic packages.
- Meaningful comments provided within each file.
- Understand various concepts of golang like slices, maps, ranges, interfaces, concurrency using goroutines, channels etc.
- Tried experimenting on the code to understand concepts.

## References

This project is a starting point for Golang learning.

- [A Tour of Go](https://go.dev/tour/list)
- [Effective Go](https://go.dev/doc/effective_go)

For help getting started with Golang development, view the [online documentation](https://go.dev/doc/), which offers tutorials samples and a full package documentation.
- [Useful Github Repo for Golang exercises](https://github.com/benoitvallon/a-tour-of-go)