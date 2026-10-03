class AppTokens {
  static readonly Colors = {
    primaryBlack: '#FF121212',
    backgroundWhite: '#FFFFFFFF',
    surfaceGray: '#FFF5F5F5',
    textSecondary: '#FF757575',
    accentGreen: '#FF4CAF50',
    white70: '#B3FFFFFF',
    white: '#FFFFFFFF',
    gold: '#FFFFD700',
    transparent: '#00000000'
  }
}

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.textSecondary)
              .letterSpacing(1)
            Text('Dec 04')
              .fontSize(24)
              .fontWeight(FontWeight.Bolder)
              .fontColor(AppTokens.Colors.primaryBlack)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Row() {
            Text('⚙')
              .fontSize(24)
              .fontColor(AppTokens.Colors.primaryBlack)
          }
          .width(40)
          .height(40)
          .border({ width: 1, color: AppTokens.Colors.surfaceGray })
          .borderRadius(20)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        Row() {
          Column() {
            Text('Overall Progress')
              .fontSize(14)
              .fontColor(AppTokens.Colors.white70)
            Text('85%')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.white)
              .margin({ top: 8 })
            Row() {
              Text('★')
                .fontSize(16)
                .fontColor(AppTokens.Colors.gold)
              Text('12 Day Streak!')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.white)
                .margin({ left: 4 })
            }
            .alignItems(VerticalAlign.Center)
            .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(140)
        .padding(24)
        .borderRadius(24)
        .backgroundColor(AppTokens.Colors.primaryBlack)
        .margin({ top: 32 })

        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.textSecondary)
          .letterSpacing(1.5)
          .width('100%')
          .margin({ top: 32 })

        HabitItem({ icon: '☺', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true })
          .margin({ top: 16 })
        HabitItem({ icon: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false })
        HabitItem({ icon: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false })
        HabitItem({ icon: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false })

        Column() {
          Text('✓')
            .fontSize(20)
            .fontColor(AppTokens.Colors.textSecondary)
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(AppTokens.Colors.primaryBlack)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
            .margin({ top: 12 })
        }
        .width('100%')
        .padding(20)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.surfaceGray)
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 24 })
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct HabitItem {
  @Prop icon: string
  @Prop title: string
  @Prop subtitle: string
  @Prop isCompleted: boolean
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.isCompleted
  }

  build() {
    Row() {
      Row() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(AppTokens.Colors.primaryBlack)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(AppTokens.Colors.surfaceGray)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? AppTokens.Colors.textSecondary : AppTokens.Colors.primaryBlack)
          .decoration(this.checked ? { type: TextDecorationType.LineThrough } : { type: TextDecorationType.None })
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(AppTokens.Colors.textSecondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Row() {
        if (this.checked) {
          Text('✓')
            .fontSize(18)
            .fontColor(AppTokens.Colors.white)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.checked ? AppTokens.Colors.accentGreen : AppTokens.Colors.transparent)
      .border({ width: 2, color: this.checked ? AppTokens.Colors.accentGreen : AppTokens.Colors.surfaceGray })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(AppTokens.Colors.backgroundWhite)
    .border({ width: 1, color: AppTokens.Colors.surfaceGray })
    .alignItems(VerticalAlign.Center)
    .margin({ top: 8 })
    .onClick(() => {
      this.checked = !this.checked
    })
  }
}