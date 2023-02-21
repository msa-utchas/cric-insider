import Foundation

extension Date{
    static func formatDateTimeData(_ dateString: String?) -> (String, String, Date)? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
       
        
        guard let dateString = dateString,
                  let date = dateFormatter.date(from: dateString) else {
                return nil
            }
        let bdTimeZone = TimeZone(identifier: "Asia/Dhaka")
        dateFormatter.timeZone = bdTimeZone
       
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "h:mm a"
        let formattedTime = dateFormatter.string(from: date)
        
        return (formattedDate, formattedTime, date)
    }
}
