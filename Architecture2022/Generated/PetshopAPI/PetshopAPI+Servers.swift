import TINetworking

public extension Server {
    static var `default`: Server {
        .init(baseUrl: "https://petshop-mock.dev.touchin.ru")
    }
}