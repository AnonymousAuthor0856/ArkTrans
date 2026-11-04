class HabitData {
  id: number
  icon: string
  title: string
  subtitle: string
  completed: boolean

  constructor(id: number, icon: string, title: string, subtitle: string, completed: boolean) {
    this.id = id
    this.icon = icon
    this.title = title
    this.subtitle = subtitle
    this.completed = completed
  }
}

@Entry
@Component
struct Index {
  @State h1: boolean = true
  @State h2: boolean = false
  @State h3: boolean = false
  @State h4: boolean = false

  private habits: HabitData[] = [
    new HabitData(1, '☺', 'Morning Meditation', '15 minutes mindfulness', true),
    new HabitData(2, '▶', 'Gym Session', 'Upper body workout', false),
    new HabitData(3, '★', 'Learn Spanish', 'Daily lesson completed', false),
    new HabitData(4, '♥', 'Drink Water', '2L target', false)
  ]

  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
            Text('Dec 04')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#121212')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Button('⚙')
            .fontSize(22)
            .fontColor('#121212')
            .width(40)
            .height(40)
            .border({ width: 1, color: '#F5F5F5', radius: 20 })
            .backgroundColor(Color.Transparent)
            .padding(0)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        this.StatsCard()

        Text('TODAY\'S GOALS')
          .width('100%')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .margin({ top: 32, bottom: 16 })

        ForEach(this.habits, (habit: HabitData) => {
          this.HabitItem(habit)
        })

        Column() {
          Text('●')
            .fontSize(20)
            .fontColor('#757575')
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontStyle(FontStyle.Italic)
            .fontColor('#121212')
            .lineHeight(20)
            .margin({ top: 12 })
        }
        .width('100%')
        .padding(20)
        .borderRadius(16)
        .backgroundColor('#F5F5F5')
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 24, bottom: 48 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  StatsCard() {
    Column() {
      Text('Overall Progress')
        .fontSize(14)
        .fontColor('rgba(255,255,255,0.7)')
      Text('85%')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .margin({ top: 8 })
      Row() {
        Text('★')
          .fontSize(16)
          .fontColor('#FFD700')
        Text('12 Day Streak!')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 4 })
    }
    .width('100%')
    .height(140)
    .padding(24)
    .borderRadius(24)
    .backgroundColor('#121212')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 })
  }

  @Builder
  HabitItem(habit: HabitData) {
    Row() {
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
        Text(habit.icon)
          .fontSize(24)
          .fontColor('#121212')
      }
      .width(48)
      .height(48)

      Column() {
        Text(habit.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isDone(habit.id) ? '#757575' : '#121212')
          .decoration({ type: this.isDone(habit.id) ? TextDecorationType.LineThrough : TextDecorationType.None })
        Text(habit.subtitle)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isDone(habit.id) ? '#4CAF50' : Color.Transparent)
          .stroke(this.isDone(habit.id) ? '#4CAF50' : '#F5F5F5')
          .strokeWidth(2)
        if (this.isDone(habit.id)) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .backgroundColor(Color.White)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.toggleHabit(habit.id)
    })
  }

  isDone(id: number): boolean {
    if (id === 1) { return this.h1 }
    if (id === 2) { return this.h2 }
    if (id === 3) { return this.h3 }
    return this.h4
  }

  toggleHabit(id: number): void {
    if (id === 1) {
      this.h1 = !this.h1
    } else if (id === 2) {
      this.h2 = !this.h2
    } else if (id === 3) {
      this.h3 = !this.h3
    } else {
      this.h4 = !this.h4
    }
  }
}
