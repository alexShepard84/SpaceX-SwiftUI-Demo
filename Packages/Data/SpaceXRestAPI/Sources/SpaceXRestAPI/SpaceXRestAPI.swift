import Foundation
import NetworkService

enum SpaceXRestAPIRouter: Routable {    
    case rockets
    case rocket(id: String)
    case launchesByRocket(id: String, page: Int, limit: Int)

    var baseUrl: URL? {
        URL(string: "https://api.spacexdata.com/v4")
    }

    var path: String {
        switch self {
        case .rockets: 
            return "rockets"
        case .rocket(let id):
            return "rocket/\(id)"
        case .launchesByRocket:
            return "launches/query"
        }
    }

    var httpMethod: String {
        switch self {
        case .launchesByRocket:
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
        case .launchesByRocket(let rocketId, let page, let limit):
            return LaunchesByRocketBody(
                rocket: rocketId,
                options: QueryOptions(page: page, limit: limit)
            )
        default:
            return nil
        }
    }
}


// MARK: - Helper Structs
struct LaunchesByRocketBody: Encodable {
    let query: [String: String]
    let options: QueryOptions

    init(rocket: String, options: QueryOptions) {
        self.query = ["rocket": rocket]
        self.options = options
    }
}

struct QueryOptions: Encodable {
    let page: Int
    let limit: Int
}
