//
//  CardView.swift
//  zakfit
//
//  Created by alize suchon on 30/11/2025.
//

import SwiftUI

struct CardView: View {
    
    @State var activity: ActivityResponse
    private var dateString: String {
            let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
            return dateFormatter.string(from: activity.date)
        }

    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .foregroundColor(.bleuC)
                    .frame(height: 95)
                    .cornerRadius(15)
                
                HStack(spacing: 10){
                    //PICTO
                    ZStack{
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.bleu)
                        AsyncImage(url: URL(string: "http://127.0.0.1:8080/activity/\(activity.categoryPicto)")) { picto in picto
                                .resizable()
                                .frame(width: 30, height: 30)
                        } placeholder: {
                            ProgressView()
                                .frame(height: 20)
                        }
                    }
                    
                    //TYPE ACTIVITY
                    VStack (alignment: .leading){
                        Text(activity.categoryName)
                            .font(.custom("Parkinsans-SemiBold", size: 16 ))
                       
                        HStack(spacing: 10){
                            
                            //Calories brûlées
                            HStack(spacing: 5){
                                Image("eclair-fill")
                                    .resizable()
                                    .frame(width: 13, height: 18)
                                Text("\(activity.caloriesBurned) kcals")
                            }
                            
                            //Durée
                            HStack(spacing: 5){
                                Image("clock-fill")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text("\(activity.duration)min")
                            }
                            
                            //Date
                            HStack(spacing: 5){
                                Image("calendar-fill")
                                    .resizable()
                                    .frame(width: 18, height: 19)
                                Text(dateString)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        //.padding(.horizontal, 17)
    }
}

#Preview {
    let activityForPreview = ActivityResponse(
          id: UUID(),
          duration: 145,
          caloriesBurned: 300,
          date: Date(),
          categoryId: UUID(),
          categoryName: "Cyclisme",
          categoryPicto: "run.png",
          categoryColor: "bleu"
          
      )
    CardView(activity: activityForPreview)
}
