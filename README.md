See `shell.nix` for project dependencies.

## Building
```
cmake --preset default -DSLANG_RHI_BUILD_EXAMPLES=ON -DSLANG_RHI_FETCH_SLANG=ON
cmake --build -DSLANG_RHI_DEBUG=1 --preset Release --target example-path-tracer
./build/Release/example-path-tracer
```
