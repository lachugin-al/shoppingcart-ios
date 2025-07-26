//
//  GetCartItemsUseCase.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation

/// UseCase для получения списка всех элементов корзины.
struct GetCartItemsUseCase {
    let cartRepository: CartInteractor

    /// Асинхронно возвращает список товаров в корзине.
    func callAsFunction() async throws -> [CartItem] {
        return await cartRepository.getCartItems()
    }
}
