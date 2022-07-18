//
//  ContentView.swift
//  Create_TextEditor
//
//  Created by 須崎良祐 on 2022/07/18.
//

/*初期画面、新規作成、編集の3つの画面遷移について考える*/
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(key: "updatedAt", ascending: false)],
        animation: .default
    ) var fetchedMemoList: FetchedResults<Memo>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(fetchedMemoList) { memo in
                    NavigationLink(destination: EditMemoView(memo: memo)) {
                        VStack {
                            Text(memo.title ?? "")
                               .font(.title)
                               .frame(maxWidth: .infinity,alignment: .leading)
                               .lineLimit(1)
                           HStack {
                               Text (memo.stringUpdatedAt)
                                   .font(.caption)
                                   .lineLimit(1)
                               Spacer()
                           }
                        }
                    }
                }
            }
            .navigationTitle("メモ")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: AddMemoView()) {
                                    Text("新規作成")
                                }
                            }
                        }
        }
    }
    // 削除時の処理
        private func deleteMemo(offsets: IndexSet) {
            offsets.forEach { index in
                viewContext.delete(fetchedMemoList[index])//スワイプして削除
            }
        // 保存を忘れない
            try? viewContext.save()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


