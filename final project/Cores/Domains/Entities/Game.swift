//
//  Game.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 25/08/22.
//

import UIKit

struct Game: Codable {
    var id: Int?
    var slug: String?
    var name: String?
    var released: String?
    var description: String?
    var background_image: String?
    var rating: Double?
}

extension Game {
    init(from gameData: GameData) {
        self.init(
            id: gameData.id,
            slug: gameData.slug,
            name: gameData.name,
            released: gameData.released,
            description: gameData.description,
            background_image: gameData.background_image,
            rating: gameData.rating
        )
    }
}
