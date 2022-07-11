//
//  ProjectDetailsView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/8/22.
//

import SwiftUI
import Neumorphic

struct ProjectDetailsView: View {
    @State var project: Project
    
    @State var priority: Priority = .medium
    @State var title: String = EMPTY_STRING
    @State var caseId: String = EMPTY_STRING
    
    @State var useCase: UseCase?
    
    @State var showAddFields: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
            HStack(alignment: .top)
            {
                Text("ID: \(project.projectId)")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: showAddFields ? LESS_ICON : MORE_ICON)
                    .onTapGesture {
                        showAddFields.toggle()
                    }
            }.padding()

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
                        TextInputFieldWithFocus("Title", text: $title, isFocused: $isFocused).padding(8)
                    }
                    withAnimation
                    {
                        TextInputFieldWithFocus("Case ID", text: $caseId, isFocused: $isFocused).padding(8)
                    }
                    
                    Button(action:
                            {
                        useCase = UseCase(title: title, projectId: project._id, priority: priority)
                        
                        UseCaseManager.shared.addUseCase(project: project, useCase: useCase!)
                        title = EMPTY_STRING
                        caseId = EMPTY_STRING
                        priority = .medium
                        isFocused = false
                    })
                    {
                        Text("Add Use Case").foregroundColor(title.isEmpty || caseId.isEmpty ? .secondary : .primary)
                            .fontWeight(.bold)
                        
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: CGFloat(15)))
                    .disabled(title.isEmpty || caseId.isEmpty)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                }
            }
        
            Spacer()
            UseCasesListView(project: project)
            Spacer()
                .navigationTitle(project.title)
                .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProjectDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let project = Project()
        ProjectDetailsView(project: project)
    }
}
