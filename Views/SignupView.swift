//
//  SignupView.swift
//  ridetec
//
//  Created by jose juan alcantara rincon on 27/11/21.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @Binding var rootActive: Bool
    @State var email: String = ""
    @State var password: String = ""
    @State var passwordConfirmation: String = ""
    @State var passWrong = false
    @State var messageError = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                VStack {
                    TextField("Email", text: $email)
                        .padding()
                        .padding(.horizontal, 30)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .padding(.horizontal, 30)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("Confirm password", text: $passwordConfirmation)
                        .padding(.horizontal)
                        .padding(.horizontal, 30)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        createNewAccount()
                    }, label: {
                        Text("Signup")
                            .padding()
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                            .background(Color.init(red: 121/255, green: 29/255, blue: 35/255))
                            .cornerRadius(8)
                            .padding(.top)
                    })
                        .alert(self.messageError, isPresented: $passWrong) {
                        Button("Close", role: .cancel) { }
                    }
                }
                Spacer()
            }
            .navigationTitle("Signup")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func createNewAccount() {
        if(password == passwordConfirmation){
            Auth.auth().createUser(withEmail: self.email, password: self.password) {
                result, error in
                if let err = error {
                    print("Failed to create user:", err.localizedDescription)
                    messageError = err.localizedDescription
                    passWrong = true
                    email = ""
                    return
                }
                
                print("Successfully created user: \(result?.user.uid ?? "")")
                rootActive = false
            }
        }
        else {
            messageError = "Passwords does not match"
            passWrong = true
            password = ""
            passwordConfirmation = ""
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(rootActive: .constant(true))
    }
}
