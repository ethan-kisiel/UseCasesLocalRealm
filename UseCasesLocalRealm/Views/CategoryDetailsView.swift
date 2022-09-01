//
//  CategoryDetailsView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 8/29/22.
//

import SwiftUI

struct CategoryDetailsView: View {
    let category: Category
    
    @State var priority: Priority = .medium
    @State var title: String = EMPTY_STRING
    @State var caseId: String = EMPTY_STRING
    // add inline picker for the category selection
    
    @State var useCase: UseCase?

    @State var showAddFields: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View
    {
        if showAddFields
        {
            VStack(spacing: 5)
            {
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
                .disabled(title.isEmpty || caseId.isEmpty )
            }.padding()
        }
        UseCaseListView(category: category)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView(category: Category(title: "Preview"))
    }
}
