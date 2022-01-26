struct AnyChainedHandler<EventType>: ChainedHandler {
    private let processClosure: AsyncClosure<EventType, Bool>

    init<Handler: ChainedHandler>(handler: Handler) where Handler.EventType == EventType {
        self.processClosure = handler.process
    }

    func process(_ event: EventType) async -> Bool {
        await processClosure(event)
    }
}
