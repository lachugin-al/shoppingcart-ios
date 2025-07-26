//
//  shoppingcart_iosUITests.swift
//  shoppingcart-iosUITests
//
//  Created by Anton Lachugin on 24/7/25.
//

import XCTest

final class shoppingcart_iosUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testCartScreenElementsVisible() {
        // Ищем по тому, что реально есть в иерархии
        XCTAssertTrue(app.buttons["cart_screen_container"].exists)
        XCTAssertTrue(app.staticTexts["Корзина"].exists)
        XCTAssertTrue(app.staticTexts["9 блюд"].exists)
    }

    @MainActor
        func testDecreaseItemCount() {
            let minusButton = app.staticTexts.matching(NSPredicate(format: "label == '-'")).element(boundBy: 0)
            XCTAssertTrue(minusButton.exists)
            minusButton.tap()
        }

        @MainActor
        func testCheckoutButtonExists() {
            let checkoutButton = app.buttons.matching(NSPredicate(format: "label BEGINSWITH 'Далее'")).firstMatch
            XCTAssertTrue(checkoutButton.exists)
        }

        @MainActor
        func testEmptyCartMessage() {
            let deleteButton = app.buttons.matching(NSPredicate(format: "label == 'Удалить корзину'")).firstMatch
            XCTAssertTrue(deleteButton.exists)
            deleteButton.tap()
            let emptyMessage = app.staticTexts["Ваша корзина пуста"]
            XCTAssertTrue(emptyMessage.waitForExistence(timeout: 2.0))
        }
}
