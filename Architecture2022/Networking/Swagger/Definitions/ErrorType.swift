enum ErrorType: String, Codable {

    // 400
    case incorrectLoginAndPasswordGiven = "Incorrect login and password given"
    case wrongPassword = "Wrong password"
    case cannotIdentifyUserByLogin = "Cannot identify user by login"
    case incorrectRefreshTokenGiven = "Incorrect refresh token given"
    case incorrectJwtTokenGiven = "Incorrect jwt token given"
    case inccorectPhoneNumber = "Incorrect phone given"
    case incorrectUserDataGiven = "Incorrect user data given"
    case badRequest = "Bad request"
    case passwordIsNotValid = "Password is not valid"
    case incorrectPhoneAndPasswordGiven = "Incorrect phone and password given"
    case incorrectEmailAndSmsCodeGiven = "Incorrect email and sms code given"
    case cannotIdentifyUser = "Cannot identify user"
    case wrongSecurityCode = "Wrong security code"
    case wrongRefreshToken = "Wrong refresh token"
    case userCityNotFound = "User city not found"
    case userEmailAlreadyInUse = "User email already in use"
    case incorrectPhoneAndSmsCodeGiven = "Incorrect phone and sms code given"
    case busyEmailAddress = "busy_email_address"
    case busyPhoneNumber = "busy_phone_number"

    // 401
    case invalidJwtToken = "Invalid JWT Token"

    // 403
    case userAlreadyExists = "User already exists"
    case userRateLimitQuotaExceeded = "User rate limit quota exceeded"
    case methodAllowedOnlyForAnonymousUser = "Method allowed only for anonymous user"
    case globalRateLimitQuotaExceeded = "Global rate limit quota exceeded"
    case sessionNotRenewable = "Session not renewable"
    case wrongSecurityParams = "Wrong security params"
    case notEnoughAccessRights = "Not enough access rights"
    case userAlreadyFilled = "User already filled"

    // 404
    case userNotFound = "User not found"
    case sessionNotFound = "Session not found"

    // 500
    case internalError = "Internal error"

    // 503
    case cannotSendCode = "Cannot send code"

    // Unknown
    case unknown = "Unknown error"

    init(_ rawValue: String, `default`: ErrorType = .unknown) {
        self = ErrorType(rawValue: rawValue) ?? `default`
    }
}
