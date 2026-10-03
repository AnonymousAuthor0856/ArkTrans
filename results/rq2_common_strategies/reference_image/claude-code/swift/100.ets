// Colors
const Colors = {
  primaryBlack: '#121212',
  backgroundWhite: '#FFFFFF',
  surfaceGray: '#F5F5F5',
  textSecondary: '#757575',
  accentGreen: '#4CAF50',
  gold: '#FFD700',
}

interface Habit {
  id: number
  icon: string
  title: string
  subtitle: string
  isCompleted: boolean
}

@Component
struct StatsCard {
  build() {
    Column() {
      Text('Overall Progress')
        .fontSize(14)
        .fontColor(Color.White)
        .opacity(0.7)

      Text('85%')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .margin({ top: 8 })

      Row() {
        Text('★')
          .fontSize(16)
          .fontColor(Colors.gold)
        Text('12 Day Streak!')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .margin({ left: 4 })
      }
      .margin({ top: 4 })
    }
    .width('100%')
    .height(140)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(24)
    .backgroundColor(Colors.primaryBlack)
    .borderRadius(24)
  }
}

@Component
struct HabitItem {
  @State icon: string = ''
  @State title: string = ''
  @State subtitle: string = ''
  @State isCompleted: boolean = false

  build() {
    Row() {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(Colors.primaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(Colors.surfaceGray)
      .borderRadius(24)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? Colors.textSecondary : Colors.primaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: Colors.textSecondary
          })

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(Colors.textSecondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

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
      .backgroundColor(this.isCompleted ? Colors.accentGreen : Color.Transparent)
      .border({
        width: 2,
        color: this.isCompleted ? Colors.accentGreen : Colors.surfaceGray,
        style: BorderStyle.Solid
      })
      .borderRadius(16)
      .margin({ left: 8 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: Colors.surfaceGray, style: BorderStyle.Solid })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}

@Entry
@Component
struct HabitTrackerScreen {
  @State habits: Habit[] = [
    { id: 1, icon: '☺', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true },
    { id: 2, icon: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false },
    { id: 3, icon: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false },
    { id: 4, icon: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false },
  ]

  build() {
    Stack() {
      Scroll() {
        Column() {
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.textSecondary)
                .letterSpacing(1)

              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bolder)
                .fontColor(Colors.primaryBlack)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Stack() {
              Text('⚙')
                .fontSize(24)
                .fontColor(Colors.primaryBlack)
            }
            .width(40)
            .height(40)
            .border({ width: 1, color: Colors.surfaceGray, style: BorderStyle.Solid })
            .borderRadius(20)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 24 })

          StatsCard()
            .margin({ top: 32 })

          Text('TODAY\'S GOALS')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.textSecondary)
            .letterSpacing(1.5)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 32 })

          ForEach(this.habits, (habit: Habit) => {
            HabitItem({
              icon: habit.icon,
              title: habit.title,
              subtitle: habit.subtitle,
              isCompleted: habit.isCompleted,
            })
          }, (habit: Habit) => habit.id.toString())

          Column() {
            Text('✓')
              .fontSize(20)
              .fontColor(Colors.textSecondary)

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(Colors.primaryBlack)
              .lineHeight(20)
              .margin({ top: 12 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(20)
          .backgroundColor(Colors.surfaceGray)
          .borderRadius(16)
          .margin({ top: 24 })

          Blank()
            .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.backgroundWhite)
  }
}
