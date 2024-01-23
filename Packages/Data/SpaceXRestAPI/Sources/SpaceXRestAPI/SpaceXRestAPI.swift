import Foundation
import NetworkService

enum SpaceXRestAPIRouter: Routable {    
    case rockets
    case rocket(id: String)

    var baseUrl: URL? {
        URL(string: "https://api.spacexdata.com/v4")
    }

    var path: String {
        switch self {
        case .rockets: 
            return "rockets"
        case .rocket(let id):
            return "rocket/\(id)"
        }
    }

    var httpMethod: String {
        switch self {
        default:
            HTTPMethod.get.rawValue
        }
    }

    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
}
