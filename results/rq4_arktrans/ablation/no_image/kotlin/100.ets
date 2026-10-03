@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Column({ space: 0 }) {
          Blank().height(24)

          Row({ space: 0 }) {
            Column({ space: 0 }) {
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
            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#121212')
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .border({ width: 1, color: '#E0E0E0' })
            .backgroundColor(Color.Transparent)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')

          Blank().height(32)

          // StatsCard
          Row({ space: 0 }) {
            Column({ space: 0 }) {
              Text('Overall Progress')
                .fontColor('#B3FFFFFF')
                .fontSize(14)
              Blank().height(8)
              Text('85%')
                .fontColor('#FFFFFF')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
              Blank().height(4)
              Row({ space: 0 }) {
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
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height(140)
          .padding(24)
          .backgroundColor('#121212')
          .borderRadius(24)

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
            .letterSpacing(1.5)
            .width('100%')

          Blank().height(16)

          // HabitItem 1
          this.HabitItemRow(true, 'Morning Meditation', '15 minutes mindfulness')

          // HabitItem 2
          this.HabitItemRow(false, 'Gym Session', 'Upper body workout')

          // HabitItem 3
          this.HabitItemRow(false, 'Learn Spanish', 'Daily lesson completed')

          // HabitItem 4
          this.HabitItemRow(false, 'Drink Water', '2L target')

          Blank().height(24)

          // Bottom Box
          Stack({ alignContent: Alignment.Center }) {
            Column({ space: 0 }) {
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
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

          Blank().height(48)
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .height('100%')
        .padding(24)
      }
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HabitItemRow(isCompleted: boolean, title: string, subtitle: string) {
    Row({ space: 0 }) {
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

      Column({ space: 0 }) {
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
      .backgroundColor(isCompleted ? '#4CAF50' : Color.Transparent)
      .borderRadius(16)
      .border({
        width: 2,
        color: isCompleted ? '#4CAF50' : '#E0E0E0'
      })
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E0E0E0' })
  }
}