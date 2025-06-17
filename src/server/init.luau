--[=[
    server/init.luau
    (no client version)

    To require modules under the `packages` folder use the `@packages` or `@pkg` prefix inside `require()`
    Do the same for modules under `server` too (@server/...)!
    ```
        local examplePackage = require("@packages/example")
    ```
]=]

local examplePackage = require("@packages/example")

print("Hello world, from server!")
examplePackage()
