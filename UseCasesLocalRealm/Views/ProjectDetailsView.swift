//
//  ProjectDetailsView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/8/22.
//

import Neumorphic
import SwiftUI

struct ProjectDetailsView: View
{
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
                TextInputFieldWithFocus("Category", text: $categoryTitle, isFocused: $isFocused)
                
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
