//
//  CartScreen.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import SwiftUI

struct CartScreen: View {
    @ObservedObject var viewModel: CartViewModel

    var body: some View {
        Group {
            if viewModel.isOrderSent {
                // Сообщение об успехе заказа
                VStack {
                    Spacer()
                    Text("Заказ успешно отправлен!")
                        .font(.title2)
                        .foregroundColor(.green)
                        .accessibilityIdentifier("order_success_message")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .accessibilityIdentifier("order_success_container")
            } else if viewModel.cartItems.isEmpty {
                // Пустая корзина
                VStack {
                    Spacer()
                    Text("Ваша корзина пуста")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .accessibilityIdentifier("empty_cart_message")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .accessibilityIdentifier("empty_cart_container")
            } else {
                VStack(spacing: 0) {
                    // Верхняя часть с заголовком и списком товаров
                    VStack(spacing: 16) {
                        CartHeaderView(
                            itemCount: viewModel.cartItems.count,
                            onDeleteCart: {
                                Task { await viewModel.clearCart() }
                            },
                            onBackClick: {
                                // TODO: обработка возврата (navigation)
                            }
                        )
                        .accessibilityIdentifier("cart_header_in_screen")

                        // Список товаров
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewModel.cartItems) { item in
                                    CartItemRowView(
                                        cartItem: item,
                                        onCountChange: { newCount in
                                            var updatedItem = item
                                            updatedItem.count = newCount
                                            Task { await viewModel.updateCartItem(updatedItem) }
                                        }
                                    )
                                }
                            }
                        }
                        .accessibilityIdentifier("cart_items_list")
                    }
                    .padding(16)
                    .background(
                        RoundedCorner(radius: 16, corners: [.bottomLeft, .bottomRight])
                            .fill(Color.white)
                    )
                    .accessibilityIdentifier("cart_content_container")

                    Spacer()
                        .frame(height: 36)
                        .accessibilityIdentifier("cart_spacer")

                    // Кнопка "Далее" (checkout)
                    HStack {
                        CheckoutButton(
                            totalPrice: viewModel.totalPrice,
                            onCheckout: {
                                Task { await viewModel.sendOrder() }
                            }
                        )
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedCorner(radius: 16, corners: [.topLeft, .topRight])
                            .fill(Color.white)
                    )
                    .accessibilityIdentifier("checkout_button_container")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemGray6))
                .accessibilityIdentifier("cart_screen_container")
            }
        }
    }
}

// MARK: - Rounded corners for background (helper)
struct RoundedCorner: Shape {
    var radius: CGFloat = 16.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
