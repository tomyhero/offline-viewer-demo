import Vapor
import HTTP

final class ProductController: ResourceRepresentable {

    let drop: Droplet 
    init(drop: Droplet) {
        self.drop = drop
    }

    func makeResource() -> Resource<Product> {
        return Resource(
            index: index,
            create:create,
            store: store,
            edit: edit,
            update: update,
            destroy: delete
        )
    }


    // GET /products/
    func index(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("index called")
      var nodes = [Node]()
      for product in try Product.all() {
        nodes.append(try product.makeNode(in:nil))
      }

      return try drop.view.make("product/index.leaf",[ "products": nodes ] )
    }

    // GET /products/create
    func create(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("create called")
      return try drop.view.make("product/create.leaf")
    }

    // POST /products/
    func store(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("store called")

      // TODO Better Validation
      guard let name = req.data["name"]?.string else { 
        drop.log.info("missing name")
        throw Abort(.badRequest)
      }
      guard let content = req.data["content"]?.string else { 
        drop.log.info("missing content")
        throw Abort(.badRequest)
      }
      guard let imageURL = req.data["image_url"]?.string else { 
        drop.log.info("missing content")
        throw Abort(.badRequest)
      }

      let product = Product(name: name,content: content, imageURL: imageURL )
      try product.save();

      return Response(redirect: "/products/")
    }

    // GET /products/:id/edit
    func edit (req: Request,product: Product) throws -> ResponseRepresentable {
      drop.log.info("edit called")

      return try drop.view.make("product/edit.leaf", ["product": product.makeNode(in:nil)])
    }

    // PATCH /products/:id/
    func update (req: Request,product: Product) throws -> ResponseRepresentable {
      drop.log.info("update called")

      try product.update(for: req)
      try product.save()

      return Response(redirect: "/products/")
    }

    /// DELETE /products/:id
    func delete( req: Request, product: Product) throws -> ResponseRepresentable {
      try product.delete()
      return Response(redirect: "/products/")
    }

}
