//
//  ServerModel.swift
//  MyDay
//
//  Created by Gerasimov's on 2024-03-07.
//

import Foundation


class ChecklistDataManager {
    
    static let shared = ChecklistDataManager()
    
    private let filename = "checklist.json"
    
    func saveChecklistItems(_ items: [ChecklistItem]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(items)
            if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(filename) {
                try data.write(to: filePath)
            }
        } catch {
            print("Error saving checklist items: \(error.localizedDescription)")
        }
    }
    
    func loadChecklistItems() -> [ChecklistItem] {
        if let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(filename) {
            do {
                let data = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                let items = try decoder.decode([ChecklistItem].self, from: data)
                return items
            } catch {
                print("Error loading checklist items: \(error.localizedDescription)")
            }
        }
        return []
    }
}
