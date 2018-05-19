import Vapor

class FrontEndRoutes: RouteCollection {
    func boot(router: Router) throws {
        let homeViewController = HomeViewController()
        router.get(use: homeViewController.index)

        let postViewController = PostViewController()
        router.get("posts", use: postViewController.index)
        router.get("posts", String.parameter, use: postViewController.show)
    }

    static func apiEndpoint() -> String {
        return Environment.get("API_ENDPOINT") ?? "http://localhost:8080/api"
    }
}
