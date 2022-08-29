//
//  CategoryCellView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 8/11/22.
//

import SwiftUI
import RealmSwift

struct CategoryCellView: View {
    @ObservedResults(Category.self) var categories: Results<Category>
    var category: Category
    
    @State var showCategories: Bool = false
    var body: some View
    {
        if showCategories
        {
            Image(systemName: MORE_ICON)
                .onTapGesture
                {
                    showCategories.toggle()
                }
            Text(category.title)
        }
        else
        {
            //UseCaseListView(category: category)
        }
    }
}

struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(category: Category(title: "Preview"))
    }
}
