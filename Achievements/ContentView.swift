//
//  ContentView.swift
//  Achievements
//
//  Created by James Cosgrove on 03/09/2020.
//

import SwiftUI
import CoreData

extension ContentView {
    func generateAchievements() {
        let achievement1 = RunningAchievement(context: viewContext)
        achievement1.runningName = "You Can’t Catch Me!"
        achievement1.runningDescription = "Complete 25 runs! 😯"
        achievement1.runningValue = 25
        achievement1.runningProgress = 0.1
        
        let achievement2 = RunningAchievement(context: viewContext)
        achievement2.runningName = "Run, run, run!"
        achievement2.runningDescription = "Complete 50 runs! 😲"
        achievement2.runningValue = 50
        achievement2.runningProgress = 0.1
        
        let achievement3 = RunningAchievement(context: viewContext)
        achievement3.runningName = "Never Gonna Stop Me!"
        achievement3.runningDescription = "Complete 100 runs! 😱"
        achievement3.runningValue = 100
        achievement3.runningProgress = 0.1
        
        let achievement4 = RunningAchievement(context: viewContext)
        achievement4.runningName = "I’m Not Even Tired!"
        achievement4.runningDescription = "Complete 500 runs! 😴"
        achievement4.runningValue = 500
        achievement4.runningProgress = 0.1
        
        let achievement5 = RunningAchievement(context: viewContext)
        achievement5.runningName = "And Yet Here I Stand... Er... Run..."
        achievement5.runningDescription = "Complete 1,000 runs! ... Seriously?! 🤩"
        achievement5.runningValue = 1000
        achievement5.runningProgress = 0.1
        
        let achievement6 = RunningAchievement(context: viewContext)
        achievement6.runningName = "Butter Me Up, I’m On a Roll!"
        achievement6.runningDescription = "Complete 2,500 runs! 🥖"
        achievement6.runningValue = 2500
        achievement6.runningProgress = 0.1
        
        let achievement7 = RunningAchievement(context: viewContext)
        achievement7.runningName = "I Promise, I’m Not a Robot..."
        achievement7.runningDescription = "Complete 5,000 runs! 🤖"
        achievement7.runningValue = 5000
        achievement7.runningProgress = 0.1
        
        let achievement8 = RunningAchievement(context: viewContext)
        achievement8.runningName = "Where Is My Freaking Medal?!"
        achievement8.runningDescription = "Complete 10,000 runs! 🥇"
        achievement8.runningValue = 10000
        achievement8.runningProgress = 0.1
        
        let achievement9 = RunningAchievement(context: viewContext)
        achievement9.runningName = "Actually, Where Is My Trophy?!"
        achievement9.runningDescription = "Complete 15,000 runs! 🏆"
        achievement9.runningValue = 15000
        achievement9.runningProgress = 0.1
        
        let achievement10 = RunningAchievement(context: viewContext)
        achievement10.runningName = "Okay, I Deserve a Sponsorship!"
        achievement10.runningDescription = "Complete 25,000 runs! 💰"
        achievement10.runningValue = 25000
        achievement10.runningProgress = 0.1
        
        try? viewContext.save()
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: RunningAchievement.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \RunningAchievement.runningValue, ascending: true)
                  ]
    ) var runningAchievements: FetchedResults<RunningAchievement>

    var body: some View {
        NavigationView {
            List {
                ForEach(runningAchievements, id: \.self) { achievement in
                    DetailView(achievement: achievement)
                }
            }
            .onAppear {
                if runningAchievements.isEmpty {
                    generateAchievements()
                }
            }
            .navigationTitle("Achievements")
        }
    }
}

struct DetailView: View {
    @State private var showActionSheet = false
    @Environment(\.managedObjectContext) var viewContext
    var achievement: RunningAchievement
    var body: some View {
        VStack {
            HStack {
                Text(achievement.wrappedValue)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .background(achievement.runningProgress >= 1 ? Circle().foregroundColor(.yellow).blur(radius:10) : Circle().foregroundColor(.clear).blur(radius:10))
                VStack(alignment: .leading) {
                    Text(achievement.wrappedName)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(achievement.wrappedDescription)
                        .font(.subheadline)
                        .fontWeight(.regular)
                }
                Spacer(minLength: 0)
            }
            .onTapGesture {
                showActionSheet.toggle()
            }
            ProgressView(value: achievement.runningProgress)
            
        }
        .actionSheet(isPresented: $showActionSheet, content: {
            ActionSheet(title: Text("Unlock Achievement?"), message: Text("Are you sure you want to unlock?"), buttons: [.default(Text("Unlock"), action: {
                achievement.runningProgress = 1.0
                try? viewContext.save()
            }),
            .cancel()
            ])
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(achievement: RunningAchievement().makeTestAchivement())
            .previewLayout(.sizeThatFits)
    }
}

