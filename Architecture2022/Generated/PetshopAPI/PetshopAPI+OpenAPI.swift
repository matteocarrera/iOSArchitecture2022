import TINetworking

public extension OpenAPI {
    enum SecurityNames: String, Hashable {
        case AccessTokenAuth
    }

    static var PetshopAPI: Self {
        .init(defaultServer: .default, security: [
            "AccessTokenAuth": .apiKey(.header, parameterName: "X-Bearer-Token")
        ])
    }
}