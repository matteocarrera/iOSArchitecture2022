/// Async closure with custom arguments and return value.
public typealias AsyncClosure<Input, Output> = (Input) async -> Output

/// Async closure with no arguments and custom return value.
public typealias AsyncResultClosure<Output> = () async -> Output

/// Async closure that takes custom arguments and returns Void.
public typealias AsyncParameterClosure<Input> = AsyncClosure<Input, Void>

// MARK: Throwable versions

/// Async closure with custom arguments and return value, may throw an error.
public typealias ThrowableAsyncClosure<Input, Output> = (Input) async throws -> Output

/// Async closure with no arguments and custom return value, may throw an error.
public typealias ThrowableAsyncResultClosure<Output> = () async throws -> Output

/// Async closure that takes custom arguments and returns Void, may throw an error.
public typealias ThrowableAsyncParameterClosure<Input> = ThrowableAsyncClosure<Input, Void>

// MARK: Concrete closures

/// Async closure that takes no arguments and returns Void.
public typealias AsyncVoidClosure = AsyncResultClosure<Void>

/// Async closure that takes no arguments, may throw an error and returns Void.
public typealias ThrowableAsyncVoidClosure = () async throws -> Void
