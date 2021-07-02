//
//  Character.swift
//  Marvel
//
//  Created by Vicente Ortega Aguado on 27/06/2021.
//

import Foundation

// Replaced for APIResponse
//struct CharacterDataWrapper: Codable {
//    let code: Int?
//    let status: String?
//    let copyright: String?
//    let attributionText: String?
//    let attributionHTML: String?
//    let data: CharacterDataContainer?
//    let etag: String?
//}

struct CharacterDataContainer: Codable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    var results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String?
    let resourceURI: String?
    
    let urls: [Url]?
    let thumbnail: Image?
    
    let comics: ComicList?
    let stories: StoryList?
    let events: EventList?
    let series: SeriesList?
    
    // MARK: Init
    
    init(id: Int) {
        self.id = id
        self.name = nil
        self.description = nil
        self.modified = nil
        self.resourceURI = nil
        self.urls = nil
        self.thumbnail = nil
        self.comics = nil
        self.stories = nil
        self.events = nil
        self.series = nil
    }
}

// MARK: Resources

struct Image: Codable {
    let path: String?
    let fileExtension: String?

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
}

struct Url: Codable {
    let type: String?
    let url: String?
}

// MARK: Comics

struct ComicList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
}
struct ComicSummary: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: Stroies

struct StoryList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
}
struct StorySummary: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
}

// MARK: Events

struct EventList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
}
struct EventSummary: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: Serires

struct SeriesList: Codable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [ComicSummary]?
}
struct SeriesSummary: Codable {
    let resourceURI: String?
    let name: String?
}
