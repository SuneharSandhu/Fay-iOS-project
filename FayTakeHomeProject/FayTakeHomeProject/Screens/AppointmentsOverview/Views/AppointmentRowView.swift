import SwiftUI

struct AppointmentRowView: View {
    
    let appointment: Appointment
    let isFirstUpcoming: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                VStack(spacing: 0) {
                    Text(appointment.startDate.formatted(.dateTime.month(.abbreviated)))
                        .padding(.top, 2)
                        .frame(maxWidth: .infinity)
                        .font(.caption)
                        .foregroundStyle(appointment.isUpcoming ? .accent : .primary)
                        .background(appointment.isUpcoming ? Color.calendarUpcomingHeader : Color.calendarPastHeader)
                    Text(appointment.startDate.formatted(.dateTime.day()))
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .background(Color.calendarBackground)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .frame(width: 48, height: 48)
                .clipShape(.rect(cornerRadius: 4))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(isFirstUpcoming ? appointment.formattedTimeRange : appointment.formattedStartHour)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text("Follow up \(isFirstUpcoming ? "with Jane Williams, RD" : "")")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            if isFirstUpcoming {
                FayPrimaryButton(
                    title: "Join appointment",
                    icon: "videocamera",
                    isFullWidth: true,
                    onTap: {}
                )
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(!isFirstUpcoming ? .gray.opacity(0.5) : Color.clear, lineWidth: 1)
        }
        .background(.white)
        .cornerRadius(16)
        .shadow(
            color: .black.opacity(0.1),
            radius: isFirstUpcoming ? 12 : 0,
            x: 0,
            y: isFirstUpcoming ? 4 : 0
        )
    }
}
