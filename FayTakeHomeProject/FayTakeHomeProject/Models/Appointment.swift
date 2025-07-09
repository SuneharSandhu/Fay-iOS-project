import Foundation

struct AppointmentsResponse: Codable {
    let appointments: [Appointment]
}

struct Appointment: Codable, Identifiable {
    let appointment_id: String
    let patient_id: String
    let provider_id: String
    let status: String
    let appointment_type: String
    let start: String
    let end: String
    let duration_in_minutes: Int
    let recurrence_type: String
    
    var id: String { appointment_id }
    
    var startDate: Date {
        return (try? Date(start, strategy: .iso8601)) ?? Date()
    }
    
    var endDate: Date {
        return (try? Date(end, strategy: .iso8601)) ?? Date()
    }
    
    var isUpcoming: Bool {
        return Date() < endDate
    }
    
    var isPast: Bool {
        return Date() > endDate
    }
    
    var formattedStartTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: startDate)
    }
    
    var formattedEndTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: endDate)
    }
    
    var formattedTimeRange: String {
        let timeZoneAbbreviation = TimeZone.current.abbreviation() ?? ""
        return "\(formattedStartTime) - \(formattedEndTime) (\(timeZoneAbbreviation))"
    }
    
    var formattedStartHour: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter.string(from: startDate)
    }
}
