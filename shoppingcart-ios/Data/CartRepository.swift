//
//  CartRepository.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation

/// Протокол взаимодействия с корзиной (аналог CartInteractor)
protocol CartInteractor {
    func getCartItems() async -> [CartItem]
    func deleteCart() async
    func updateCartItem(_ item: CartItem) async
    func updateCartItems(_ items: [CartItem]) async
}

/// Реализация репозитория корзины
final class CartRepository: CartInteractor, @unchecked Sendable {
    // Временное хранилище корзины (in-memory)
    private var cartItems: [CartItem] = [
        try! CartItem(
            id: "1",
            name: "Суп Том Ям с морепродуктами",
            count: 99,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
        try! CartItem(
            id: "2",
            name: "Поке с индейкой и чуккой",
            count: 2,
            price: 100,
            currency: "₽",
            imageUrl: "http://localhost:8080/poke_with_chiken.png"
        ),
        try! CartItem(
            id: "3",
            name: "Поке с тунцом, лососем, авокадо, чеддером",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "http://localhost:8080/poke_with_chiken"
        ),
        try! CartItem(
            id: "4",
            name: "Блинчики с малиной и маскарпоне",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
        try! CartItem(
            id: "5",
            name: "Блинчики с малиной и маскарпоне",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
        try! CartItem(
            id: "6",
            name: "Блинчики с малиной и маскарпоне",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
        try! CartItem(
            id: "7",
            name: "Блинчики с малиной и маскарпоне",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
        try! CartItem(
            id: "8",
            name: "Блинчики с малиной и маскарпоне",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
        try! CartItem(
            id: "9",
            name: "Блинчики с малиной и маскарпоне",
            count: 1,
            price: 100,
            currency: "₽",
            imageUrl: "https://i.pinimg.com/736x/70/b0/d5/70b0d50c800039db6f1d58273efbf542.jpg"
        ),
    ]
    
    // MARK: - Получить все товары корзины
    func getCartItems() async -> [CartItem] {
        return cartItems
    }
    
    // MARK: - Очистить корзину
    func deleteCart() async {
        cartItems.removeAll()
    }
    
    // MARK: - Обновить один товар
    func updateCartItem(_ item: CartItem) async {
        do {
            try validateCartItem(item)
        } catch {
            print("Ошибка валидации: \(error.localizedDescription)")
            return
        }
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index].count = item.count
            cartItems[index].price = item.price
        } else {
            print("Товар с id \(item.id) не найден в корзине")
        }
    }
    
    // MARK: - Обновить список товаров
    func updateCartItems(_ items: [CartItem]) async {
        for item in items {
            do {
                try validateCartItem(item)
                await updateCartItem(item)
            } catch {
                print("Ошибка валидации: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Проверка корректности CartItem
    private func validateCartItem(_ item: CartItem) throws {
        guard item.price > 0 else {
            throw CartItem.CartItemError.invalidPrice
        }
        guard (1...99).contains(item.count) else {
            throw CartItem.CartItemError.invalidCount
        }
    }
}
