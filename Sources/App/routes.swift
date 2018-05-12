import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let homeController = HomeController()
    router.get(use: homeController.index)

    router.group("posts") { group in
        let postController = PostController()
        group.get(use: postController.index)
        group.get(String.parameter, use: postController.show)
    }
}
