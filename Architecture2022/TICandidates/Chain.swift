struct Chain<Handler: ChainedHandler>: ChainedHandler {
    let handlers: [Handler]

    func process(_ event: Handler.EventType) async -> Bool {
        for handler in handlers {
            if await handler.process(event) {
                return true
            }
        }

        return false
    }
}
