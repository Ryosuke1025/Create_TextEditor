//
//  d.swift
//  TextEditor
//
//  Created by 須崎良祐 on 2022/07/17.
//

import SwiftUI

struct EditMemoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var FileName: String
    @State private var content: String
    private var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
        self.FileName = memo.title ?? ""
        self.content = memo.content ?? ""
    }
    
    var body: some View {
        VStack {
            TextField("タイトル", text: $FileName)
                .font(.title)
                .border(Color.black, width: 2)
            TextEditor(text: $content)
                .font(.body)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {saveMemo()}) {
                    Text("保存")
                }
            }
        }
    }
    
    private func saveMemo() {
        memo.title = FileName
        memo.content = content
        memo.updatedAt = Date()

        try? viewContext.save()
    }
}

struct EditMemoView_Previews: PreviewProvider {
    static var previews: some View {
        EditMemoView(memo: Memo())
    }
}
