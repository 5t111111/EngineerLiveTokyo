import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    let postController = PostController()
    router.get("posts", String.parameter, use: postController.show)
}
