class AppColors {
  static readonly primaryBlack: string = '#121212'
  static readonly backgroundWhite: string = '#FFFFFF'
  static readonly surfaceGray: string = '#F5F5F5'
  static readonly textSecondary: string = '#757575'
  static readonly accentGreen: string = '#4CAF50'
  static readonly gold: string = '#FFD700'
  static readonly clear: string = '#00000000'
}

@Entry
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
                .fontColor(AppColors.textSecondary)

              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.primaryBlack)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Text('⚙')
                .fontSize(24)
                .fontColor(AppColors.primaryBlack)
            }
            .width(40)
            .height(40)
            .border({
              width: 1,
              color: AppColors.surfaceGray,
              radius: 20
            })
            .onClick(() => {
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          StatsCard()

          Blank().height(32)

          Text("TODAY'S GOALS")
            .width('100%')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(AppColors.textSecondary)
            .textAlign(TextAlign.Start)

          Blank().height(16)

          HabitItem({
            icon: '☺',
            title: 'Morning Meditation',
            subtitle: '15 minutes mindfulness',
            isCompleted: true
          })

          HabitItem({
            icon: '▶',
            title: 'Gym Session',
            subtitle: 'Upper body workout',
            isCompleted: false
          })

          HabitItem({
            icon: '★',
            title: 'Learn Spanish',
            subtitle: 'Daily lesson completed',
            isCompleted: false
          })

          HabitItem({
            icon: '♥',
            title: 'Drink Water',
            subtitle: '2L target',
            isCompleted: false
          })

          Blank().height(24)

          Column() {
            Text('✓')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.textSecondary)

            Blank().height(12)

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(AppColors.primaryBlack)
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(20)
          .backgroundColor(AppColors.surfaceGray)
          .borderRadius(16)

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
    .backgroundColor(AppColors.backgroundWhite)
  }
}

@Component
struct StatsCard {
  build() {
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
            .fontColor(AppColors.gold)

          Blank().width(4)

          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.primaryBlack)
    .borderRadius(24)
  }
}

@Component
struct HabitItem {
  icon: string = ''
  title: string = ''
  subtitle: string = ''
  @State isCompleted: boolean = false

  build() {
    Row() {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(AppColors.primaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(AppColors.surfaceGray)
      .borderRadius(24)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? AppColors.textSecondary : AppColors.primaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: AppColors.textSecondary
          })

        Blank().height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(AppColors.textSecondary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(8)

      Stack() {
        if (this.isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.isCompleted ? AppColors.accentGreen : AppColors.clear)
      .borderRadius(16)
      .border({
        width: 2,
        color: this.isCompleted ? AppColors.accentGreen : AppColors.surfaceGray,
        radius: 16
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({
      width: 1,
      color: AppColors.surfaceGray,
      radius: 16
    })
    .margin({
      top: 8,
      bottom: 8
    })
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}