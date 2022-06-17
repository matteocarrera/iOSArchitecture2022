extension String {

    // 400
    static let incorrectLoginAndPasswordGiven = "Incorrect login and password given"
    static let wrongPassword = "Wrong password"
    static let cannotIdentifyUserByLogin = "Cannot identify user by login"
    static let incorrectRefreshTokenGiven = "Incorrect refresh token given"
    static let incorrectJwtTokenGiven = "Incorrect jwt token given"
    static let inccorectPhoneNumber = "Incorrect phone given"
    static let incorrectUserDataGiven = "Incorrect user data given"
    static let badRequest = "Bad request"
    static let passwordIsNotValid = "Password is not valid"
    static let incorrectPhoneAndPasswordGiven = "Incorrect phone and password given"
    static let incorrectEmailAndSmsCodeGiven = "Incorrect email and sms code given"
    static let cannotIdentifyUser = "Cannot identify user"
    static let wrongSecurityCode = "Wrong security code"
    static let wrongRefreshToken = "Wrong refresh token"
    static let userCityNotFound = "User city not found"
    static let userEmailAlreadyInUse = "User email already in use"
    static let incorrectPhoneAndSmsCodeGiven = "Incorrect phone and sms code given"
    static let busyEmailAddress = "busy_email_address"
    static let busyPhoneNumber = "busy_phone_number"

    // 401
    static let invalidJwtToken = "invalid_jwt_token"

    // 403
    static let userAlreadyExists = "User already exists"
    static let userRateLimitQuotaExceeded = "User rate limit quota exceeded"
    static let methodAllowedOnlyForAnonymousUser = "Method allowed only for anonymous user"
    static let globalRateLimitQuotaExceeded = "Global rate limit quota exceeded"
    static let sessionNotRenewable = "Session not renewable"
    static let wrongSecurityParams = "Wrong security params"
    static let notEnoughAccessRights = "Not enough access rights"
    static let userAlreadyFilled = "User already filled"

    // 404
    static let userNotFound = "User not found"
    static let sessionNotFound = "Session not found"

    // 500
    static let internalError = "Internal error"

    // 503
    static let cannotSendCode = "Cannot send code"

    // Unknown
    static let unknown = "Unknown error"
}
