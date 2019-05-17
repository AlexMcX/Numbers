//
//  FileService.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

open class INJFileService: INJService {
    public func readString(fileName: String) -> String? {
        if let path = getPath(fileName: fileName) {
            do {
                let data = try NSString(contentsOfFile:path, encoding:String.Encoding.utf8.rawValue) as String;
                
                return data
            }catch {
                return nil
            }
        }

        return nil
    }
    
    public func read<T: Decodable>(jsonFile: String, to: T.Type) -> T? {
        if let str = readString(fileName: jsonFile) {
            let decoder = JSONDecoder()
            let data = Data(str.utf8)
            
            do {
                let result = try decoder.decode(to, from: data)
                
                if (result is INJInstanceModel) {
                    (result as! INJInstanceModel).register()
                }
                
                return result
            } catch {
                return nil
            }
        }
        
        return nil
    }
    
    public func read<T: Decodable>(plistFile: String, to: T.Type) -> T? {
        let bundle = Bundle(for: to as! AnyClass)
        
        if let url: URL = bundle.url(forResource: plistFile, withExtension: "plist") {
            if let data = try? Data(contentsOf: url) {
                let decoder = PropertyListDecoder()
                
                let result = try? decoder.decode(to, from: data)
                
                if (result is INJInstanceModel) {
                    (result as! INJInstanceModel).register()
                }
                
                return result
            }
        }
        
        return nil
    }
        
    public func save<T: Encodable>(jsonFile: String, codable: T) {
        if let path = getPath(fileName: jsonFile) {
            let encoder = JSONEncoder()
            
            verificationSaveDirectorie(path: path, create: true)
            
            do {
                let data = try encoder.encode(codable)
                
                try data.write(to: URL(fileURLWithPath: path))
            }catch {}
        }
    }
    
    public func deleteFile(fileName: String) {
        let flManager: FileManager
        
        if let path = getPath(fileName: fileName) {
            flManager = FileManager.default
            
            do{
                try flManager.removeItem(at: URL(fileURLWithPath: path));
            }catch {
                print(" ❗️INJFileService:: file \"\(fileName)\", not deleted (\(error))");
            }
        }
    }
    
    private func getPath(fileName: String) -> String? {
        let dirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true);
        
        if (dirs.count > 0) {
            return dirs[0].appending("/\(fileName)");
        }
        
        return nil
    }
    
    private func verificationSaveDirectorie(path: String, create: Bool = false) {
        var folders = path.components(separatedBy: "/")
        let flManager:FileManager = FileManager.default
        
        folders.removeLast()
        
        if folders.count == 0 { return }
        
        let folder = folders.joined(separator: "/")
        
        if flManager.fileExists(atPath: folder) == false
        {
            do{
                try flManager.createDirectory(atPath: folder, withIntermediateDirectories: true, attributes: nil);
            }catch let error as NSError {
                print(" ❗️INJFileService:: An create directory \(error)\n");
            }
        }
    }
}
