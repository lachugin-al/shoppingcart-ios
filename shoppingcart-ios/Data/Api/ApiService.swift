//
//  ApiService.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import Foundation

/// Протокол ApiService (см. прошлый ответ)
protocol ApiService {
    func sendTestOrder() async throws
}

/// Реализация по умолчанию
final class DefaultApiService: ApiService {
    private let baseURL: URL
    private let session: URLSession

    init(
        baseURL: URL = URL(string: "http://localhost:8081")!,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }

    func sendTestOrder() async throws {
        let endpoint = baseURL.appendingPathComponent("/api/send-test-order")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Логирование запроса (аналог HttpLoggingInterceptor)
        print("[ApiService] POST \(endpoint.absoluteString)")

        let (data, response) = try await session.data(for: request)

        // Логирование ответа
        if let httpResponse = response as? HTTPURLResponse {
            print("[ApiService] Status: \(httpResponse.statusCode)")
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}

/// Синглтон для доступа к ApiService (аналог object RetrofitInstance)
enum ApiServiceInstance {
    static let shared: ApiService = DefaultApiService()
}
