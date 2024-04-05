//
//  TranslationManager.swift
//  FireTranslator
//
//  Created by Darian Lee on 4/5/24.
//


import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

@Observable // <-- Add the Observable macro
class TranslationManager {
    var email: String
    
    var translations: [Translation] = []
    private let dataBase = Firestore.firestore()

    init(isMocked: Bool = false, email: String = "deee@ucdavis.edu") {
        self.email = email
        if isMocked {
            translations = Translation.mockedTranslations
        } else {
            getTranslations(username: self.email)


                    }
                }
    func clearAll(email: String){
        dataBase.collection("translations").whereField("username", isEqualTo: email).getDocuments { snapshot, error in
                guard let snapshot = snapshot, error == nil else {
                    print("Error retrieving documents: \(error!)")
                    return
                }
                
                // Iterate over the documents and delete each one
                for document in snapshot.documents {
                    self.dataBase.collection("translations").document(document.documentID).delete { error in
                        if let error = error {
                            print("Error deleting document: \(error)")
                        } else {
                            print("Document successfully deleted")
                        }
                    }
                }
            }
        }
    

                // TODO: Save message
    func getTranslations(username: String) {
                    print("attempting to get translations")
   
        print("🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞🌞 USER EMAIL:", username)
                    // Access the "Messages" collection group in Firestore and listen for any changes
                    dataBase.collectionGroup("translations")
                        .whereField("username", isEqualTo: username)
                        .addSnapshotListener { querySnapshot, error in

                        // Get the documents for the messages collection (a document represents a message in this case)
                        guard let documents = querySnapshot?.documents else {
                            print("Error fetching documents: \(String(describing: error))")
                            return
                        }
                        
                        // Map Firestore documents to Message objects
                        let translations = documents.compactMap { document in
                            do {

                                // Decode message document to your Message data model
                                return try document.data(as: Translation.self)
                            } catch {
                                print("Error decoding document into message: \(error)")
                                return nil
                            }
                        }
                        
                        // Update the messages property with the fetched messages (sorting ascending timestamp)
                        self.translations = translations.sorted(by: { $0.timestamp > $1.timestamp })
                    }
                }

    func makeTranslation(Inputtext: String, translationLanguage: String, user: String) async throws -> String{
        print("we make translstion")
            do {

                let decodedTranslation = try await getTranslation(translationLanguage: translationLanguage, inputText: Inputtext)
                   
                let translation = Translation(id: UUID().uuidString, Inputtext: Inputtext, InputLanguage: "en", translationText: decodedTranslation, translationLanguage: translationLanguage,  timestamp: Date(), username: user)
                print(translation)
                try dataBase.collection("translations").document().setData(from: translation)
                return decodedTranslation

            } catch {
                print("Error sending message to Firestore: \(error)")
                return "could not fetch translation. Please try again later"
            }
        }
    private func getTranslation(translationLanguage: String, inputText: String) async throws -> String {
        let url = URL(string: "https://api.mymemory.translated.net/get?q=" + inputText + "&langpair=en|" + translationLanguage)!
        let (data,_) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(TranslationResponse.self, from: data)
        
        guard let decodedResponse = response.responseData.translatedText.removingPercentEncoding else {
            return "unable to fetch translation"
        }
        print(decodedResponse)
            return decodedResponse
    }
    

}
struct TranslationResponse: Codable {
    let responseData: ResponseData
}
struct ResponseData: Codable {
    let translatedText: String
}
