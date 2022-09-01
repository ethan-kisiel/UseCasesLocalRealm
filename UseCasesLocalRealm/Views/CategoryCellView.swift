//
//  CategoryCellView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 8/11/22.
//

import SwiftUI
import RealmSwift

struct CategoryCellView: View {
    let category: Category
    
    var body: some View
    {
        Text(category.title)
    }
}

struct CategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCellView(category: Category(title: "Preview"))
    }
}
