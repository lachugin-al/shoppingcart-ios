//
//  shoppingcart_iosUITestsLaunchTests.swift
//  shoppingcart-iosUITests
//
//  Created by Anton Lachugin on 24/7/25.
//

import XCTest

final class shoppingcart_iosUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool { true }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchAndScreenshot() throws {
        let app = XCUIApplication()
        app.launch()

        // Проверим, что мы на главном экране корзины
        XCTAssertTrue(app.otherElements["cart_screen_container"].exists)

        // Скриншот для CI/CD или документации
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Cart Screen Launch"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
