import Vapor
import FluentProvider
import HTTP

final class Product: Model {
    let storage = Storage()
    
    var name: String
    var content: String
    var version: Int
    var imageURL: String
    
    static let idKey = "id"
    static let versionKey = "version"
    static let nameKey = "name"
    static let contentKey = "content"
    static let imageURLKey = "image_url"

    init(name: String, content: String, imageURL: String) {
        self.content = content
        self.name = name
        self.imageURL = imageURL
        self.version = 1
    }

    init(row: Row) throws {
        content = try row.get(Product.contentKey)
        name = try row.get(Product.nameKey)
        version = try row.get(Product.versionKey)
        imageURL = try row.get(Product.imageURLKey)
    }

    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Product.contentKey, content)
        try row.set(Product.nameKey, name)
        try row.set(Product.imageURLKey, imageURL)
        try row.set(Product.versionKey, version + 1)
        return row
    }

    func makeNode(in context: Context?) throws -> Node {
        var node = Node([:])
        try node.set(Product.idKey, id)
        try node.set(Product.nameKey, name)
        try node.set(Product.imageURLKey, imageURL)
        try node.set(Product.contentKey, content)
        try node.set(Product.versionKey, version)
        return node
    }

    static func getAllNodeInfo() throws -> Node {
      var nodes = [Node]()
      var version = 0
      for product in try all() {
        version = version + product.version
        nodes.append(try product.makeNode(in:nil))
      }

      var node = Node([:])
      try node.set("version",version)
      try node.set("items", nodes)
      return node
    }

}

extension Product: Preparation {

  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.string(Product.contentKey)
      builder.string(Product.nameKey)
      builder.string(Product.imageURLKey)
      builder.int(Product.versionKey)
    }
  }

  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}

extension Product: JSONConvertible {
    convenience init(json: JSON) throws {
      try self.init( name: json.get(Product.nameKey), content: json.get(Product.contentKey), imageURL: json.get(Product.imageURLKey))
    }

    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(Product.idKey, id)
        try json.set(Product.nameKey, name)
        try json.set(Product.contentKey, content)
        try json.set(Product.imageURLKey, imageURL)
        try json.set(Product.versionKey, version)
        return json
    }
}


extension Product: Updateable {
    public static var updateableKeys: [UpdateableKey<Product>] {
        return [
            UpdateableKey(Product.contentKey, String.self) { product, content in
                product.content = content
            },
            UpdateableKey(Product.nameKey, String.self) { product, name in
                product.name = name 
            },
            UpdateableKey(Product.imageURLKey, String.self) { product, imageURL in
                product.imageURL = imageURL
            }
        ]
    }
}
