import FluentProvider
import LeafProvider
// import MySQLProvider
// import Forms

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]

        try setupProviders()
        try setupPreparations()
        try setupMiddlewares()
        try addPreparations()
    }
    
    private func addPreparations() {
          preparations.append(Product.self)
    }

    private func setupMiddlewares() throws {
        try addConfigurable(middleware: RequestMethodLooseMiddleware(), name: "request_method_loose")
        try addConfigurable(middleware: ApplicationCacheMiddleware(), name: "applicsation_cache")
    }

    /// Configure providers
    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
//        try addProvider(MySQLProvider.Provider.self)
        try addProvider(LeafProvider.Provider.self)
        // try addProvider(Forms.Provider.self)
    }
    
    /// Add all models that should have their
    /// schemas prepared before the app boots
    private func setupPreparations() throws {
        preparations.append(Product.self)
    }
}
