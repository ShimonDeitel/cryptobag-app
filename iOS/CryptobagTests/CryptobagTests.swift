import XCTest
@testable import Cryptobag

@MainActor
final class CryptobagTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
        store.items = []
    }

    func testAddIncreasesCount() {
        let before = store.items.count
        store.add(CryptobagItem())
        XCTAssertEqual(store.items.count, before + 1)
    }

    func testFreeLimitBlocksAdditionalAdds() {
        store.items = (0..<Store.freeLimit).map { _ in CryptobagItem() }
        XCTAssertFalse(store.canAddMore)
        store.add(CryptobagItem())
        XCTAssertEqual(store.items.count, Store.freeLimit)
    }

    func testProUnlocksBeyondLimit() {
        store.items = (0..<Store.freeLimit).map { _ in CryptobagItem() }
        store.isPro = true
        XCTAssertTrue(store.canAddMore)
        store.add(CryptobagItem())
        XCTAssertEqual(store.items.count, Store.freeLimit + 1)
    }

    func testDeleteAtOffsets() {
        store.items = [CryptobagItem(), CryptobagItem(), CryptobagItem()]
        store.delete(at: IndexSet(integer: 1))
        XCTAssertEqual(store.items.count, 2)
    }

    func testDeleteSpecificItem() {
        let item = CryptobagItem()
        store.items = [item]
        store.delete(item)
        XCTAssertTrue(store.items.isEmpty)
    }

    func testUpdateReplacesItem() {
        var item = CryptobagItem()
        store.items = [item]
        item.createdAt = Date.distantPast
        store.update(item)
        XCTAssertEqual(store.items.first?.createdAt, Date.distantPast)
    }

    func testSeedDataNotEmpty() {
        XCTAssertFalse(Store.seedData().isEmpty)
    }

    func testSeedDataBelowFreeLimit() {
        XCTAssertLessThan(Store.seedData().count, Store.freeLimit)
    }
}
