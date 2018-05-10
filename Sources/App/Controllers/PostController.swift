import Vapor

final class PostController {
    let rootUrl = Environment.get("ROOT_URL") ?? "http://localhost:8080"

    func index(_ req: Request) throws -> Future<View> {
        if let url = URL(string: "\(rootUrl)/post-sources/index.md") {
            do {
                let contents = try String(contentsOf: url)
                let indexPost = try Post.parseRawContents(of: contents)
                let data = [
                    "postTitle": indexPost.title,
                    "updatedDate": indexPost.date,
                    "postBody": indexPost.body
                ]
                return try req.view().render("posts/index", data)
            } catch {
                throw Abort(.unprocessableEntity)
            }
        } else {
            throw Abort(.unprocessableEntity)
        }
    }

    func show(_ req: Request) throws -> Future<View> {
        let postName = try req.parameters.next(String.self)
        if let url = URL(string: "\(rootUrl)/post-sources/\(postName).md") {
            do {
                let contents = try String(contentsOf: url)
                let post = try Post.parseRawContents(of: contents)
                let data = [
                    "postTitle": post.title,
                    "postDate": post.date,
                    "postBody": post.body
                ]
                return try req.view().render("posts/show", data)
            } catch {
                throw Abort(.unprocessableEntity)
            }
        } else {
            throw Abort(.unprocessableEntity)
        }
    }
}
