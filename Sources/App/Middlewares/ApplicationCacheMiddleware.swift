// set .manifest Content Type
final class ApplicationCacheMiddleware: Middleware {
  func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    let arr = request.uri.path.components( separatedBy: ".")
    let response = try next.respond(to: request)

    if  arr.last == "manifest" {
      response.headers["Content-Type"] = "text/cache-manifest"
    }

    return response
  }
}
