import Foundation

struct TokenResponse: Decodable {
    let accessToken: Token
    let refreshToken: Token
}
