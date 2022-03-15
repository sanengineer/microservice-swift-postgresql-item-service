import Vapor
import Fluent

struct ItemController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let userMiddleware = UserAuthMiddleware()
        // let midUserAuthMiddleware = MidUserAuthMiddleware()
        let items = routes.grouped("item")
        let itemAuthUser = items.grouped(userMiddleware)
        // let itemAuthMidUser = items.grouped(midUserAuthMiddleware)

        itemAuthUser.get(use: getAllHandler)

        itemAuthUser.post(use: createHandler)   
        // itemAuthUser.get(":user_id", use: getHandlerByUserId)
        itemAuthUser.get(":item_id", use: getHandler)
        // itemAuthUser.put(":item_id", use: updateHandler)
    }

    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[Item]> {
        return Item.query(on: req.db).all()
    }

    func createHandler(_ req: Request) throws -> EventLoopFuture<Item> {
        let item = try req.content.decode(Item.self)
        return item.save(on: req.db).map { item }
    }

    // func getHandlerByUserId(_ req: Request) throws -> EventLoopFuture<[Item]> {
    //     return Item.find(req.parameters.get("item_id"), on: req.db)
    //             .unwrap(or: Abort(.notFound))
    //             .map{ item in
    //                 return [Item(id: item.id, cart_id: item.cart_id, product_id: item.product_id, topping_id: item.topping_id, varian_id: item.varian_id, user_id: item.user_id)]
    //             }
    // }

    func getHandler(_ req: Request) throws -> EventLoopFuture<Item> {
        return Item.find(req.parameters.get("item_id"), on: req.db)
                .unwrap(or: Abort(.notFound))
    }

    // func updateHandler(_ req: Request) throws -> EventLoopFuture<Item> {
    //     let itemUpdate = try req.content.decode(ItemUpdate.self)

    //     return Item.find(req.parameters.get("item_id"), on: req.db)
    //             .unwrap(or: Abort(.notFound))
    //             .flatMap { item in
    //                 item.cart_id = itemUpdate.cart_id ?? item.cart_id
    //                 item.product_id = itemUpdate.product_id ?? item.product_id
    //                 item.topping_id = itemUpdate.topping_id ?? item.topping_id
    //                 item.varian_id = itemUpdate.varian_id ?? item.varian_id
    //                 item.user_id = itemUpdate.user_id ?? item.user_id
    //                 return item.update(on: req.db).map { item }
    //             }
    // }
}