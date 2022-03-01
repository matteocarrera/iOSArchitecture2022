import Foundation
import TIFoundationUtils

enum ProjectDateFormat: String, DateFormat {

    case defaultDate = "MM/dd/yyyy"

    case yyyyMMdd = "yyyy-MM-dd"

    case MMMM = "MMMM"

    case dMMMM = "d MMMM"

    case dMMM = "d MMM"

    func configure(dateFormatter: DateFormatter) {
        dateFormatter.dateFormat = rawValue

        switch self {
        case .dMMM:
            dateFormatter.dateStyle = .medium
        default:
            break
        }
    }
}

final class ProjectDateFormattingService: DateFormattingService {
    @Weaver(.reference)
    var dateFormattersReusePool: DateFormattersReusePool

    init(injecting resolver: ProjectDateFormattingServiceDependencyResolver) {
        super.init(reusePool: resolver.dateFormattersReusePool)
    }
}
