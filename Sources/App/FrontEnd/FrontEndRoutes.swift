import Vapor

class FrontEndRoutes: RouteCollection {
    func boot(router: Router) throws {
        let homeViewController = HomeViewController()
        router.get(use: homeViewController.index)

        let postViewController = PostViewController()
        router.get("posts", use: postViewController.index)
        router.get("posts", String.parameter, use: postViewController.show)
    }
}
