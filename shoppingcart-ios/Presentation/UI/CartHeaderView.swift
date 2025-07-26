//
//  CartHeaderView.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import SwiftUI

/// Компонент, отображающий заголовок корзины и количество товаров.
///
/// - Parameters:
///   - itemCount: Количество товаров в корзине.
///   - onDeleteCart: Замыкание, вызываемое при нажатии на кнопку удаления корзины.
///   - onBackClick: Замыкание, вызываемое при нажатии на кнопку возврата.
struct CartHeaderView: View {
    let itemCount: Int
    let onDeleteCart: () -> Void
    let onBackClick: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // Кнопка возврата
                Button(action: onBackClick) {
                    Image(systemName: "chevron.backward")
                        .accessibilityLabel("Назад")
                }
                .accessibilityIdentifier("cart_back_button")

                Spacer()

                // Кнопка удаления корзины
                Button(action: onDeleteCart) {
                    Image(systemName: "trash")
                        .accessibilityLabel("Удалить корзину")
                }
                .accessibilityIdentifier("cart_delete_button")
            }
            .padding(.bottom, 8)
            .accessibilityIdentifier("cart_header_buttons_row")

            // Заголовок и количество товаров
            VStack(alignment: .leading, spacing: 2) {
                Text("Корзина")
                    .font(.title)
                    .fontWeight(.bold)
                    .accessibilityIdentifier("cart_title")
                Text("\(itemCount) \(getItemCountLabel(itemCount))")
                    .font(.subheadline)
                    .accessibilityIdentifier("cart_item_count")
            }
            .accessibilityIdentifier("cart_header_title_column")
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityIdentifier("cart_header")
    }
}

/// Возвращает корректное слово "блюдо" в зависимости от количества
func getItemCountLabel(_ count: Int) -> String {
    if count % 10 == 1 && count % 100 != 11 {
        return "блюдо"
    } else if (2...4).contains(count % 10) && !(12...14).contains(count % 100) {
        return "блюда"
    } else {
        return "блюд"
    }
}
