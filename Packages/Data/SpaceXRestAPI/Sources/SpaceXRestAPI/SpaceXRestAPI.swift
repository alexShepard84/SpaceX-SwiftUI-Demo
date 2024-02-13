import Foundation
import NetworkService

enum SpaceXRestAPIRouter: Routable {    
    case rockets
    case rocket(id: String)
    case launchesQuery(QueryFilter?, QueryOptions?)

    var baseUrl: URL? {
        URL(string: "https://api.spacexdata.com/v4")
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
            return QueryBody(query: queryFilter, options: queryOptions)
        default:
            return nil
        }
    }
}


// MARK: - Query Helper
/// Encapsulates the body of a query request.
struct QueryBody: Encodable {
    let query: QueryFilter?
    let options: QueryOptions?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        let queryData = try JSONSerialization.data(withJSONObject: query ?? [])
        try container.encode(queryData, forKey: .query)

        if let options = options {
            try container.encode(options, forKey: .options)
        }
    }

    enum CodingKeys: String, CodingKey {
        case query, options
    }
}

struct QueryOptions: Encodable {
    let page: Int
    let limit: Int
    let sort: [String: String]?
}

typealias QueryFilter = [String: Any]
