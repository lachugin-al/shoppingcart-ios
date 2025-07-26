//
//  DeleteCartUseCase.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation

/// UseCase для удаления всех элементов из корзины.
struct DeleteCartUseCase {
    let cartRepository: CartInteractor

    /// Асинхронно удаляет все товары из корзины.
    func callAsFunction() async throws {
        await cartRepository.deleteCart()
    }
}
