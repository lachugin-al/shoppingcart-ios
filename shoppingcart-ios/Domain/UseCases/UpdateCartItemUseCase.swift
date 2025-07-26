//
//  UpdateCartItemUseCase.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation

/// UseCase для обновления данных одного элемента в корзине.
struct UpdateCartItemUseCase {
    let cartRepository: CartInteractor

    /// Асинхронно обновляет данные указанного элемента корзины.
    func callAsFunction(_ item: CartItem) async throws {
        await cartRepository.updateCartItem(item)
    }
}
