//
//  CheckoutButton.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import SwiftUI

struct CheckoutButton: View {
    let totalPrice: Int
    let onCheckout: () -> Void
    var buttonColor: Color = .yellow // Можно задать кастомный цвет через Assets
    
    var body: some View {
        Button(action: onCheckout) {
            ZStack {
                // Центральный текст
                HStack {
                    Spacer()
                    Text("Далее")
                        .font(.headline)
                        .foregroundColor(.black)
                        .accessibilityIdentifier("checkout_button_text")
                    Spacer()
                }
                // Сумма в правой части кнопки
                HStack {
                    Spacer()
                    Text("\(totalPrice) ₽")
                        .font(.headline)
                        .foregroundColor(.black)
                        .accessibilityIdentifier("checkout_button_price")
                }
            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .accessibilityIdentifier("checkout_button_content")
        }
        .background(buttonColor)
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .accessibilityIdentifier("checkout_button")
    }
}
