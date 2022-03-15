import Vapor
import Fluent


final class Item: Model, Content, Codable {
    static let schema = "items"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "cart_id")
    var cart_id: UUID

    @Field(key: "product_id")
    var product_id: UUID

    @Field(key: "topping_id")
    var topping_id: UUID

    @Field(key: "varian_id")
    var varian_id: UUID

    @Field(key: "user_id")
    var user_id: UUID
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil, cart_id: UUID, product_id: UUID, topping_id: UUID, varian_id: UUID, user_id: UUID) {
        self.id = id
        self.cart_id = cart_id
        self.product_id = product_id
        self.topping_id = topping_id
        self.varian_id = varian_id
        self.user_id = user_id
    }
}


final class ItemUpdate: Content, Codable {
    var cart_id: UUID?
    var product_id: UUID?
    var topping_id: UUID?
    var varian_id: UUID?
    var user_id: UUID?

    init(cart_id: UUID? = nil, product_id: UUID? = nil, topping_id: UUID? = nil, varian_id: UUID? = nil, user_id: UUID? = nil) {
        self.cart_id = cart_id
        self.product_id = product_id
        self.topping_id = topping_id
        self.varian_id = varian_id
        self.user_id = user_id
    }
}