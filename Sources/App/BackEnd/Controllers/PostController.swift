import Foundation
import Vapor

final class PostController {
    var postSourceDir: URL {
        get {
            let directoryConfig = DirectoryConfig.detect()
            return URL(fileURLWithPath: "\(directoryConfig.workDir)Public/post-sources")
        }
    }

    var postSourceFiles: [URL] {
        get {
            let fm = FileManager()
            guard let files = try? fm.contentsOfDirectory(at: postSourceDir, includingPropertiesForKeys: nil) else {
                return []
            }
            return files
        }
    }

    func index(_ req: Request) throws -> Future<[Post]> {
        let visibleFiles = postSourceFiles.filter { !$0.lastPathComponent.hasPrefix(".") }
        var posts: [Post] = []

        for file in visibleFiles {
            let contents = try String(contentsOf: file)
            var post = try Post.parseRawContents(of: contents)
            post.slug = file.lastPathComponent.replacingOccurrences(of: ".md", with: "")
            posts.append(post)
        }

        return Future.map(on: req) { posts }
    }

    func show(_ req: Request) throws -> Future<Post> {
        let postName = try req.parameters.next(String.self)
        let targetFile = postSourceFiles.filter { $0.lastPathComponent == "\(postName).md" }.first

        if let targetFile = targetFile {
            let contents = try String(contentsOf: targetFile)
            let post = try Post.parseRawContents(of: contents)
            return Future.map(on: req) { post }
        } else {
            throw Abort(.internalServerError)
        }
    }
}
