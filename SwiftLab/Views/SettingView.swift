//
//  SettingView.swift
//  SwiftLab
//
//  Created by PC on 28/01/22.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var settings: SettingsStore
    
    var body: some View {
            Form {
                Section(header: Text("Notifications settings")) {
                    Toggle(isOn: $settings.isNotificationEnabled) {
                        Text("Notification:")
                    }
                }
                
                Section(header: Text("Sleep tracking settings")) {
                    Toggle(isOn: $settings.isSleepTrackingEnabled) {
                        Text("Sleep tracking:")
                    }
                    
                    Picker(
                        selection: $settings.sleepTrackingMode,
                        label: Text("Sleep tracking mode")
                    ) {
                        ForEach(SettingsStore.SleepTrackingMode.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    
                    Stepper(value: $settings.sleepGoal, in: 6...12) {
                        Text("Sleep goal is \(settings.sleepGoal) hours")
                    }
                }
                
                if !settings.isPro {
                    Section {
                        Button(action: {
                            self.settings.unlockPro()
                        }) {
                            Text("Unlock PRO")
                        }
                        
                        Button(action: {
                            self.settings.restorePurchase()
                        }) {
                            Text("Restore purchase")
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
