import XCTest
import NewsCore

final class ArticleModelTests: XCTestCase {
    
}

extension ArticleModelTests {
    
    func testDecoding() {
        do {
            let model = try JSONDecoder.default.decode(
                Article.self,
                from: jsonString
            )
            
            XCTAssertEqual(model.id, model.url)
            XCTAssertEqual(model.url, "https://www.wired.com/story/tesla-profits-health-care-algorithm-bias-and-more-news/")
            XCTAssertEqual(model.title, "Tesla Profits, Health Care Algorithm Bias, and More News")
            XCTAssertEqual(model.content, "Tesla looks to Shanghai and Joker fans head to the Bronx, but first, today's cartoon: What's rarer than a unicorn?")
            XCTAssertEqual(model.excerpt, "Catch up on the most important news from today in two minutes or less.")
            XCTAssertEqual(model.image, "https://media.wired.com/photos/5db1f3aa0da2b80009c7fb30/191:100/w_1280,c_limit/Transpo-Teslafactory-AP_19176027711740.jpg")
            XCTAssertEqual(model.author, "Lydia Horne")
            XCTAssertEqual(model.publishedAt, DateFormatter(iso8601Format: "yyyy-MM-dd'T'HH:mm:ssZ").date(from: "2019-10-24T23:46:10Z"))
            XCTAssertEqual(model.source.id, "wired")
            XCTAssertEqual(model.source.name, "Wired")
        } catch {
            XCTFail("Could not parse JSON: \(error)")
        }
    }
}

private extension ArticleModelTests {

    // TODO: Move to `.json` file when SPM supports embedded resources
    var jsonString: String {
        """
        {
            "source": {
                "id": "wired",
                "name": "Wired"
            },
            "author": "Lydia Horne",
            "title": "Tesla Profits, Health Care Algorithm Bias, and More News",
            "description": "Catch up on the most important news from today in two minutes or less.",
            "url": "https://www.wired.com/story/tesla-profits-health-care-algorithm-bias-and-more-news/",
            "urlToImage": "https://media.wired.com/photos/5db1f3aa0da2b80009c7fb30/191:100/w_1280,c_limit/Transpo-Teslafactory-AP_19176027711740.jpg",
            "publishedAt": "2019-10-24T23:46:10Z",
            "content": "Tesla looks to Shanghai and Joker fans head to the Bronx, but first, today's cartoon: What's rarer than a unicorn?"
        }
        """
    }
}
