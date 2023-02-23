//
//  HomeViewModel.swift
//  CricInsider
//
//  Created by BJIT on 15/2/23.
//

import Foundation
import Combine
import UserNotifications

class HomeViewModel{
    private var fixtureMatchListRepository: FixtureMatchesListRepository
    private var dateWiseMatchRepository: DateWiseMatchRepository
    @Published var upcomingMatches: [UpcomingMatchModel] = []
    @Published var finishedMatches:[FinishedMatchesModel] = []
    @Published var upcomingMatchSelectedID : Int?
    @Published var finishedMatchSelectedID : Int?
    
    
    var timer: Timer?
    
    
    init(fixtureMatchListRepository: FixtureMatchesListRepository =  FixturesRepository(),dateWiseMatchRepository: DateWiseMatchRepository = FixturesRepository()) {
        self.fixtureMatchListRepository = fixtureMatchListRepository
        self.dateWiseMatchRepository = dateWiseMatchRepository
    }
    
    func setupNotificationForUpcomingMatches() async {
        let data = await dateWiseMatchRepository.getDateWiseMatches(date: Date())
        
        switch data{
        case .success(let data):
            await setUpNotification(data: data)
            
        case .failure(_):
            print("hello")
        }
    }
    
    func getUpcomingMatches() async {
        let data = await fixtureMatchListRepository.getUpcomingMatches()
        switch data{
        case .success(let data):
            upcomingMatches = data
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
        
    }
    func getFinishedMatches() async {
        let data = await fixtureMatchListRepository.getFinishedMatches()
        switch data{
        case .success(let data):
            finishedMatches = data
        case .failure(let error):
            debugPrint(error.localizedDescription)
        }
        
    }
    func setCollectionViewSelectedIndex(fixtureId: Int){
        upcomingMatchSelectedID = fixtureId
    }
    func setTableViewSelectedIndex(fixtureId: Int){
        finishedMatchSelectedID = fixtureId
    }
    
    func setUpNotification(data: [MatchInfoModel]) async{
      
        for match in data{
            if match.status == "NS"{
                let content = UNMutableNotificationContent()
                content.title = "Match Reminder"
                content.body = "Match between \(match.localTeamName ?? "N\\A") vs \(match.visitorTeamName ?? "N\\A") is starting in 30 minutes"
                content.sound = UNNotificationSound.default
                guard let matchStartTime = match.dateObject else {return}
                let date = Calendar.current.date(byAdding: .minute, value: -30, to: matchStartTime)
                let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date!)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                let notificationCenter = UNUserNotificationCenter.current()
                do{
                    try await notificationCenter.add(request)
                    UserDefaults.standard.set(date, forKey: "Notification-Setup-Time")

                } catch {
                    print((error.localizedDescription))
                }

            }
        }
    }
    
    func updateTimeRemaining(matchStartTime: Date)->String {
           // Calculate the time remaining
           let timeRemaining = matchStartTime.timeIntervalSinceNow
       
           // Update the cell with the time remaining
           let formatter = DateComponentsFormatter()
           formatter.allowedUnits = [.day, .hour, .minute, .second]
           formatter.unitsStyle = .abbreviated
           let timeRemainingString = formatter.string(from: timeRemaining)!
           return "Match Starts In: " + timeRemainingString
       }
    
}
