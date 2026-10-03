const PRIMARY_BLACK: string = '#121212'
const BACKGROUND_WHITE: string = '#FFFFFF'
const SURFACE_GRAY: string = '#F5F5F5'
const TEXT_SECONDARY: string = '#757575'
const ACCENT_GREEN: string = '#4CAF50'
const GOLD: string = '#FFD700'
const WHITE_70: string = '#B3FFFFFF'

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
                .fontColor(TEXT_SECONDARY)

              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bolder)
                .fontColor(PRIMARY_BLACK)
            }
            .alignItems(HorizontalAlign.Start)

            Stack({ alignContent: Alignment.Center }) {
              Text('⚙')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(PRIMARY_BLACK)
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .border({
              width: 1,
              color: SURFACE_GRAY
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(32)

          StatsCard()

          Blank().height(32)

          Text('TODAY\'S GOALS')
            .width('100%')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(TEXT_SECONDARY)
            .textAlign(TextAlign.Start)

          Blank().height(16)

          HabitItem({
            icon: '☻',
            title: 'Morning Meditation',
            subtitle: '15 minutes mindfulness',
            checked: true
          })

          HabitItem({
            icon: '▶',
            title: 'Gym Session',
            subtitle: 'Upper body workout',
            checked: false
          })

          HabitItem({
            icon: '★',
            title: 'Learn Spanish',
            subtitle: 'Daily lesson completed',
            checked: false
          })

          HabitItem({
            icon: '♥',
            title: 'Drink Water',
            subtitle: '2L target',
            checked: false
          })

          Blank().height(24)

          Column() {
            Text('✓')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT_SECONDARY)

            Blank().height(12)

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(PRIMARY_BLACK)
              .lineHeight(20)
          }
          .width('100%')
          .padding(20)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(SURFACE_GRAY)
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
    .backgroundColor(BACKGROUND_WHITE)
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor(WHITE_70)
          .fontSize(14)

        Blank().height(8)

        Text('85%')
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)

        Blank().height(4)

        Row() {
          Text('★')
            .fontSize(18)
            .fontColor(GOLD)

          Blank().width(4)

          Text('12 Day Streak!')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
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
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(24)
  }
}

@Component
struct HabitItem {
  icon: string = ''
  title: string = ''
  subtitle: string = ''
  @Prop checked: boolean = false

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.icon)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY_BLACK)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(SURFACE_GRAY)

      Blank().width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TEXT_SECONDARY : PRIMARY_BLACK)
          .decoration({
            type: this.checked ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: TEXT_SECONDARY
          })

        Blank().height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(8)

      Stack({ alignContent: Alignment.Center }) {
        if (this.checked) {
          Text('✓')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.checked ? ACCENT_GREEN : Color.Transparent)
      .border({
        width: 2,
        color: this.checked ? ACCENT_GREEN : SURFACE_GRAY
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({
      width: 1,
      color: SURFACE_GRAY
    })
    .margin({
      top: 8,
      bottom: 8
    })
    .onClick(() => {
      this.checked = !this.checked
    })
  }
}