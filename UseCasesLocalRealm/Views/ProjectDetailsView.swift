//
//  ProjectDetailsView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/8/22.
//

import Neumorphic
import SwiftUI
import RealmSwift

struct ProjectDetailsView: View
{
    
    @ObservedResults(Category.self) var categories: Results<Category>
    
    @State var project: Project
    
    @State var priority: Priority = .medium
    @State var title: String = EMPTY_STRING
    @State var caseId: String = EMPTY_STRING
    // add inline picker for the category selection
    @State var categoryTitle: String = EMPTY_STRING
    
    @State var useCase: UseCase?

    @State var showAddFields: Bool = false
    @FocusState var isFocused: Bool

    var body: some View
    {
        HStack(alignment: .top)
        {
            Text("ID: \(project.projectId)")
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: showAddFields ? LESS_ICON : MORE_ICON)
                .onTapGesture
                {
                    showAddFields.toggle()
                }
        }.padding()

        if showAddFields
        {
            VStack(spacing: 5)
            {
                withAnimation
                {
                    TextInputFieldWithFocus("Category", text: $categoryTitle, isFocused: $isFocused)
                        .padding(8)
                }
                
                Picker("Priority:", selection: $priority)
                {
                    ForEach(Priority.allCases, id: \.self)
                    {
                        priority in
                        Text(priority.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(5)
                
                withAnimation
                {
                    TextInputFieldWithFocus("Use Case", text: $title, isFocused: $isFocused).padding(8)
                }
                withAnimation
                {
                    TextInputFieldWithFocus("ID", text: $caseId, isFocused: $isFocused).padding(8)
                }

                Button(action:
                {
                    useCase = UseCase(title: title, priority: priority)
                    useCase!.caseId = caseId
                    
                    // if there is a category with the specified title
                    // the use case is added to that category
                    // otherwise, a category is created
                    // and the use case is added
                    if let targetCategory = categories.first(where: { $0.title == categoryTitle })
                    {
                        UseCaseManager.shared.addUseCase(category: targetCategory, useCase: useCase!)
                    }
                    else
                    {
                        let categoryToAdd = Category(title: categoryTitle)
                        CategoryManager.shared.addCategory(project: project, category: categoryToAdd)
                        //categoryToAdd.useCases.append(useCase!)
                        UseCaseManager.shared.addUseCase(category: categoryToAdd, useCase: useCase!)
                    }
                    title = EMPTY_STRING
                    caseId = EMPTY_STRING
                    priority = .medium
                    isFocused = false
                })
                {
                    Text("Add Use Case").foregroundColor(title.isEmpty || caseId.isEmpty ? .secondary : .primary)
                        .fontWeight(.bold).frame(maxWidth: .infinity)
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: CGFloat(15)))
                .disabled(title.isEmpty || caseId.isEmpty || categoryTitle.isEmpty)
            }.padding()
        }
        Spacer()
        CategoryListView(project: project)
        Spacer()
            .navigationTitle("(Project) " + project.title.shorten(by: DISP_SHORT))
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProjectDetailsView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let project = Project()
        ProjectDetailsView(project: project)
    }
}
