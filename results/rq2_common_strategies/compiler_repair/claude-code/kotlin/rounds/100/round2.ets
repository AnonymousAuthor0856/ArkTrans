@Entry
@Component
struct HabitTrackerScreen {
  @State habits: HabitData[] = [
    { icon: '☺', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true },
    { icon: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false },
    { icon: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false },
    { icon: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false },
  ]

  build() {
    Column() {
      Scroll() {
        Column() {
          // Top Bar
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
            .alignItems(HorizontalAlign.Start)

            Stack() {
              Text('⚙')
                .fontSize(20)
                .fontColor('#121212')
            }
            .width(40)
            .height(40)
            .border({ width: 1, color: '#F5F5F5', radius: 20 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 24 })

          // Hero Stats Card
          Row() {
            Column() {
              Text('Overall Progress')
                .fontColor('rgba(255, 255, 255, 0.7)')
                .fontSize(14)

              Text('85%')
                .fontColor(Color.White)
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 8 })

              Row() {
                Text('★')
                  .fontSize(16)
                  .fontColor('#FFD700')
                Text('12 Day Streak!')
                  .fontColor(Color.White)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Center)
              .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
            .height('100%')
          }
          .width('100%')
          .height(140)
          .backgroundColor('#121212')
          .borderRadius(24)
          .padding(24)
          .margin({ top: 32 })

          // Today's Goals header
          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
            .letterSpacing(1.5)
            .width('100%')
            .margin({ top: 32 })

          // Habit List
          ForEach(this.habits, (item: HabitData, index: number) => {
            HabitItem({
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
              isCompleted: item.isCompleted,
              onToggle: () => {
                this.habits[index].isCompleted = !this.habits[index].isCompleted
              }
            })
          }, (item: HabitData) => item.title)

          // Inspiration Box
          Column() {
            Text('✓')
              .fontSize(20)
              .fontColor('#757575')
              .fontWeight(FontWeight.Bold)
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontColor('#121212')
              .fontStyle(FontStyle.Italic)
              .lineHeight(20)
              .margin({ top: 12 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .padding(20)
          .margin({ top: 24, bottom: 48 })
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

interface HabitData {
  icon: string
  title: string
  subtitle: string
  isCompleted: boolean
}

@Component
struct HabitItem {
  @Prop isCompleted: boolean
  icon: string = ''
  title: string = ''
  subtitle: string = ''
  onToggle: () => void = () => {}

  build() {
    Row() {
      // Icon Box
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor('#121212')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? '#757575' : '#121212')
          .decoration({ type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })

        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // Checkbox Button
      Stack() {
        if (this.isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.isCompleted ? '#4CAF50' : Color.Transparent)
      .border({
        width: 2,
        color: this.isCompleted ? '#4CAF50' : '#F5F5F5',
        radius: 16
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.onToggle()
    })
  }
}
