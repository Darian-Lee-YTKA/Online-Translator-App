//
//  translation.swift
//  FireTranslator
//
//  Created by Darian Lee on 4/5/24.
//

import Foundation
struct Translation: Hashable, Identifiable, Codable {
    let id: String
    let Inputtext: String
    let InputLanguage: String
    let translationText: String
    let translationLanguage: String
    let timestamp: Date
    let username: String
}
extension Translation {
    static let mockedTranslations: [Translation] = [Translation(id: UUID().uuidString, Inputtext: "мне можно принять ванну с твоей рыбкой?", InputLanguage: "RUS", translationText: "Can I take a bath with your fish?", translationLanguage: "ENG", timestamp: Date(), username: "kingsley@dog.com"), Translation(id: UUID().uuidString, Inputtext: "У меня трагические новости о твоей рыбке...", InputLanguage: "RUS", translationText: "I have tragic news regarding your fish...", translationLanguage: "ENG", timestamp: Date(), username: "kingsley@dog.com")]
}
