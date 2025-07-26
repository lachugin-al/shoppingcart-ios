//
//  CartItemRowView.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import SwiftUI

/// Компонент строки товара в корзине
struct CartItemRowView: View {
    let cartItem: CartItem
    let onCountChange: (Int) -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Изображение товара
            AsyncImage(url: URL(string: cartItem.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 64, height: 64)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .accessibilityIdentifier("cart_item_image_\(cartItem.id)")
                case .failure:
                    Image(systemName: "photo.fill")
                        .resizable()
                        .foregroundColor(.gray)
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .accessibilityIdentifier("cart_item_image_\(cartItem.id)_error")
                @unknown default:
                    EmptyView()
                }
            }
            .accessibilityLabel(cartItem.name)

            // Информация о товаре
            VStack(alignment: .leading, spacing: 4) {
                Text(cartItem.name)
                    .font(.body)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .accessibilityIdentifier("cart_item_name_\(cartItem.id)")

                Text("\(cartItem.price) \(cartItem.currency)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .accessibilityIdentifier("cart_item_price_\(cartItem.id)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityIdentifier("cart_item_info_\(cartItem.id)")

            // Счётчик для изменения количества товара
            CounterView(
                count: cartItem.count,
                onCountChange: onCountChange,
                itemId: cartItem.id
            )
            .accessibilityIdentifier("cart_item_counter_\(cartItem.id)")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .accessibilityIdentifier("cart_item_row_\(cartItem.id)")
    }
}
