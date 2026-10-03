// Index.ets

// Color constants
const PRIMARY_BLACK: string = '#FF121212'
const BACKGROUND_WHITE: string = '#FFFFFFFF'
const SURFACE_GRAY: string = '#FFF5F5F5'
const TEXT_SECONDARY: string = '#FF757575'
const ACCENT_GREEN: string = '#FF4CAF50'
const GOLD_COLOR: string = '#FFFFD700'

interface HabitData {
  iconText: string
  title: string
  subtitle: string
  isCompleted: boolean
}

@Component
struct HabitItem {
  @Prop iconText: string = ''
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isCompleted: boolean = false
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.isCompleted
  }

  build() {
    Row() {
      // Icon Box
      Stack() {
        Text(this.iconText)
          .fontSize(22)
          .fontColor(PRIMARY_BLACK)
      }
      .width(48)
      .height(48)
      .backgroundColor(SURFACE_GRAY)
      .borderRadius(24)
      .alignContent(Alignment.Center)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TEXT_SECONDARY : PRIMARY_BLACK)
          .decoration(this.checked
            ? { type: TextDecorationType.LineThrough, color: TEXT_SECONDARY }
            : { type: TextDecorationType.None })
          .width('100%')
        Blank().height(2)
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
          .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      // Checkbox
      Stack() {
        if (this.checked) {
          Text('✓')
            .fontSize(16)
            .fontColor('#FFFFFFFF')
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.checked ? ACCENT_GREEN : '#00000000')
      .border({
        width: 2,
        color: this.checked ? ACCENT_GREEN : SURFACE_GRAY,
        style: BorderStyle.Solid
      })
      .alignContent(Alignment.Center)
      .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(BACKGROUND_WHITE)
    .borderRadius(16)
    .border({ width: 1, color: SURFACE_GRAY, style: BorderStyle.Solid })
    .alignItems(VerticalAlign.Center)
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.checked = !this.checked
    })
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
          .width('100%')
        Blank().height(8)
        Text('85%')
          .fontColor('#FFFFFFFF')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .width('100%')
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(14)
            .fontColor(GOLD_COLOR)
          Blank().width(4)
          Text('12 Day Streak!')
            .fontColor('#FFFFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(140)
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(24)
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct HabitTrackerScreen {
  private habits: HabitData[] = [
    { iconText: '😊', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true },
    { iconText: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false },
    { iconText: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false },
    { iconText: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false },
  ]

  build() {
    Scroll() {
      Column() {
        Blank().height(24)

        // Top Bar
        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontColor(TEXT_SECONDARY)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
            Text('Dec 04')
              .fontSize(24)
              .fontColor(PRIMARY_BLACK)
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          // Settings Button
          Stack() {
            Text('⚙')
              .fontSize(20)
              .fontColor(PRIMARY_BLACK)
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .border({ width: 1, color: SURFACE_GRAY, style: BorderStyle.Solid })
          .alignContent(Alignment.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        // Stats Card
        StatsCard()

        Blank().height(32)

        // Section Title
        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_SECONDARY)
          .letterSpacing(1.5)
          .width('100%')

        Blank().height(16)

        // Habit Items
        ForEach(this.habits, (habit: HabitData) => {
          HabitItem({
            iconText: habit.iconText,
            title: habit.title,
            subtitle: habit.subtitle,
            isCompleted: habit.isCompleted
          })
        })

        Blank().height(24)

        // Inspiration Section
        Column() {
          Text('✓')
            .fontSize(20)
            .fontColor(TEXT_SECONDARY)
            .width('100%')
          Blank().height(12)
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(PRIMARY_BLACK)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
            .width('100%')
        }
        .width('100%')
        .backgroundColor(SURFACE_GRAY)
        .borderRadius(16)
        .padding(20)
        .alignItems(HorizontalAlign.Start)

        Blank().height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
    .scrollBar(BarState.Off)
  }
}