const PRIMARY_BLACK: string = '#121212'
const BACKGROUND_WHITE: string = '#FFFFFF'
const SURFACE_GRAY: string = '#F5F5F5'
const TEXT_SECONDARY: string = '#757575'
const ACCENT_GREEN: string = '#4CAF50'
const GOLD: string = '#FFD700'

@Entry
@Component
struct HabitTrackerScreen {
  @State meditationDone: boolean = true
  @State gymDone: boolean = false
  @State spanishDone: boolean = false
  @State waterDone: boolean = false

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('THURSDAY')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(TEXT_SECONDARY)
        Text('Dec 04')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Text('⚙')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
          .textAlign(TextAlign.Center)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .border({ width: 1, color: SURFACE_GRAY })
      .backgroundColor(BACKGROUND_WHITE)
    }
    .width('100%')
    .height(48)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatsCard() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor('rgba(255, 255, 255, 0.70)')
        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 8 })
        Row() {
          Text('★')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(GOLD)
            .width(22)
            .height(22)
            .textAlign(TextAlign.Center)
          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .margin({ left: 4 })
        }
        .height(24)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(24)
  }

  @Builder
  GoalIcon(icon: string) {
    Stack() {
      Text(icon)
        .fontSize(icon === '▶' ? 28 : 26)
        .fontWeight(FontWeight.Bold)
        .fontColor(PRIMARY_BLACK)
        .textAlign(TextAlign.Center)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor(SURFACE_GRAY)
  }

  @Builder
  CheckButton(isCompleted: boolean) {
    Stack() {
      if (isCompleted) {
        Text('✓')
          .fontSize(31)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .translate({ y: -1 })
      }
    }
    .width(34)
    .height(34)
    .borderRadius(17)
    .backgroundColor(isCompleted ? ACCENT_GREEN : Color.Transparent)
    .border({ width: 2, color: isCompleted ? ACCENT_GREEN : SURFACE_GRAY })
  }

  @Builder
  HabitItem(icon: string, title: string, subtitle: string, isCompleted: boolean, index: number) {
    Row() {
      this.GoalIcon(icon)

      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(isCompleted ? TEXT_SECONDARY : PRIMARY_BLACK)
          .decoration({
            type: isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: TEXT_SECONDARY
          })
          .maxLines(1)
        Text(subtitle)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
          .margin({ top: 2 })
          .maxLines(1)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16, right: 8 })

      this.CheckButton(isCompleted)
    }
    .width('100%')
    .height(80)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: SURFACE_GRAY })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      if (index === 0) {
        this.meditationDone = !this.meditationDone
      } else if (index === 1) {
        this.gymDone = !this.gymDone
      } else if (index === 2) {
        this.spanishDone = !this.spanishDone
      } else {
        this.waterDone = !this.waterDone
      }
    })
  }

  @Builder
  Inspiration() {
    Column() {
      Text('✓')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width(20)
        .height(20)
        .textAlign(TextAlign.Center)
        .backgroundColor(TEXT_SECONDARY)
        .borderRadius(10)
      Text('Small steps every day add up to big results over time.')
        .fontSize(14)
        .fontStyle(FontStyle.Italic)
        .fontColor(PRIMARY_BLACK)
        .lineHeight(20)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(SURFACE_GRAY)
    .borderRadius(16)
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          this.TopBar()

          Row() {
            this.StatsCard()
          }
          .width('100%')
          .margin({ top: 32 })

          Text('TODAY\'S GOALS')
            .width('100%')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(TEXT_SECONDARY)
            .textAlign(TextAlign.Start)
            .margin({ top: 32, bottom: 16 })

          this.HabitItem('☻', 'Morning Meditation', '15 minutes mindfulness', this.meditationDone, 0)
          this.HabitItem('▶', 'Gym Session', 'Upper body workout', this.gymDone, 1)
          this.HabitItem('★', 'Learn Spanish', 'Daily lesson completed', this.spanishDone, 2)
          this.HabitItem('♥', 'Drink Water', '2L target', this.waterDone, 3)

          Row() {
            this.Inspiration()
          }
          .width('100%')
          .margin({ top: 16 })

          Blank()
            .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
  }
}
