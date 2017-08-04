import Vapor

extension Droplet {
    func setupRoutes(drop: Droplet) throws {
        // drop.grouped(RequestMethodLooseMiddleware())
        try resource("products", ProductController(drop:drop))

        let rootController = RootController(drop: drop)
        rootController.addRoutes(drop: drop)
    }
}
