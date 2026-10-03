// MARK: - UI Constants & Colors

// Define custom colors to match the Android version
const PRIMARY_BLACK: string = '#121212'
const BACKGROUND_WHITE: string = '#FFFFFF'
const SURFACE_GRAY: string = '#F5F5F5'
const TEXT_SECONDARY: string = '#757575'
const ACCENT_GREEN: string = '#4CAF50'
const GOLD: string = '#FFD700'
// Color.white.opacity(0.7)
const WHITE_70: string = '#B3FFFFFF'

// MARK: - Main Screen

@Component
struct HabitTrackerScreen {
  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          Blank().height(24)

          // -- Top Bar --
          Row() {
            Column({ space: 0 }) {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(700)
                .letterSpacing(1)
                .fontColor(TEXT_SECONDARY)
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(900)
                .fontColor(PRIMARY_BLACK)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor(PRIMARY_BLACK)
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .borderRadius(20)
            .border({ width: 1, color: SURFACE_GRAY, radius: 20 })
            .onClick(() => {
              // No op
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // -- Hero Stats Card --
          StatsCard()

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(700)
            .letterSpacing(1.5)
            .fontColor(TEXT_SECONDARY)
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          // -- Habit List --
          HabitItem({
            iconName: '☺', // Icons.Default.Face (face.smiling.fill)
            title: 'Morning Meditation',
            subtitle: '15 minutes mindfulness',
            isCompleted: true
          })

          HabitItem({
            iconName: '▶', // Icons.Default.PlayArrow (play.fill)
            title: 'Gym Session',
            subtitle: 'Upper body workout',
            isCompleted: false
          })

          HabitItem({
            iconName: '★', // Icons.Default.Star (star.fill)
            title: 'Learn Spanish',
            subtitle: 'Daily lesson completed',
            isCompleted: false
          })

          HabitItem({
            iconName: '♥', // Icons.Default.Favorite (heart.fill)
            title: 'Drink Water',
            subtitle: '2L target',
            isCompleted: false
          })

          Blank().height(24)

          // -- Inspiration Section --
          Column({ space: 0 }) {
            Text('✓') // Icons.Default.CheckCircle (checkmark.circle.fill)
              .fontSize(20)
              .fontColor(TEXT_SECONDARY)
            Blank().height(12)
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(PRIMARY_BLACK)
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .width('100%')
          .backgroundColor(SURFACE_GRAY)
          .borderRadius(16)

          Blank().height(48)
        }
        .alignItems(HorizontalAlign.Center)
        .padding(24)
      }
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Vertical)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
  }
}

// MARK: - Components

@Component
struct StatsCard {
  build() {
    Row({ space: 0 }) {
      Column({ space: 0 }) {
        Text('Overall Progress')
          .fontColor(WHITE_70)
          .fontSize(14)
        Blank().height(8)
        Text('85%')
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(700)
        Blank().height(4)
        Row({ space: 0 }) {
          Text('★') // Icons.Default.Star (star.fill)
            .fontSize(16)
            .fontColor(GOLD)
          Blank().width(4)
          Text('12 Day Streak!')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(500)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height(140)
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(24)
    .margin({ left: 24, right: 24, top: 24, bottom: 24 })
  }
}

@Component
struct HabitItem {
  @Prop iconName: string = ''
  @Prop title: string = ''
  @Prop subtitle: string = ''
  @Prop isCompleted: boolean = false
  @State checked: boolean = false

  aboutToAppear(): void {
    this.checked = this.isCompleted
  }

  build() {
    Row({ space: 0 }) {
      // Icon Box
      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(SURFACE_GRAY)
        Text(this.iconName)
          .fontSize(24)
          .fontColor(PRIMARY_BLACK)
      }
      .width(48)
      .height(48)

      Blank().width(16)

      // Text Info
      Column({ space: 0 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(700)
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
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox Button
      Stack() {
        Circle({ width: 32, height: 32 })
          .fill(this.checked ? ACCENT_GREEN : Color.Transparent)
        Circle({ width: 32, height: 32 })
          .fill(Color.Transparent)
          .stroke(this.checked ? ACCENT_GREEN : SURFACE_GRAY)
          .strokeWidth(2)

        if (this.checked) {
          Text('✓') // Icons.Default.Check (checkmark)
            .fontSize(18)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: SURFACE_GRAY, radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.checked = !this.checked
    })
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct HabitTrackerApp {
  build() {
    Column() {
      HabitTrackerScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Preview
// SwiftUI's HabitTrackerScreen_Previews / PreviewProvider has no direct ArkTS
// equivalent; the screen is previewed through the HabitTrackerApp entry above.
