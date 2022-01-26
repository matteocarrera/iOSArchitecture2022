final class PreviewDependencies {
    
    private let dependencies = MainDependencyContainer.previewDependenciesDependencyResolver()

    @Weaver(.registration)
    var networkService: NetworkService

    @Weaver(.registration)
    var authService: AuthService
}
