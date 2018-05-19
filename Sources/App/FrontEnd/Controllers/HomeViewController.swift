import Vapor

final class HomeViewController {
    func index(_ req: Request) throws -> Future<View> {
        return try req.view().render("index")
    }
}
