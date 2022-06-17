import TINetworking
import TIMoyaNetworking
import TIFoundationUtils

final class ProjectNetworkService: DefaultRecoverableJsonNetworkService<ErrorResponse> {
    @Weaver(.reference)
    var jsonCodingConfigurator: ProjectJsonCodingConfigurator

    @Weaver(.reference)
    var tokenStorageService: TokenStorageService

    init(injecting resolver: ProjectNetworkServiceDependencyResolver) {
        super.init(session: SessionFactory(timeoutInterval: 60).createSession(),
                   jsonCodingConfigurator: resolver.jsonCodingConfigurator,
                   openApi: .PetshopAPI)

        let accessTokenPreprocessor = DefaultSecuritySchemePreprocessor { [tokenStorageService] in
            tokenStorageService.accessToken?.value
        }

        register(securityPreprocessors: [
            OpenAPI.SecurityNames.AccessTokenAuth: accessTokenPreprocessor,
        ])

        let displayDecodingErrorPlugin = ProjectDisplayDecodingErrorPlugin()

        plugins.append(displayDecodingErrorPlugin)
    }
}
