import Vapor

final class PostViewController {
    func index(_ req: Request) throws -> Future<View> {
        return try req.client().get("\(FrontEndRoutes.apiEndpoint())/posts").flatMap { response in
            let posts = try response.content.syncDecode([Post].self)
            let context = [ "posts": posts ]
            return try req.view().render("posts/index", context)
        }
    }

    func show(_ req: Request) throws -> Future<View> {
        let postName = try req.parameters.next(String.self)

        return try req.client().get("\(FrontEndRoutes.apiEndpoint())/posts/\(postName)").flatMap { response in
            let post = try response.content.syncDecode(Post.self)
            let context = [ "post": post ]
            return try req.view().render("posts/show", context)
        }
    }
}
