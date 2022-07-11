//
//  UseCaseCellView.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/10/22.
//

import RealmSwift
import SwiftUI
import Neumorphic

struct UseCaseCellView: View {
    @State var useCase: UseCase
    
    private func priorityBackground(_ priority: Priority) -> Color
    {
        switch priority
        {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        default:
            return .blue
        }
    }
    
    var body: some View {
        NavigationLink(value: Route.useCase(useCase))
        {
            HStack
            {
                Image(systemName: useCase.isComplete ? CHECKED_ICON : UNCHECKED_ICON)
                    .onTapGesture
                {
                    UseCaseManager.shared.toggleUseCaseCompleteness(useCase: useCase)
                }
                Text(useCase.title)
                Spacer()
                
                Text(useCase.priority.rawValue)
                    .padding(5)
                    .frame(width: 75)
                    .background(priorityBackground(useCase.priority))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }
    }
}

struct UseCaseCellView_Previews: PreviewProvider {
    static var previews: some View {
        let objectId = ObjectId()
        let useCase = UseCase(title:"preview", projectId: objectId, priority: .medium)
        UseCaseCellView(useCase: useCase)
    }
}
