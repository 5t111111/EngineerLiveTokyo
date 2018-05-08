import Vapor

final class PostController {
    let baseUrl = "http://localhost:8080"

    func show(_ req: Request) throws -> Future<View> {
        let postName = try req.parameters.next(String.self)
        if let url = URL(string: "\(baseUrl)/post-sources/\(postName).md") {
            do {
                let contents = try String(contentsOf: url)
                let data = ["contents": contents]
                return try req.view().render("posts/show", data)
            } catch {
                throw Abort(.unprocessableEntity)
            }
        } else {
            throw Abort(.unprocessableEntity)
        }
    }
}
