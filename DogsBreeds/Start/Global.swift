import Foundation

var apiBaseURL: URL = {
    guard let url = URL(string: "https://dog.ceo/api") else {
        fatalError("apiBaseURL must be a correct URL")
    }
    return url
}()
