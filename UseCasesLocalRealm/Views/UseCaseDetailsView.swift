//
//  UseCaseDetailsView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/11/22.
//

import Neumorphic
import RealmSwift
import SwiftUI

struct UseCaseDetailsView: View {
    @State var useCase: UseCase
    @State var showAddFields: Bool = false
    @FocusState var isFocused: Bool
    
    @State var text: String = EMPTY_STRING
    
    var body: some View {
        HStack(alignment: .top)
        {
            Text("ID: \(useCase.caseId)")
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
                    TextInputFieldWithFocus("Title", text: $text, isFocused: $isFocused).padding(8)
                }
                
                Button(action:
                        {
                    
                    isFocused = false
                })
                {
                    Text("Add Use Case").foregroundColor(text.isEmpty ? .secondary : .primary)
                        .fontWeight(.bold)
                    
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: CGFloat(15)))
                .disabled(text.isEmpty)
                .frame(maxWidth: .greatestFiniteMagnitude)
            }
        }
        
        Spacer().navigationTitle("\(useCase.caseId)")
                .navigationBarTitleDisplayMode(.inline)
    }
}

struct UseCaseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let useCase = UseCase(title: "title", projectId: ObjectId(), priority: .medium)
        UseCaseDetailsView(useCase: useCase)
    }
}
