//
//  CacheDataStorage.swift
//  HeyApp
//
//  Created by Lê Hoàng Anh on 09/12/2020.
//

import Foundation

final class CacheDataStorage {
    
    static let shared = CacheDataStorage()
    
//    var followingShops: [ShopModel] {
//        get {
//            let fileURL = cachedFileURL("following_shops.json")
//            let decoder = JSONDecoder()
//            if let shops = try? decoder.decode([ShopModel].self, from: Data(contentsOf: fileURL)) {
//                return shops
//            }
//            return []
//        }
//
//        set {
//            let fileURL = cachedFileURL("following_shops.json")
//            let encoder = JSONEncoder()
//            if let musicsData = try? encoder.encode(newValue) {
//                try? musicsData.write(to: fileURL, options: .atomicWrite)
//            }
//        }
//    }
    
}

private extension CacheDataStorage {
    
    func cachedFileURL(_ fileName: String) -> URL {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .allDomainsMask)
            .first!
            .appendingPathComponent(fileName)
    }
}
