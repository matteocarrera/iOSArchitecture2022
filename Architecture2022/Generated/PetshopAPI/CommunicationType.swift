
import Foundation
import TIFoundationUtils


/** Тип связи */
public enum CommunicationType: String, Codable, CaseIterable, Equatable {
    case phone = "phone"
    case email = "email"
}