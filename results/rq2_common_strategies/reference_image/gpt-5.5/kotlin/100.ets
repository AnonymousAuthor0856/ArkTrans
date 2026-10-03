const PrimaryBlack: string = '#121212'
const BackgroundWhite: string = '#FFFFFF'
const SurfaceGray: string = '#F5F5F5'
const BorderGray: string = '#EEEEEE'
const TextSecondary: string = '#757575'
const AccentGreen: string = '#4CAF50'
const Gold: string = '#FFD700'

@Entry
@Component
struct HabitTrackerPage {
  @State meditationChecked: boolean = true
  @State gymChecked: boolean = false
  @State spanishChecked: boolean = false
  @State waterChecked: boolean = false

  build() {
    Scroll() {
      Column() {
        Blank().height(24)

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
              .fontWeight(FontWeight.Black)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Button({ type: ButtonType.Circle }) {
            Text('⚙')
              .fontSize(26)
              .fontColor(PrimaryBlack)
          }
          .width(40)
          .height(40)
          .backgroundColor(BackgroundWhite)
          .border({
            width: 1,
            color: SurfaceGray
          })
          .onClick(() => {
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        StatsCard()

        Blank().height(32)

        Text("TODAY'S GOALS")
          .width('100%')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(1.5)

        Blank().height(16)

        HabitItem({
          icon: '☻',
          title: 'Morning Meditation',
          subtitle: '15 minutes mindfulness',
          checked: $meditationChecked
        })

        HabitItem({
          icon: '▶',
          title: 'Gym Session',
          subtitle: 'Upper body workout',
          checked: $gymChecked
        })

        HabitItem({
          icon: '★',
          title: 'Learn Spanish',
          subtitle: 'Daily lesson completed',
          checked: $spanishChecked
        })

        HabitItem({
          icon: '♥',
          title: 'Drink Water',
          subtitle: '2L target',
          checked: $waterChecked
        })

        Blank().height(24)

        Column() {
          Text('✓')
            .fontSize(20)
            .fontColor(TextSecondary)

          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(PrimaryBlack)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
            .margin({ top: 12 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(20)
        .backgroundColor(SurfaceGray)
        .borderRadius(16)

        Blank().height(48)
      }
      .width('100%')
      .minHeight('100%')
      .padding({
        left: 24,
        right: 24,
        top: 24,
        bottom: 24
      })
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(BackgroundWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
    .scrollBar(BarState.Off)
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('rgba(255,255,255,0.70)')
          .fontSize(14)

        Text('85%')
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 8 })

        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(Gold)

          Text('12 Day Streak!')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor(PrimaryBlack)
    .borderRadius(24)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HabitItem {
  icon: string = ''
  title: string = ''
  subtitle: string = ''
  @Link checked: boolean

  build() {
    Row() {
      Stack() {
        Text(this.icon)
          .fontSize(28)
          .fontColor(PrimaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(SurfaceGray)
      .borderRadius(24)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TextSecondary : PrimaryBlack)
          .decoration({
            type: this.checked ? TextDecorationType.LineThrough : TextDecorationType.None
          })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
          .margin({ top: 2 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Stack() {
        if (this.checked) {
          Text('✓')
            .fontSize(22)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.checked ? AccentGreen : 'rgba(255,255,255,0)')
      .border({
        width: 2,
        color: this.checked ? AccentGreen : SurfaceGray
      })
      .borderRadius(16)
      .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .margin({
      top: 8,
      bottom: 8
    })
    .backgroundColor(Color.White)
    .border({
      width: 1,
      color: BorderGray
    })
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.checked = !this.checked
    })
  }
}