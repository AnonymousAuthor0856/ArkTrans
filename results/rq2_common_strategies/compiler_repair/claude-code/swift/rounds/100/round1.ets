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
              Image($r('sys.media.ohos_ic_public_settings'))
                .width(24)
                .height(24)
                .fillColor(ColorPrimaryBlack)
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
            Image($r('sys.media.ohos_ic_public_check_circle'))
              .width(20)
              .height(20)
              .fillColor(ColorTextSecondary)
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
          Image($r('sys.media.ohos_ic_public_star'))
            .width(16)
            .height(16)
            .fillColor(ColorGold)
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
        Image(this.getIconResource(this.iconName))
          .width(24)
          .height(24)
          .fillColor(ColorPrimaryBlack)
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
          Image($r('sys.media.ohos_ic_public_check'))
            .width(18)
            .height(18)
            .fillColor(Color.White)
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

  getIconResource(name: string): ResourceStr {
    switch (name) {
      case 'face.smiling.fill':
        return $r('sys.media.ohos_ic_public_face')
      case 'play.fill':
        return $r('sys.media.ohos_ic_public_play')
      case 'star.fill':
        return $r('sys.media.ohos_ic_public_star')
      case 'heart.fill':
        return $r('sys.media.ohos_ic_public_heart')
      default:
        return $r('sys.media.ohos_ic_public_face')
    }
  }
}
