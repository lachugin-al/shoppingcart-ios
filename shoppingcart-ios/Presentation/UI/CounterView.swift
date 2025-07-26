//
//  CounterView.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import SwiftUI

struct CounterView: View {
    let count: Int
    let onCountChange: (Int) -> Void
    let itemId: String

    var body: some View {
        ZStack {
            // Контейнер с фоном и скруглением
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemGray5))
                .frame(width: 100, height: 36)
                .accessibilityIdentifier("counter_container_\(itemId)")

            // Горизонтальное размещение кнопок и значения
            HStack {
                // Кнопка уменьшения
                Text("-")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(count > 1 ? .black : .gray)
                    .frame(width: 24, height: 36)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if count > 1 { onCountChange(count - 1) }
                    }
                    .accessibilityIdentifier("counter_minus_button_\(itemId)")

                // Значение счетчика
                Text("\(count)")
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 32)
                    .accessibilityIdentifier("counter_value_\(itemId)")

                // Кнопка увеличения
                Text("+")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(count < 99 ? .black : .gray)
                    .frame(width: 24, height: 36)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if count < 99 { onCountChange(count + 1) }
                    }
                    .accessibilityIdentifier("counter_plus_button_\(itemId)")
            }
            .frame(width: 92, height: 36)
            .accessibilityIdentifier("counter_row_\(itemId)")
        }
        .frame(width: 100, height: 36)
        .padding(.horizontal, 0)
    }
}
