import Foundation
import Vapor
import Markdown

enum PostError: Error {
    case invalidFrontMatter
    case invalidDate
    case invalidTitle
}

struct Post: Content {
    let title: String
    let date: String
    let body: String
    var slug: String?

    init(title: String, date: String, body: String) {
        self.title = title
        self.date = date
        self.body = body
    }

    static func parseRawContents(of rawContents: String) throws -> Post {
        let pattern = "(?s)(?<=---\n).*?(?=\n---)"
        guard let range = rawContents.range(of: pattern, options: .regularExpression) else {
            throw PostError.invalidFrontMatter
        }
        let frontMatter = String(rawContents[range])

        let datePattern = "date: (.+)"
        guard let dateRange = frontMatter.range(of: datePattern, options: .regularExpression) else {
            throw PostError.invalidDate
        }
        let dateString = String(frontMatter[dateRange])

        let titlePattern = "title: (.+)"
        guard let titleRange = frontMatter.range(of: titlePattern, options: .regularExpression) else {
            throw PostError.invalidTitle
        }
        let titleString = String(frontMatter[titleRange])

        let bodyMarkdown = rawContents.replacingOccurrences(of: "---\n" + frontMatter + "\n---", with: "")
        let bodyHTML = try convertToHTML(from: bodyMarkdown)

        let post = Post(
            title: String(titleString[titleString.index(titleString.startIndex, offsetBy: "title: ".count)...]),
            date: String(dateString[dateString.index(dateString.startIndex, offsetBy: "date: ".count)...]),
            body: bodyHTML
        )

        return post
    }

    static func convertToHTML(from source: String) throws -> String {
        // fix the line breaks
        let trimmed = source.replacingOccurrences(of: "\r\n", with: "\n")
        // parse the Markdown string
        let md = try Markdown(string: trimmed)
        // convert it to HTML
        let doc = try md.document()

        return doc
    }
}
