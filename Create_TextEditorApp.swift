//
//  Create_TextEditorApp.swift
//  Create_TextEditor
//
//  Created by 須崎良祐 on 2022/07/18.
//

import SwiftUI

@main
struct Create_TextEditorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
