//
//  GameData.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 19/09/23.
//

import UIKit

struct GameData: Codable {
    var id: Int?
    var slug: String?
    var name: String?
    var released: String?
    var description: String?
    var background_image: String?
    var rating: Double?
}

extension GameData {
    init(from game: Game) {
        self.init(
            id: game.id,
            slug: game.slug,
            name: game.name,
            released: game.released,
            description: game.description,
            background_image: game.background_image,
            rating: game.rating
        )
    }
}
