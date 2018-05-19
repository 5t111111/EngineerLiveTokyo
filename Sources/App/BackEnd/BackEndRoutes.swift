import Vapor

class BackEndRoutes: RouteCollection {
    func boot(router: Router) throws {
        router.group("api") { group in
            let postController = PostController()
            group.get("posts", use: postController.index)
            group.get("posts", String.parameter, use: postController.show)
        }
    }
}
