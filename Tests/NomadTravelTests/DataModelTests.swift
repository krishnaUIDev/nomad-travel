import XCTest
@testable import NomadTravel

final class DataModelTests: XCTestCase {
    
    func testTripOverlapDetection() {
        let now = Date()
        let tripA = Trip(
            userId: "user-1",
            city: "Lisbon",
            country: "Portugal",
            countryCode: "PT",
            countryFlag: "🇵🇹",
            startDate: now,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: now)!
        )
        
        let tripB = Trip(
            userId: "user-2",
            city: "Lisbon",
            country: "Portugal",
            countryCode: "PT",
            countryFlag: "🇵🇹",
            startDate: Calendar.current.date(byAdding: .day, value: 5, to: now)!,
            endDate: Calendar.current.date(byAdding: .day, value: 15, to: now)!
        )
        
        let tripC = Trip(
            userId: "user-3",
            city: "Bali",
            country: "Indonesia",
            countryCode: "ID",
            countryFlag: "🇮🇩",
            startDate: now,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: now)!
        )
        
        XCTAssertTrue(tripA.overlaps(with: tripB))
        XCTAssertEqual(tripA.overlappingDays(with: tripB), 6)
        XCTAssertFalse(tripA.overlaps(with: tripC))
    }
    
    func testNomadUserMockData() {
        let mockUsers = NomadUser.mockUsers
        XCTAssertFalse(mockUsers.isEmpty)
        XCTAssertEqual(mockUsers.first?.displayName, "Sophia Lin")
        XCTAssertTrue(mockUsers.first?.isVerified == true)
    }
}
