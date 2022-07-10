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
    
    @State var title: String = EMPTY_STRING
    @State var caseId: String = EMPTY_STRING
    @State var useCase: UseCase?
    
    @FocusState var isFocused: Bool
    
    var body: some View {
            VStack(spacing: 10)
            {
                
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
                    useCase = UseCase(title: title, projectId: project._id)
                    
                    title = EMPTY_STRING
                    caseId = EMPTY_STRING
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
