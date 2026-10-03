// Color constants matching the SwiftUI design
const ColorPrimaryBlack: ResourceColor = '#121212'
const ColorBackgroundWhite: ResourceColor = '#FFFFFF'
const ColorSurfaceGray: ResourceColor = '#F5F5F5'
const ColorTextSecondary: ResourceColor = '#757575'
const ColorAccentGreen: ResourceColor = '#4CAF50'
const ColorGold: ResourceColor = '#FFD700'

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Stack() {
      Scroll() {
        Column() {
          // Top Bar
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(ColorTextSecondary)
                .letterSpacing(1)
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bolder)
                .fontColor(ColorPrimaryBlack)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor(ColorPrimaryBlack)
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .borderRadius(20)
            .border({ width: 1, color: ColorSurfaceGray })
            .padding(0)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // Hero Stats Card
          StatsCard()
            .margin({ top: 32 })

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(ColorTextSecondary)
            .letterSpacing(1.5)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ top: 32, bottom: 16 })

          // Habit List
          HabitItem({
            iconName: 'face.smiling.fill',
            title: 'Morning Meditation',
            subtitle: '15 minutes mindfulness',
            initialCompleted: true
          })

          HabitItem({
            iconName: 'play.fill',
            title: 'Gym Session',
            subtitle: 'Upper body workout',
            initialCompleted: false
          })

          HabitItem({
            iconName: 'star.fill',
            title: 'Learn Spanish',
            subtitle: 'Daily lesson completed',
            initialCompleted: false
          })

          HabitItem({
            iconName: 'heart.fill',
            title: 'Drink Water',
            subtitle: '2L target',
            initialCompleted: false
          })

          // Inspiration Section
          Column() {
            Text('✔')
              .fontSize(20)
              .fontColor(ColorTextSecondary)
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(ColorPrimaryBlack)
              .lineHeight(20)
              .margin({ top: 12 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .backgroundColor(ColorSurfaceGray)
          .borderRadius(16)
          .margin({ top: 24, bottom: 48 })
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .backgroundColor(ColorBackgroundWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorBackgroundWhite)
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor(Color.White)
          .opacity(0.7)

        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 8 })

        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(ColorGold)
          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor(ColorPrimaryBlack)
    .borderRadius(24)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HabitItem {
  iconName: string = ''
  title: string = ''
  subtitle: string = ''
  initialCompleted: boolean = false
  @State isCompleted: boolean = false

  aboutToAppear() {
    this.isCompleted = this.initialCompleted
  }

  build() {
    Row() {
      // Icon Box
      Stack() {
        Text(this.getIconGlyph(this.iconName))
          .fontSize(24)
          .fontColor(ColorPrimaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(ColorSurfaceGray)
      .borderRadius(24)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? ColorTextSecondary : ColorPrimaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: ColorTextSecondary
          })
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(ColorTextSecondary)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // Checkbox Button
      Stack() {
        if (this.isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.isCompleted ? ColorAccentGreen : Color.Transparent)
      .borderRadius(16)
      .border({
        width: 2,
        color: this.isCompleted ? ColorAccentGreen : ColorSurfaceGray
      })
      .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: ColorSurfaceGray })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }

  getIconGlyph(name: string): string {
    switch (name) {
      case 'face.smiling.fill':
        return '☺'
      case 'play.fill':
        return '▶'
      case 'star.fill':
        return '★'
      case 'heart.fill':
        return '♥'
      default:
        return '☺'
    }
  }
}
