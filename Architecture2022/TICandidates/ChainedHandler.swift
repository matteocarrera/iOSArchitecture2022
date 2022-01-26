protocol ChainedHandler {
    associatedtype EventType

    func process(_ event: EventType) async -> Bool
}

extension ChainedHandler {
    func asAnyChainedHandler() -> AnyChainedHandler<EventType> {
        .init(handler: self)
    }
}
