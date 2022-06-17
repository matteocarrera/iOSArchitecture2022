import Foundation
import TIAuth

extension SMSSendResponse: CodeRefreshResponse {
    public var remainingAttempts: Int? {
        nil
    }

    public var requiredAdditionalAuth: String? {
        nil
    }

    public var validUntil: Date? {
        Date().addingTimeInterval(TimeInterval(lifetime))
    }

    public var codeId: String? {
        nil
    }

    public var refreshableAfter: Date? {
        nil
    }

    public var confirmationId: String? {
        nil
    }
}
