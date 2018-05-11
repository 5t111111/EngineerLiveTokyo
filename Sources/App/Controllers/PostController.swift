import Foundation
import Vapor

final class PostController {
    let postSourceDir = URL(fileURLWithPath: "\(DirectoryConfig.detect().workDir)Public/post-sources")

    func index(_ req: Request) throws -> Future<View> {
        let fm = FileManager()

        guard let files = try? fm.contentsOfDirectory(at: postSourceDir, includingPropertiesForKeys: nil) else {
            throw Abort(.internalServerError)
        }

        let visibleFiles = files.filter { !$0.lastPathComponent.hasPrefix(".") }

        var posts: [Post] = []

        for file in visibleFiles {
            let contents = try String(contentsOf: file)
            let post = try Post.parseRawContents(of: contents)
            posts.append(post)
        }

        let context = [
            "posts": posts
        ]
        return try req.view().render("posts/index", context)
    }

    func show(_ req: Request) throws -> Future<View> {
        let postName = try req.parameters.next(String.self)

        let fm = FileManager()

        guard let files = try? fm.contentsOfDirectory(at: postSourceDir, includingPropertiesForKeys: nil) else {
            throw Abort(.internalServerError)
        }

        let targetFile = files.filter { $0.lastPathComponent == "\(postName).md" }.first

        if let targetFile = targetFile {
            let contents = try String(contentsOf: targetFile)
            let post = try Post.parseRawContents(of: contents)

            let context = [
                "post": post
            ]

            return try req.view().render("posts/show", context)
        } else {
            throw Abort(.internalServerError)
        }
    }
}
