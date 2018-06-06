import XCTest
@testable import StitchCore

class StitchClientConfigurationTests: XCTestCase {
    private let baseURL = "qux"
    private let dataDirectory = URL.init(string: "foo/bar")!
    private let storage = MemoryStorage.init()
    private let transport = FoundationHTTPTransport.init()
    private let defaultRequestTimeout: TimeInterval = testDefaultRequestTimeout

    func testStitchClientConfigurationBuilderImplInit() throws {
        let builder = StitchClientConfigurationBuilder()

        XCTAssertThrowsError(try builder.build()) { error in
            XCTAssertEqual(error as? StitchClientConfigurationError,
                           StitchClientConfigurationError.missingBaseURL)
        }

        builder.with(baseURL: self.baseURL)

        XCTAssertThrowsError(try builder.build()) { error in
            XCTAssertEqual(error as? StitchClientConfigurationError,
                           StitchClientConfigurationError.missingDataDirectory)
        }

        builder.with(dataDirectory: self.dataDirectory)

        XCTAssertThrowsError(try builder.build()) { error in
            XCTAssertEqual(error as? StitchClientConfigurationError,
                           StitchClientConfigurationError.missingStorage)
        }

        builder.with(storage: self.storage)

        XCTAssertThrowsError(try builder.build()) { error in
            XCTAssertEqual(error as? StitchClientConfigurationError,
                           StitchClientConfigurationError.missingTransport)
        }

        builder.with(transport: self.transport)

        XCTAssertThrowsError(try builder.build()) { error in
            XCTAssertEqual(error as? StitchClientConfigurationError,
                           StitchClientConfigurationError.missingDefaultRequestTimeout)
        }

        builder.with(defaultRequestTimeout: self.defaultRequestTimeout)

        let config = try builder.build()

        XCTAssertEqual(config.baseURL, self.baseURL)
        XCTAssert(config.storage is MemoryStorage)
        XCTAssert(config.transport is FoundationHTTPTransport)
        XCTAssertEqual(config.defaultRequestTimeout, self.defaultRequestTimeout)
    }
}