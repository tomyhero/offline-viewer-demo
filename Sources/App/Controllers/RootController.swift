import Vapor
import HTTP

final class RootController {

    let drop: Droplet 
    init(drop: Droplet) {
        self.drop = drop
    }

    func addRoutes(drop: Droplet) {
      drop.get(handler: index)
      drop.get("products.manifest",handler: manifest)
      drop.get("/api/product_info",handler: productInfo)
    }

    func index(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("index called")
      let info = try Product.getAllNodeInfo()
      return try drop.view.make("root/index.leaf",[ "product_info": info ])
    }

    func productInfo(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("productInfo called")
      let info = try Product.getAllNodeInfo()
      return try JSON(node: info)
    }

    // GET /offline.manifest
    func manifest(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("manifest called")
      let info = try Product.getAllNodeInfo()
      return try drop.view.make("root/manifest.leaf",[ "product_info": info ] )
    }

}
