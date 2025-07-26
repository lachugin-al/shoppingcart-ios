//
//  CartRepositoryTests.swift
//  shoppingcart-ios
//
//  Created by Anton Lachugin on 26/7/25.
//

import XCTest
@testable import shoppingcart_ios // Импортируй свой модуль с исходным кодом

final class CartRepositoryTests: XCTestCase {

    var cartRepository: CartRepository!

    override func setUp() {
        super.setUp()
        cartRepository = CartRepository()
    }

    // Проверяем, что изначально в корзине 4 элемента
    func testGetCartItems() async throws {
        let items = await cartRepository.getCartItems()
        XCTAssertEqual(items.count, 9)
    }

    // Проверяем, что корзина пустая после удаления
    func testDeleteCart() async throws {
        await cartRepository.deleteCart()
        let items = await cartRepository.getCartItems()
        XCTAssertEqual(items.count, 0)
    }

    // Проверяем, что количество товара обновилось
    func testUpdateCartItem() async throws {
        let itemToUpdate = try! CartItem(id: "1", name: "Суп Том Ям с морепродуктами", count: 50, price: 100, currency: "₽", imageUrl: "")
        await cartRepository.updateCartItem(itemToUpdate)
        let items = await cartRepository.getCartItems()
        XCTAssertEqual(items.first(where: { $0.id == "1" })?.count, 50)
    }

    // Проверяем, что количество товаров обновилось для нескольких товаров
    func testUpdateCartItems_multipleItems() async throws {
        let itemsToUpdate = [
            try! CartItem(id: "1", name: "Суп Том Ям с морепродуктами", count: 50, price: 100, currency: "₽", imageUrl: ""),
            try! CartItem(id: "2", name: "Поке с индейкой и чуккой", count: 10, price: 200, currency: "₽", imageUrl: "")
        ]
        await cartRepository.updateCartItems(itemsToUpdate)
        let items = await cartRepository.getCartItems()
        XCTAssertEqual(items.first(where: { $0.id == "1" })?.count, 50)
        XCTAssertEqual(items.first(where: { $0.id == "2" })?.count, 10)
    }

    // Проверяем, что количество товара обновилось на 1
    func testUpdateCartItem_quantityToOne() async throws {
        let itemToUpdate = try! CartItem(id: "1", name: "Суп Том Ям с морепродуктами", count: 1, price: 100, currency: "₽", imageUrl: "")
        await cartRepository.updateCartItem(itemToUpdate)
        let items = await cartRepository.getCartItems()
        XCTAssertEqual(items.first(where: { $0.id == "1" })?.count, 1)
    }

    // Проверяем, что несуществующий товар не появляется в корзине
    func testUpdateCartItem_nonExistingItem() async throws {
        let itemToUpdate = try! CartItem(id: "999", name: "Несуществующий товар", count: 50, price: 100, currency: "₽", imageUrl: "")
        await cartRepository.updateCartItem(itemToUpdate)
        let items = await cartRepository.getCartItems()
        XCTAssertNil(items.first(where: { $0.id == "999" }))
    }

    // Проверяем, что корзина очищается после обновления товара и удаления корзины
    func testDeleteCart_afterItemUpdate() async throws {
        let itemToUpdate = try! CartItem(id: "1", name: "Суп Том Ям с морепродуктами", count: 50, price: 100, currency: "₽", imageUrl: "")
        await cartRepository.updateCartItem(itemToUpdate)
        await cartRepository.deleteCart()
        let items = await cartRepository.getCartItems()
        XCTAssertEqual(items.count, 0)
    }

    // Проверяем, что товар с отрицательной ценой выбрасывает ошибку
    func testNegativePriceItem() async {
        do {
            let itemToUpdate = try CartItem(id: "1", name: "Товар с отрицательной ценой", count: 1, price: -100, currency: "₽", imageUrl: "")
            await cartRepository.updateCartItem(itemToUpdate)
            XCTFail("Ожидалась ошибка, но она не возникла")
        } catch {
            // Ожидаем CartItem.CartItemError.invalidPrice
            XCTAssertTrue("\(error)".contains("invalidPrice"))
        }
    }

    // Проверяем, что при количестве > 99 выбрасывается ошибка
    func testExtremeItemQuantity() async {
        do {
            let item = try CartItem(id: "1", name: "Товар с экстремальным количеством", count: 100, price: 100, currency: "₽", imageUrl: "")
            await cartRepository.updateCartItem(item)
            XCTFail("Ожидалась ошибка, но она не возникла")
        } catch {
            XCTAssertTrue("\(error)".contains("invalidCount"))
        }
    }

    // Проверяем, что при количестве == 0 выбрасывается ошибка
    func testZeroItemQuantity() async {
        do {
            let item = try CartItem(id: "1", name: "Товар с 0 количеством", count: 0, price: 100, currency: "₽", imageUrl: "")
            await cartRepository.updateCartItem(item)
            XCTFail("Ожидалась ошибка, но она не возникла")
        } catch {
            XCTAssertTrue("\(error)".contains("invalidCount"))
        }
    }
}
