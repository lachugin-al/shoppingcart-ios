//
//  ShoppingCartApp.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 24/7/25.
//

import SwiftUI

@main
struct ShoppingCartApp: App {
    // DI singleton
    let di = AppDI.shared

    var body: some Scene {
        WindowGroup {
            // Инициализируем ViewModel с нужными use cases
            CartScreen(
                viewModel: CartViewModel(
                    getCartItemsUseCase: { try await di.getCartItemsUseCase() },
                    updateCartItemUseCase: { item in try await di.updateCartItemUseCase(item) },
                    deleteCartUseCase: { try await di.deleteCartUseCase() },
                    sendTestOrderUseCase: { try await di.sendTestOrderUseCase() }
                )
            )
        }
    }
}
