import Foundation
import NetworkService

enum SpaceXRestAPIRouter: Routable {    
    case rockets
    case rocket(id: String)
    case launchesQuery(QueryFilter?, PaginationOptionsDTO?)

    var baseUrl: URL? {
        URL(string: "https://api.spacexdata.com")
    }

    var path: String {
        switch self {
        case .rockets: 
            return "rockets"
        case .rocket(let id):
            return "rocket/\(id)"
        case .launchesQuery:
            return "launches/query"
        }
    }

    var apiVersion: String {
        switch self {
        case .launchesQuery:
            return "v5"
        default:
            return "v4"
        }
    }

    var httpMethod: String {
        switch self {
        case .launchesQuery:
            return HTTPMethod.post.rawValue
        default:
            return HTTPMethod.get.rawValue
        }
    }

    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }

    var body: Encodable? {
        switch self {
        case .launchesQuery(let queryFilter, let queryOptions):
            return RequestBody(
                query: queryFilter ?? [:],
                options: queryOptions
            )
        default:
            return nil
        }
    }
}


// MARK: - Query Helper
/// Encapsulates the body of a query request.
struct RequestBody: Encodable {
    let query: QueryFilter
    let options: PaginationOptionsDTO?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(query, forKey: .query)
        try container.encodeIfPresent(options, forKey: .options)
    }

    enum CodingKeys: String, CodingKey {
        case query, options
    }
}

struct PaginationOptionsDTO: Encodable {
    let page: Int
    let limit: Int
    let sort: [String: String]?
}

typealias QueryFilter = [String: Any]
