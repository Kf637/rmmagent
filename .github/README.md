# Tactical RMM Agent

[GitHub Repository](https://github.com/amidaware/tacticalrmm)

## Building the Agent

To build the agent, use the following command:

```sh
env CGO_ENABLED=0 GOOS=<GOOS> GOARCH=<GOARCH> go build -ldflags "-s -w"
```

## Alternatively

You can also use the automatic compiler. For more details, refer to the [Automatic Compiler](../compile/compile.md) documentation.