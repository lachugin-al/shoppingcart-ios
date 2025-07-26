//
//  CartItem.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 24/7/25.
//

import Foundation

/// Класс CartItem описывает объект товара в корзине.
///
/// - id: Уникальный идентификатор товара.
/// - name: Название товара.
/// - count: Количество товара (1...99).
/// - price: Цена товара (>0).
/// - currency: Валюта.
/// - imageUrl: URL изображения товара.
///
/// При инициализации выполняется валидация. Если данные некорректны — инициализация завершится ошибкой.
struct CartItem: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    var count: Int
    var price: Int
    let currency: String
    let imageUrl: String

    init(id: String,
         name: String,
         count: Int,
         price: Int,
         currency: String,
         imageUrl: String) throws
    {
        guard price > 0 else {
            throw CartItemError.invalidPrice
        }
        guard (1...99).contains(count) else {
            throw CartItemError.invalidCount
        }
        self.id = id
        self.name = name
        self.count = count
        self.price = price
        self.currency = currency
        self.imageUrl = imageUrl
    }

    enum CartItemError: Error, LocalizedError {
        case invalidPrice
        case invalidCount

        var errorDescription: String? {
            switch self {
            case .invalidPrice:
                return "Цена не должна быть отрицательной или равна нулю"
            case .invalidCount:
                return "Количество должно быть в диапазоне от 1 до 99"
            }
        }
    }
}
