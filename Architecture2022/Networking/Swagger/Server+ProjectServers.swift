import TINetworking

public extension Server {

    static var `default`: Server {
//        #if MOCK && DEV
//            return Server(baseUrl: "https://petshop-mock.dev.touchin.ru")
//        #elseif CUSTOMER && STAGE
//            return Server(baseUrl: "https://petshop-mock.stage.touchin.ru")
//        #elseif MOCK && TEST
//            return Server(baseUrl: "https://petshop-mock.dev.touchin.ru")
//        #endif

        return Server(baseUrl: "https://petshop-mock.dev.touchin.ru")
    }
}
