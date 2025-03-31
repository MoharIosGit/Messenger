//
//  ChatViewModel.swift
//  Messenger
//
//  Created by Mohar on 31/03/25.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = sampleMessages
    @Published var newMessageText: String = ""

    func sendMessage() {
        guard !newMessageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let message = Message(sender: "Me", text: newMessageText, date: Date(), isSentByCurrentUser: true)
        messages.append(message)
        newMessageText = ""
    }
}
