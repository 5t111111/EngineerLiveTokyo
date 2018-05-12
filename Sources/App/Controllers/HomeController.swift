import Foundation
import Vapor

final class HomeController {
    func index(_ req: Request) throws -> Future<View> {
        return try req.view().render("index")
    }
}
