//
//  CartViewModel.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation
import Combine

/// ViewModel для управления состоянием корзины.
@MainActor
final class CartViewModel: ObservableObject {
    // Зависимости
    private let getCartItemsUseCase: () async throws -> [CartItem]
    private let updateCartItemUseCase: (CartItem) async throws -> Void
    private let deleteCartUseCase: () async throws -> Void
    private let sendTestOrderUseCase: () async throws -> Void

    // Состояние списка товаров в корзине
    @Published private(set) var cartItems: [CartItem] = []

    // Состояние общей стоимости товаров
    @Published private(set) var totalPrice: Int = 0

    // Состояние отправки заказа
    @Published private(set) var isOrderSent: Bool = false

    // MARK: - Инициализация с инъекцией зависимостей
    init(
        getCartItemsUseCase: @escaping () async throws -> [CartItem],
        updateCartItemUseCase: @escaping (CartItem) async throws -> Void,
        deleteCartUseCase: @escaping () async throws -> Void,
        sendTestOrderUseCase: @escaping () async throws -> Void
    ) {
        self.getCartItemsUseCase = getCartItemsUseCase
        self.updateCartItemUseCase = updateCartItemUseCase
        self.deleteCartUseCase = deleteCartUseCase
        self.sendTestOrderUseCase = sendTestOrderUseCase
        Task {
            await loadCartItems()
        }
    }

    /// Загружает список товаров и обновляет состояние
    func loadCartItems() async {
        do {
            let items = try await getCartItemsUseCase()
            cartItems = items
            calculateTotalPrice(items)
        } catch {
            print("Ошибка при загрузке товаров: \(error.localizedDescription)")
        }
    }

    /// Обновляет конкретный товар
    func updateCartItem(_ item: CartItem) async {
        do {
            try await updateCartItemUseCase(item)
            await loadCartItems()
        } catch {
            print("Ошибка при обновлении товара: \(error.localizedDescription)")
        }
    }

    /// Очищает корзину
    func clearCart() async {
        do {
            try await deleteCartUseCase()
            cartItems = []
            totalPrice = 0
        } catch {
            print("Ошибка при очистке корзины: \(error.localizedDescription)")
        }
    }

    /// Вычисляет общую стоимость
    private func calculateTotalPrice(_ items: [CartItem]) {
        totalPrice = items.reduce(0) { $0 + $1.price * $1.count }
    }

    /// Отправляет тестовый заказ
    func sendOrder() async {
        do {
            try await sendTestOrderUseCase()
            isOrderSent = true
        } catch {
            print("Ошибка при отправке заказа: \(error.localizedDescription)")
        }
    }
}
