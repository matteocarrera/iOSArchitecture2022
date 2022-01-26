struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken: String
    var profile: Profile
}
