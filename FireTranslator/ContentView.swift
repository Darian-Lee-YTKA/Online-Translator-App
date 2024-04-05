//
//  ContentView.swift
//  FireTranslator
//
//  Created by Darian Lee on 4/4/24.
//

import SwiftUI





struct TranslationView: View {
    var email: String

        init(email: String) {
            self.email = email
            translationManager = TranslationManager(email: email)
        }
    @State var translationManager: TranslationManager
    @Environment(AuthManager.self) var authManager
    @State var textInput = ""
    @State var translationOutput: String = ""
    @State var translationLanguage = "ru"
    var translation: String?
    var body: some View {
        
        
        NavigationView {
            VStack {
                Text("🌍🌎🌏 TranslateMe 🌏🌎🌍") //adding a crap ton of globes to try to make the scroll view extend to the edge of the screen XD
                    .font(.custom("Courier New", size: 24))
                    .foregroundColor(.white)
                    .padding()
                
                TextField("Enter text", text: $textInput)
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(20)
                HStack{
                    Picker("Language", selection: $translationLanguage) {
                        Text("Arabic").tag("ar")
                        Text("Chinese").tag("zh")
                        Text("Czech").tag("cs")
                        Text("Danish").tag("da")
                        Text("Dutch").tag("nl")
                        Text("English").tag("en")
                        Text("Finnish").tag("fi")
                        Text("French").tag("fr")
                        Text("German").tag("de")
                        Text("Greek").tag("el")
                        Text("Hebrew").tag("he")
                        Text("Hindi").tag("hi")
                        Text("Hungarian").tag("hu")
                        Text("Indonesian").tag("id")
                        Text("Italian").tag("it")
                        Text("Japanese").tag("ja")
                        Text("Korean").tag("ko")
                        Text("Norwegian").tag("no")
                        Text("Polish").tag("pl")
                        Text("Portuguese").tag("pt")
                        Text("Russian").tag("ru")
                        Text("Spanish").tag("es")
                        Text("Swedish").tag("sv")
                        Text("Thai").tag("th")
                        Text("Turkish").tag("tr")
                        Text("Vietnamese").tag("vi")
                    }
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    //.font(.custom("Courier New", size: 18))
                    Button(action: {
                        print("starting!")
                        print("🌝🌈🌝🌈🌝🌈🌝🌈🌝🌈🌝🌈🌝🌈", email)
                        Task {
                                do {
                                    print("🌝🌈🌝🌈🌝🌈🌝🌈🌝🌈🌝🌈🌝🌈", email)
                                    print("Pressed button")
                                    translationOutput  = try await translationManager.makeTranslation(Inputtext: textInput, translationLanguage: translationLanguage, user: email)
                                    print("ALL SAVED TRANSLATIONS:")
                                    print(translationManager.translations)
                                    // Handle the translation result
                                } catch {
                                    // Handle errors
                                    print("Error: \(error)")
                                }
                            }
                        }) {
                        
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                ScrollView{
                    
                    Text(translationOutput)
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                    
                    
                    
                    
                    
                    
                }
                .preferredColorScheme(.dark)
                HStack{
                    Button("sign out") {
                        authManager.signOut()
                    }
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom("Courier New", size: 18))
                    .bold()
                    
                    NavigationLink(destination: SavedTranslationsView(isMocked: false, email: email).navigationBarBackButtonHidden(true))

                    { // Navigate to TranslationView when the button is clicked
                        HStack {
                            Text("history")
                        }
                        .foregroundColor(.blue)
                        .font(.custom("Courier New", size: 18))
                        .bold()
                    }
                            
                        
                    }
            }
            
            //.padding()
            
            
            //.background(Color.black)
            
        }
        
        
    }
}



struct SavedTranslationsView: View {

    @State var translationManager: TranslationManager
    var email: String
    @State private var showAlert = false
    @State private var navigateToTranslationView = false
    init(isMocked: Bool = false, email: String ) {
        self.email = email
        translationManager = TranslationManager(isMocked: isMocked, email: email)
       
    }
    
    var body: some View {
        
        NavigationView {
            VStack{
                Text("Saved Translations")
                    .font(.custom("Courier New", size: 28))
                    .bold()
                NavigationLink(destination: TranslationView(email: email).navigationBarBackButtonHidden(true)) { // Navigate to TranslationView when the button is clicked
                    HStack {
                        Text("<")
                    }
                    .foregroundColor(Color(red: 135/255, green: 206/255, blue: 255/255))
                    .font(.custom("Courier New", size: 18))
                    .bold()
                }
                
                .foregroundColor(Color(red: 135/255, green: 206/255, blue: 255/255))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom("Courier New", size: 18))
                .bold()
                
                
                ScrollView {
                    VStack {
                        
                        ForEach(translationManager.translations) { translation in // <-- Add ForEach, accessing the messages property of the message manager
                            VStack{
                                HStack{
                                    Text(translation.Inputtext)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        .font(.custom("Courier New", size: 18))
                                        .bold()
                                    Text(translation.InputLanguage)
                                        .padding()
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                        .font(.custom("Courier New", size: 18))
                                        .bold()
                                    
                                }
                                HStack{
                                    Text(translation.translationText)
                                        .foregroundColor(.black)
                                        .font(.custom("Courier New", size: 18))
                                        .bold()
                                    Text(translation.translationLanguage)
                                        .foregroundColor(.black)
                                        .font(.custom("Courier New", size: 18))
                                        .bold()
                                    
                                }
                                
                                
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(red: 135/255, green: 206/255, blue: 255/255))
                                    .shadow(color: Color.white.opacity(0.5), radius: 5, x: 0, y: 2)
                                    .frame(width: 340)
                            )
                        }
                    }
                    .preferredColorScheme(.dark)
                    .padding()
                    
                }
                Button("clear all") {
                    translationManager.clearAll(email: email)
                    showAlert = true
                    
                    
                }
                .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Success"),
                                message: Text("Successfully cleared all translations."),
                                primaryButton: .default(Text("Make New Translation")) {
                                    navigateToTranslationView = true
                                },
                                secondaryButton: .cancel()
                            )
                        }
                .background(
                            NavigationLink(
                                destination: TranslationView(email: email).navigationBarBackButtonHidden(true),
                                isActive: $navigateToTranslationView
                            ) {
                                EmptyView()
                            }
                        )
                
            }
        }
    }
}
       
    
    
        

#Preview {
    TranslationView(email: "lion@gmail.com") // <-- Pass in true to isMocked to use the mocked version of the message manager in the preview
        .environment(AuthManager(isMocked: true))
}
