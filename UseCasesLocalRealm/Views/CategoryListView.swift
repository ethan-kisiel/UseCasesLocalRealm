//
//  CategoryListView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 8/7/22.
//

import SwiftUI

struct CategoryListView: View {
    @State var project: Project
    @State var showUseCases: Bool = false
    var body: some View {
        List
        {
            ForEach(project.categories, id: \.self)
            { category in
                Text(category.title).onTapGesture
                {
                    showUseCases.toggle()
                }
                if showUseCases
                {
                    UseCaseListView(category: category)
                }
            }
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(project: Project())
    }
}
