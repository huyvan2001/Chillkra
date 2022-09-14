//
//  FileManager.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 14/09/2022.
//

import Foundation

public extension FileManager {
  static var documentsDirectoryURL: URL {
    return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }
}
