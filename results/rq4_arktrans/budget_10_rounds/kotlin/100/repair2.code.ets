@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Column({ space: 24 }) {
          // Header Row
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontColor('#757575')
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
              
              Text('Dec 04')
                .fontSize(24)
                .fontColor('#121212')
                .fontWeight(FontWeight.Bolder)
            }

            Blank()

            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#121212')
            }
            .borderRadius(20)
            .backgroundColor('#FFFFFF')
            .border({ width: 1, color: '#E0E0E0' })
            .width(40)
            .height(40)
            .justifyContent(FlexAlign.Center)
          }.width('100%')

          // Stats Card
          Column() {
            Text('Overall Progress')
              .fontColor('#B3FFFFFF')
              .fontSize(14)
            
            Blank().height(8)
            
            Text('85%')
              .fontColor('#FFFFFF')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
            
            Blank().height(4)
            
            Row() {
              Image($r('app.media.startIcon'))
                .width(16)
                .height(16)
                .fillColor('#FFD700')
              
              Blank().width(4)
              
              Text('12 Day Streak!')
                .fontColor('#FFFFFF')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
          }
          .width('100%')
          .height(140)
          .padding(24)
          .backgroundColor('#121212')
          .borderRadius(24)
          .justifyContent(FlexAlign.Start)

          // Goals Section
          Column() {
            Text("TODAY'S GOALS")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
              .letterSpacing(1.5)
              .width('100%')
            
            Blank().height(16)

            // Habit Item 1 (Completed)
            this.HabitItemRow(
              'Morning Meditation', 
              '15 minutes mindfulness', 
              true
            )

            Blank().height(16)

            // Habit Item 2 (Incomplete)
            this.HabitItemRow(
              'Gym Session', 
              'Upper body workout', 
              false
            )

            Blank().height(16)

            // Habit Item 3 (Incomplete)
            this.HabitItemRow(
              'Learn Spanish', 
              'Daily lesson completed', 
              false
            )
            
            Blank().height(16)

            // Habit Item 4 (Incomplete - inferred from skeleton structure)
            this.HabitItemRow(
              'Drink Water', 
              '2L target', 
              false
            )

            Blank().height(24)

            // Footer Quote
            Column() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor('#757575')
              
              Blank().height(12)
              
              Text('Small steps every day add up to big results over time.')
                .fontSize(14)
                .fontColor('#121212')
                .fontStyle(FontStyle.Italic)
                .lineHeight(20)
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#F5F5F5')
            .borderRadius(16)
            
            Blank().height(48)
          }.width('100%')

        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Start)
        
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }

  @Builder
  HabitItemRow(title: string, subtitle: string, isCompleted: boolean) {
    Row() {
      // Icon Box
      Stack({ alignContent: Alignment.Center }) {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#121212')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)

      Blank().width(16)

      // Text Content
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(isCompleted ? '#757575' : '#121212')
          .decoration({ type: isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })
        
        Blank().height(2)
        
        Text(subtitle)
          .fontSize(12)
          .fontColor('#757575')
      }
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox/Status
      Stack({ alignContent: Alignment.Center }) {
        if (isCompleted) {
          Image($r('app.media.startIcon'))
            .width(18)
            .height(18)
            .fillColor('#FFFFFF')
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(isCompleted ? '#4CAF50' : 'Transparent')
      .border({ 
        width: 2, 
        color: isCompleted ? '#4CAF50' : '#E0E0E0' 
      })

    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E0E0E0' })
    .alignItems(VerticalAlign.Center)
  }
}