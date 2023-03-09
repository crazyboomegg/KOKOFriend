
import Foundation
public struct API {
    var domain: String
    var path: String
    var method: RequestMethod
    var header:HeaderType
    
    init(domain: String = APIConstant.Domain.developer, path: String, method: RequestMethod = .post,headerType:HeaderType = .xWwwUrlEncode) {
        self.domain = domain
        self.path = path
        self.method = method
        self.header = headerType
    }
}

extension API {
    static let userInfo      = API(path: "/man.json", method: .get)//
    static let friendOne     = API(path: "/friend1.json", method: .get)
    static let friendTwo     = API(path: "/friend2.json", method: .get)
    static let friendInvite  = API(path: "/friend3.json", method: .get)
    static let noInvite      = API(path: "/friend4.json", method: .get)
    
}
