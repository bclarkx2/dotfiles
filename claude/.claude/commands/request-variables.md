Update an endpoint to use request variables.

Look for the endpoint served by the endpoint handler named: $ARGUMENTS

Update this endpoint so that it performs exactly the same as it did before, but
now uses request variables from the
github.com/nicheinc/service/middleware/variable package to extract values from
the request.

Here are some rules to follow to migrate the endpoint to use request variables:

1. Import the variable package: Add
   `"github.com/nicheinc/service/middleware/variable"` to imports
2. Change handler signature: Convert from `func(r *http.Request) (int, any)` to
   `func(c *service.HandlerConfig) service.Handler`
3. Define variables at handler config level: Extract parameters using the
   appropriate variable functions at the config level:
   - Query parameters: `variable.QueryUUIDs()`, `variable.QueryStrings()`, `variable.QueryString()`, `variable.QueryBool()`, `variable.QueryBoolOrDefault()`, `variable.QueryInts()`, `variable.QueryUUID()`, `variable.QueryIntOrDefault()`
   - Path parameters: `variable.PathString()`, `variable.PathUUID()`
   - JSON request body: `variable.JSONRequestBody[T](c)` for typed JSON body extraction
   - Use validation options with variables: Int-related variables support validation options like `variable.QueryInts(c, "param", variable.QueryIntsOpts.ValidateMin(minValue))` and `variable.QueryIntOrDefault(c, "param", defaultValue, variable.QueryIntOrDefaultOpts.ValidateMin(minValue))`
4. Move middleware to handler config: Use `c.AppendMiddleware()` to add
   validation middleware instead of adding them to the route registration.
   Do NOT include middleware that extracts or limits parameters since variables handle this:
   - Remove `middleware.ExtractQueryUUIDs()`, `middleware.ExtractPathUUIDs()`, etc.
   - Remove `middleware.ExtractQueryBools()` when using `variable.QueryBool()`
   - Remove `middleware.ExtractQueryInts()` when using `variable.QueryInts()` or `variable.QueryIntOrDefault()`
   - Remove `middleware.LimitQueryParams()` for parameters using singular variables like `variable.QueryString()`
   - Remove `middleware.ValidateMinQueryInts()` when using `variable.QueryIntOrDefault()` with validation options
   - Remove `middleware.UnmarshalJSONBody[T]()` when using `variable.JSONRequestBody[T]()`
   - Remove `middleware.RequireContentType("application/json")` as variables handle content type validation
   - KEEP validation middleware like `middleware.RequireOneQueryParam()`, `middleware.IncompatibleQueryParams()`,
     and `middleware.DependentQueryParam()` by moving them to `c.AppendMiddleware()`
5. Return a handler function: The new handler should return a function with
   signature `func(r *http.Request) (int, any)`
6. Access variables inside handler: Call `.Get()` method on variables to
   retrieve their values within the returned handler function
7. Remove middleware from route registration: Clean up the route registration to
   only call the handler function, removing all middleware parameters including
   `service.NoConfig()` wrapper
8. Update tests for new error formats: Validation errors now use
   `service.ErrorResponseFromValidationFailures()` instead of middleware-specific error types:
   - Path validation errors: `validation.Path("paramName").From(validation.InvalidConversion[T]("value").WithError(err))`
   - JSON body validation errors: `validation.NewBody().FromError(err)`
   - Query parameter UUID errors: `validation.Query("paramName").InList(0).From(validation.InvalidConversion[uuid.UUID]("value").WithError(err))`
   - Query parameter bool errors: `validation.Query("paramName").InList(0).From(validation.InvalidConversion[bool]("value").WithError(variable.ErrInvalidBoolValue))`
   - Query parameter int errors: `validation.Query("paramName").InList(0).From(validation.InvalidConversion[int]("value").WithError(err))`
   - Query parameter minimum validation errors: `validation.Query("paramName").From(validation.TooSmall(value).LessThan(min))` for single values, or `validation.Query("paramName").InList(0).From(validation.TooSmall(value).LessThan(min))` for list parameters
   - Too many query parameter values: `validation.Query("paramName").From(validation.TooManyItems([]T{...}).MoreThan(maxCount))`
   - Add `"github.com/nicheinc/service/middleware/variable"` import to test files when using `variable.ErrInvalidBoolValue`
   - Add `"strconv"` import to test files when creating int conversion errors with `strconv.Atoi()`
   - Add `"github.com/google/uuid"` import and initialize error variables like `_, invalidUUIDErr := uuid.Parse("invalid")` for UUID validation test errors
9. Preserve existing business logic: The core request processing logic should
   remain unchanged - only the parameter extraction mechanism changes
10. Handle pointer values appropriately: Some variables may return pointers
    (like `*string`) that need to be dereferenced when used. Use helper functions
    like `ptr()` to convert values to pointers when needed (e.g., `ptr(offset.Get())`)
11. Don't produce lines of Go code longer than 100 characters: Ensure
    that all lines in the code do not exceed 100 characters for readability

After migrating the endpoint, run the unit tests in the package to ensure
everything works as expected. Also run `go run mvdan.cc/gofumpt@latest -l -w .`
to format any changed code.
