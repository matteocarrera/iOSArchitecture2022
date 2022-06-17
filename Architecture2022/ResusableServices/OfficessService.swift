

import Foundation

struct OfficessService {
    @Weaver(.reference)
    private var networkService: ProjectNetworkService

    init(injecting _: OfficessServiceDependencyResolver) {
        //
    }

    func getOfficess(preferCached: Bool = true) async -> ApiResponse<[Office]> {
        guard preferCached,
              let officessPath = Bundle.main.url(forResource: "officess", withExtension: "json"),
              let officessData = try? Data(contentsOf: officessPath),
              let officessResponse = try? JSONDecoder().decode(GraphQLOfficesResponse.self, from: officessData) else {
                  return await queryOfficess()
              }

        return .success(officessResponse.data.websiteOffices)
    }

    private func queryOfficess() async -> ApiResponse<[Office]> {
        let query = "query websiteOffices($filter: WebsiteEntityOfficeFilter, $sort: WebsiteEntityOfficeSort, $multisort: [WebsiteEntityOfficeSort]) { websiteOffices(filter: $filter, sort: $sort, multisort: $multisort) {id type geoLatitude geoLongitude isWorkingSunday isMaxWeight cityCode __typename}}"

        return await networkService.process(recoverableRequest: .graphQLRequest(body: .init(operationName: .websiteOffices,
                                                                                            query: query),
                                                                                server: .pickupPointsServer))
            .map { $0.data.websiteOffices }
            .mapError { $0.map { $0.errorResponse } }
    }
}

import TINetworking

private extension Server {
    static var pickupPointsServer: Server {
        .init(baseUrl: "https://www.cdek.ru")
    }
}
