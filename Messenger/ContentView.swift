//
//  ContentView.swift
//  Messenger
//
//  Created by Mohar on 31/03/25.
//

import SwiftUI

// Model
struct Message: Identifiable {
    let id = UUID()
    let sender: String
    let text: String
    let date: Date
    let isSentByCurrentUser: Bool
}


let sampleMessages: [Message] = [
    Message(sender: "Alice", text: "Hello! 👋", date: Date().addingTimeInterval(-86400), isSentByCurrentUser: false),
    Message(sender: "Me", text: "Hi Alice, how are you?", date: Date().addingTimeInterval(-86000), isSentByCurrentUser: true),
    Message(sender: "Alice", text: "I'm doing great! Working on some SwiftUI apps.", date: Date().addingTimeInterval(-84000), isSentByCurrentUser: false),
    Message(sender: "Me", text: "Nice, keep it up!", date: Date().addingTimeInterval(-80000), isSentByCurrentUser: true),
    Message(sender: "Alice", text: "Thank you 😊", date: Date().addingTimeInterval(-79000), isSentByCurrentUser: false)
]



struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        VStack(alignment: message.isSentByCurrentUser ? .trailing : .leading) {
            Text(message.text)
                .padding()
                .background(message.isSentByCurrentUser ? Color.green.opacity(0.7) : Color.gray.opacity(0.3))
                .cornerRadius(15)
                .foregroundColor(.primary)
                .frame(maxWidth: 250, alignment: message.isSentByCurrentUser ? .trailing : .leading)
            
            Text("\(message.date, formatter: DateFormatter.shortTimeFormatter)")
                .font(.caption2)
                .foregroundColor(.secondary)
                .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, alignment: message.isSentByCurrentUser ? .trailing : .leading)
        .padding(message.isSentByCurrentUser ? .trailing : .leading, 10)
        .padding(.vertical, 4)
    }
}

extension DateFormatter {
    static let shortTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
}



struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        MessageBubble(message: message)
                    }
                }
            }
            .padding(.top)

            HStack {
                TextField("Message...", text: $viewModel.newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: viewModel.sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                .disabled(viewModel.newMessageText.isEmpty)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
        }
        .navigationTitle("Alice")
        .navigationBarTitleDisplayMode(.inline)
    }
}



// Preview
#Preview  {
    ChatView()
}
