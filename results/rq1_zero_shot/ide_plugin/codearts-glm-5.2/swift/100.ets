class HtColors {
  static readonly primaryBlack: string = '#FF121212'
  static readonly white: string = '#FFFFFFFF'
  static readonly surfaceGray: string = '#FFF5F5F5'
  static readonly textSecondary: string = '#FF757575'
  static readonly accentGreen: string = '#FF4CAF50'
  static readonly gold: string = '#FFFFD700'
  static readonly white70: string = '#B3FFFFFF'
}

@Entry
@Component
struct Index {
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
                .fontColor(HtColors.textSecondary)
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Black)
                .fontColor(HtColors.primaryBlack)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Text('⚙')
              .fontSize(24)
              .fontColor(HtColors.primaryBlack)
              .width(40)
              .height(40)
              .textAlign(TextAlign.Center)
              .border({ width: 1, color: HtColors.surfaceGray, radius: 20 })
          }

          Blank().height(32)

          Row() {
            Column() {
              Text('Overall Progress')
                .fontSize(14)
                .fontColor(HtColors.white70)

              Text('85%')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .fontColor(HtColors.white)
                .margin({ top: 8 })

              Row() {
                Text('★')
                  .fontSize(16)
                  .fontColor(HtColors.gold)
                Text('12 Day Streak!')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(HtColors.white)
                  .margin({ left: 4 })
              }
              .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .height(140)
          .padding(24)
          .backgroundColor(HtColors.primaryBlack)
          .borderRadius(24)

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(HtColors.textSecondary)

          Blank().height(16)

          HabitItem({ iconName: '☺', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true })
          HabitItem({ iconName: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false })
          HabitItem({ iconName: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false })
          HabitItem({ iconName: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false })

          Blank().height(24)

          Column() {
            Text('☑')
              .fontSize(20)
              .fontColor(HtColors.textSecondary)

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontColor(HtColors.primaryBlack)
              .fontStyle(FontStyle.Italic)
              .lineHeight(20)
              .margin({ top: 12 })
          }
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .backgroundColor(HtColors.surfaceGray)
          .borderRadius(16)

          Blank().height(48)
        }
        .padding(24)
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
    }
    .backgroundColor(HtColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct HabitItem {
  @Prop iconName: string = ''
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isCompleted: boolean = false
  @State completed: boolean = false

  aboutToAppear() {
    this.completed = this.isCompleted
  }

  build() {
    Row() {
      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(HtColors.surfaceGray)
        Text(this.iconName)
          .fontSize(24)
          .fontColor(HtColors.primaryBlack)
      }

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.completed ? HtColors.textSecondary : HtColors.primaryBlack)
          .decoration({ type: this.completed ? TextDecorationType.LineThrough : TextDecorationType.None })
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(HtColors.textSecondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      Stack() {
        Circle({ width: 32, height: 32 })
          .fill(this.completed ? HtColors.accentGreen : '#00000000')
          .border({ width: 2, color: this.completed ? HtColors.accentGreen : HtColors.surfaceGray })

        if (this.completed) {
          Text('✓')
            .fontSize(18)
            .fontColor(HtColors.white)
        }
      }
    }
    .padding(16)
    .backgroundColor(HtColors.white)
    .borderRadius(16)
    .border({ width: 1, color: HtColors.surfaceGray })
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.completed = !this.completed
    })
  }
}