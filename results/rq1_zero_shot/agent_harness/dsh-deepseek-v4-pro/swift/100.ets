// Translated from 100.swift (Habit Tracker App)

@Entry
@Component
struct Index {
  build() {
    HabitTrackerScreen()
  }
}

@Component
struct HabitTrackerScreen {
  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank().height(24)

          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .fontColor('#757575')
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bolder)
                .fontColor('#121212')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor('#121212')
                .width(24)
                .height(24)
            }
            .width(40)
            .height(40)
            .backgroundColor('#00000000')
            .border({ width: 1, color: '#F5F5F5', radius: 20 })
            .onClick(() => {})
          }
          .width('100%')

          Blank().height(32)

          StatsCard()

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor('#757575')
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          HabitItem({ iconName: '😊', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true })
          HabitItem({ iconName: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false })
          HabitItem({ iconName: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false })
          HabitItem({ iconName: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false })

          Blank().height(24)

          Column() {
            Text('✅')
              .fontSize(20)
              .fontColor('#757575')
            Blank().height(12)
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor('#121212')
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .width('100%')
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

          Blank().height(48)
        }
        .padding(24)
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('#FFFFFF')
          .opacity(0.7)
          .fontSize(14)
        Blank().height(8)
        Text('85%')
          .fontColor('#FFFFFF')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(16)
            .fontColor('#FFD700')
          Blank().width(4)
          Text('12 Day Streak!')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .height(140)
    .backgroundColor('#121212')
    .borderRadius(24)
    .padding(24)
  }
}

@Component
struct HabitItem {
  @Prop iconName: string = ''
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @State isCompleted: boolean = false

  build() {
    Row() {
      Stack() {
        Circle()
          .fill('#F5F5F5')
          .width(48)
          .height(48)
        Text(this.iconName)
          .fontSize(24)
          .fontColor('#121212')
      }
      .width(48)
      .height(48)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? '#757575' : '#121212')
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: '#757575'
          })
        Blank().height(2)
        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#757575')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      Stack() {
        Circle()
          .fill(this.isCompleted ? '#4CAF50' : '#00000000')
          .width(32)
          .height(32)
        Circle()
          .fillOpacity(0)
          .stroke(this.isCompleted ? '#4CAF50' : '#F5F5F5')
          .strokeWidth(2)
          .width(32)
          .height(32)
        if (this.isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontColor('#FFFFFF')
        }
      }
      .width(32)
      .height(32)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .padding({ top: 8, bottom: 8 })
    .onClick(() => { this.isCompleted = !this.isCompleted })
  }
}
