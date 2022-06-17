import Foundation
import TIAuth

extension TokensResponse: CodeConfirmResponse {
    public var validUntil: Date? {
        nil
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

    public var remainingAttempts: Int? {
        nil
    }

    public var requiredAdditionalAuth: String? {
        nil
    }
}
