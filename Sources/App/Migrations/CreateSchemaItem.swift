import Fluent

struct CreateSchemaItem: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("items")
            .id()
            .field("cart_id", .uuid, .required)
            .field("topping_id", .uuid, .required)
            .field("product_id", .uuid, .required)
            .field("varian_id", .uuid, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .unique(on: "varian_id")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("categories").delete()
    }
}