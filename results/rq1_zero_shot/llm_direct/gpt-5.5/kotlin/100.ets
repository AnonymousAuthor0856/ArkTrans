const PrimaryBlack: string = '#121212'
const BackgroundWhite: string = '#FFFFFF'
const SurfaceGray: string = '#F5F5F5'
const TextSecondary: string = '#757575'
const AccentGreen: string = '#4CAF50'
const Gold: string = '#FFD700'

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Scroll() {
      Column() {
        Blank()
          .height(24)

        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontColor(TextSecondary)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)

            Text('Dec 04')
              .fontSize(24)
              .fontColor(PrimaryBlack)
              .fontWeight(FontWeight.Bolder)
          }
          .alignItems(HorizontalAlign.Start)

          Button({ type: ButtonType.Circle }) {
            Text('⚙')
              .fontSize(20)
              .fontColor(PrimaryBlack)
          }
          .width(40)
          .height(40)
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: SurfaceGray,
            radius: 20
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank()
          .height(32)

        StatsCard()

        Blank()
          .height(32)

        Text("TODAY'S GOALS")
          .width('100%')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(1.5)
          .textAlign(TextAlign.Start)

        Blank()
          .height(16)

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

        Blank()
          .height(24)

        Column() {
          Text('✓')
            .fontSize(20)
            .fontColor(TextSecondary)

          Blank()
            .height(12)

          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(PrimaryBlack)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(20)
        .backgroundColor(SurfaceGray)
        .borderRadius(16)

        Blank()
          .height(48)
      }
      .width('100%')
      .minHeight('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
    .scrollBar(BarState.Off)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('#B3FFFFFF')
          .fontSize(14)

        Blank()
          .height(8)

        Text('85%')
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)

        Blank()
          .height(4)

        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(Gold)

          Blank()
            .width(4)

          Text('12 Day Streak!')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(PrimaryBlack)
    .borderRadius(24)
  }
}

@Component
struct HabitItem {
  icon: string = ''
  title: string = ''
  subtitle: string = ''
  isCompleted: boolean = false

  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.isCompleted
  }

  build() {
    Row() {
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(PrimaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(SurfaceGray)
      .borderRadius(24)

      Blank()
        .width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TextSecondary : PrimaryBlack)
          .decoration({
            type: this.checked ? TextDecorationType.LineThrough : TextDecorationType.None
          })

        Blank()
          .height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(8)

      Stack() {
        if (this.checked) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.checked ? AccentGreen : Color.Transparent)
      .border({
        width: 2,
        color: this.checked ? AccentGreen : SurfaceGray,
        radius: 16
      })
    }
    .width('100%')
    .padding(16)
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .border({
      width: 1,
      color: SurfaceGray,
      radius: 16
    })
    .onClick(() => {
      this.checked = !this.checked
    })
  }
}