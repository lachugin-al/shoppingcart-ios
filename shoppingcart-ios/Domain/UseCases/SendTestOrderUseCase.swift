//
//  SendTestOrderUseCase.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation

/// UseCase для отправки тестового заказа на сервер.
struct SendTestOrderUseCase {
    let apiService: ApiService

    /// Асинхронно отправляет тестовый заказ (POST-запрос).
    func callAsFunction() async throws {
        do {
            try await apiService.sendTestOrder()
            print("Заказ успешно отправлен.")
        } catch {
            print("Ошибка при отправке заказа: \(error.localizedDescription)")
            throw error
        }
    }
}
