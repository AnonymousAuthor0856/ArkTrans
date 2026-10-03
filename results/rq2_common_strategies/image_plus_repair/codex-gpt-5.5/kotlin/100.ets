interface Colors {
  black: string
  white: string
  gray: string
  lightGray: string
  border: string
  green: string
}

const COLORS: Colors = {
  black: '#121212',
  white: '#FFFFFF',
  gray: '#757575',
  lightGray: '#F5F5F5',
  border: '#EEEEEE',
  green: '#4CAF50'
}

interface Habit {
  icon: string
  title: string
  subtitle: string
  completed: boolean
}

@Entry
@Component
struct MainPage {
  @State habits: Habit[] = [
    {
      icon: '◕',
      title: 'Morning Meditation',
      subtitle: '15 minutes mindfulness',
      completed: true
    },
    {
      icon: '▶',
      title: 'Gym Session',
      subtitle: 'Upper body workout',
      completed: false
    },
    {
      icon: '★',
      title: 'Learn Spanish',
      subtitle: 'Daily lesson completed',
      completed: false
    },
    {
      icon: '♥',
      title: 'Drink Water',
      subtitle: '2L target',
      completed: false
    }
  ]

  build() {
    Scroll() {
      Column() {
        this.header()
        this.progressCard()
        this.goals()
        this.inspiration()
        Blank().height(48)
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 110, bottom: 0 })
    }
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .backgroundColor(COLORS.white)
    .edgeEffect(EdgeEffect.Spring)
    .scrollBar(BarState.Off)
  }

  @Builder
  header() {
    Row() {
      Column() {
        Text('THURSDAY')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.gray)
          .letterSpacing(2)
          .width('100%')
        Text('Dec 04')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Stack() {
        Text('⚙')
          .fontSize(35)
          .fontColor(COLORS.black)
          .fontWeight(FontWeight.Bold)
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .border({ width: 2, color: COLORS.lightGray })
      .alignContent(Alignment.Center)
      .onClick(() => {
        // Settings is intentionally visual, matching the source screen.
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  progressCard() {
    Column() {
      Text('Overall Progress')
        .fontSize(28)
        .fontColor('#B8B8B8')
        .fontWeight(FontWeight.Medium)
        .width('100%')
      Text('85%')
        .fontSize(76)
        .fontColor(COLORS.white)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 28 })
        .width('100%')
    }
    .width('100%')
    .height(280)
    .padding({ left: 48, right: 48, top: 54 })
    .backgroundColor(COLORS.black)
    .borderRadius(48)
    .margin({ top: 72 })
  }

  @Builder
  goals() {
    Column() {
      Text("TODAY'S GOALS")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.gray)
        .letterSpacing(3)
        .width('100%')
        .margin({ bottom: 44 })

      ForEach(this.habits, (habit: Habit, index: number) => {
        this.habitItem(habit, index)
      }, (habit: Habit, index: number) => `${habit.title}-${index}`)
    }
    .width('100%')
    .margin({ top: 76 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  habitItem(habit: Habit, index: number) {
    Row() {
      Stack() {
        Text(habit.icon)
          .fontSize(habit.icon === '◕' ? 38 : 32)
          .fontColor(COLORS.black)
          .fontWeight(FontWeight.Bold)
      }
      .width(96)
      .height(96)
      .borderRadius(48)
      .backgroundColor(COLORS.lightGray)
      .alignContent(Alignment.Center)

      Column() {
        Text(habit.title)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(habit.completed ? COLORS.gray : COLORS.black)
          .decoration({
            type: habit.completed ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: COLORS.gray
          })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')

        Text(habit.subtitle)
          .fontSize(24)
          .fontColor(COLORS.gray)
          .margin({ top: 18 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 32, right: 20 })

      Stack() {
        if (habit.completed) {
          Text('✓')
            .fontSize(34)
            .fontColor(COLORS.white)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .backgroundColor(habit.completed ? COLORS.green : COLORS.white)
      .border({
        width: habit.completed ? 0 : 4,
        color: habit.completed ? COLORS.green : COLORS.lightGray
      })
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .height(162)
    .padding({ left: 32, right: 32 })
    .borderRadius(32)
    .border({ width: 2, color: COLORS.border })
    .backgroundColor(COLORS.white)
    .margin({ bottom: 32 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      const next = this.habits.slice()
      next[index].completed = !next[index].completed
      this.habits = next
    })
  }

  @Builder
  inspiration() {
    Column() {
      Text('✓')
        .fontSize(26)
        .fontColor(COLORS.gray)
        .fontWeight(FontWeight.Bold)
      Text('Small steps every day add up to big results over time.')
        .fontSize(23)
        .fontColor(COLORS.black)
        .fontStyle(FontStyle.Italic)
        .lineHeight(32)
        .margin({ top: 18 })
        .width('100%')
    }
    .width('100%')
    .padding(32)
    .backgroundColor(COLORS.lightGray)
    .borderRadius(32)
    .margin({ top: 8 })
    .alignItems(HorizontalAlign.Start)
  }
}
