//
//  MailView.swift
//  SwiftLab
//
//  Created by PC on 05/03/22.
//

import SwiftUI
import SwiftSMTP

struct MailView: View {
    var body: some View {
        Button(action: {
            sendMail()
        }) {
            Text("Send Email")
        }
    }
    
    func sendMail() {
        let smtp = SMTP(
            hostname: "smtp.gmail.com",     // SMTP server address
            email: "jaykhunt741@gmail.com",        // username to login
            password: "irkzppkikigivjrc",            // password to login
            tlsMode: .normal
        )
        
        let sender = Mail.User(name: "Dr. Light", email: "khuntjay555@gmail.com")
        let receiver = Mail.User(name: "Megaman", email: "prayaggediya60@gmail.com")
        
        let mail = Mail(
            from: sender,
            to: [receiver],
            subject: "SMTP Mailing Test",
            text: "That was my ultimate wish."
        )
        
        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
}

struct MailView_Previews: PreviewProvider {
    static var previews: some View {
        MailView()
    }
}
