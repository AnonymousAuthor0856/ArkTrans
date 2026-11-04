@Entry
@Component
struct Index {
  @State meditationDone: boolean = true
  @State gymDone: boolean = false
  @State spanishDone: boolean = false
  @State waterDone: boolean = false

  private readonly primaryBlack: string = '#121212'
  private readonly backgroundWhite: string = '#FFFFFF'
  private readonly surfaceGray: string = '#F5F5F5'
  private readonly textSecondary: string = '#757575'
  private readonly accentGreen: string = '#4CAF50'
  private readonly gold: string = '#FFD700'

  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank().height(24)
          this.TopBar()
          Blank().height(32)
          this.StatsCard()
          Blank().height(32)
          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(this.textSecondary)
            .width('100%')
          Blank().height(16)
          this.HabitItem('☻', 'Morning Meditation', '15 minutes mindfulness', this.meditationDone, 'meditation')
          this.HabitItem('▶', 'Gym Session', 'Upper body workout', this.gymDone, 'gym')
          this.HabitItem('★', 'Learn Spanish', 'Daily lesson completed', this.spanishDone, 'spanish')
          this.HabitItem('♥', 'Drink Water', '2L target', this.waterDone, 'water')
          Blank().height(24)
          this.InspirationCard()
          Blank().height(48)
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundWhite)
  }

  private toggleHabit(kind: string): void {
    if (kind === 'meditation') {
      this.meditationDone = !this.meditationDone
    } else if (kind === 'gym') {
      this.gymDone = !this.gymDone
    } else if (kind === 'spanish') {
      this.spanishDone = !this.spanishDone
    } else if (kind === 'water') {
      this.waterDone = !this.waterDone
    }
  }

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('THURSDAY')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(this.textSecondary)
        Text('Dec 04')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(this.primaryBlack)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(this.primaryBlack)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(Color.White)
      .border({ width: 1, color: this.surfaceGray })
    }
    .width('100%')
  }

  @Builder
  StatsCard() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor('#B3FFFFFF')
        Blank().height(8)
        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(this.gold)
          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .margin({ left: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor(this.primaryBlack)
    .borderRadius(24)
  }

  @Builder
  HabitItem(iconName: string, title: string, subtitle: string, isCompleted: boolean, kind: string) {
    Row() {
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(this.surfaceGray)
        Text(iconName)
          .fontSize(24)
          .fontColor(this.primaryBlack)
      }
      .width(48)
      .height(48)
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(isCompleted ? this.textSecondary : this.primaryBlack)
          .decoration({ type: isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None, color: this.textSecondary })
        Text(subtitle)
          .fontSize(12)
          .fontColor(this.textSecondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16, right: 8 })
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(isCompleted ? this.accentGreen : Color.Transparent)
          .stroke(isCompleted ? this.accentGreen : this.surfaceGray)
          .strokeWidth(2)
        if (isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: this.surfaceGray })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.toggleHabit(kind)
    })
  }

  @Builder
  InspirationCard() {
    Column() {
      Text('✓')
        .fontSize(20)
        .fontColor(this.textSecondary)
      Blank().height(12)
      Text('Small steps every day add up to big results over time.')
        .fontSize(14)
        .fontStyle(FontStyle.Italic)
        .fontColor(this.primaryBlack)
        .lineHeight(20)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(this.surfaceGray)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }
}