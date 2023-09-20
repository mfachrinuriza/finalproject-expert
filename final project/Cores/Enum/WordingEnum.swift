//
//  WordingEnum.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import Foundation

enum ServiceError {
    static let deleteFavoriteFailed = "Menghapus game favorit Gagal!"
    static let createFavoriteFailed = "Menambahkan game favorit Gagal!"
    static let pleaseCheckConnectionError = "Koneksi sedang bermasalah, silakan cek kembali koneksimu"
}

enum ServiceSuccess {
    static let deleteFavoriteSuccess = "Menghapus game favorit Berhasil!"
    static let createFavoriteSuccess = "Menambahkan game favorit Berhasil!"
    
}
