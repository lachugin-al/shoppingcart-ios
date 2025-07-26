//
//  AppDI.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 24/7/25.
//

import Foundation

final class AppDI {
    // Singleton для shared instance (по желанию, можно иначе)
    static let shared = AppDI()

    // MARK: - Data Layer
    let cartRepository: CartRepository
    let apiService: ApiService

    // MARK: - Use Cases
    let getCartItemsUseCase: GetCartItemsUseCase
    let updateCartItemUseCase: UpdateCartItemUseCase
    let deleteCartUseCase: DeleteCartUseCase
    let sendTestOrderUseCase: SendTestOrderUseCase

    private init() {
        // Data Layer
        self.cartRepository = CartRepository()
        self.apiService = ApiServiceInstance.shared

        // Use Cases
        self.getCartItemsUseCase = GetCartItemsUseCase(cartRepository: cartRepository)
        self.updateCartItemUseCase = UpdateCartItemUseCase(cartRepository: cartRepository)
        self.deleteCartUseCase = DeleteCartUseCase(cartRepository: cartRepository)
        self.sendTestOrderUseCase = SendTestOrderUseCase(apiService: apiService)
    }
}
