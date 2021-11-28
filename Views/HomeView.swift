//
//  HomeView.swift
//  ridetec
//
//  Created by jose juan alcantara rincon on 28/11/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var rootActive: Bool
    @Binding var user: User
    @Binding var coreDM: CoreDataManager
    var body: some View {
        VStack {
            Text("Welcome user with id: \(user.id ?? "")")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout", action: {
                    coreDM.deleteAllUsers()
                    rootActive = false
                })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(rootActive: .constant(false), user: .constant(User()) , coreDM: .constant(CoreDataManager()))
    }
}
