import Fluent
import Vapor
import FluentPostgresDriver

func routes(_ app: Application) throws {
    app.get { req in
        return "Hello To Item API Services"
    }
    
    // try app.register(collection: ItemController() )
}
