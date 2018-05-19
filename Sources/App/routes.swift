import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    try router.register(collection: BackEndRoutes())
    try router.register(collection: FrontEndRoutes())
}
