import { router } from '@kit.ArkUI'

// Color constants
const primaryBlack = '#121212'
const backgroundWhite = '#FFFFFF'
const surfaceGray = '#F5F5F5'
const textSecondary = '#757575'
const accentGreen = '#4CAF50'
const gold = '#FFD700'
const white = '#FFFFFF'

interface HabitData {
  iconName: Resource
  title: string
  subtitle: string
  isCompleted: boolean
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('#B3FFFFFF')
          .fontSize(14)

        Blank().height(8)

        Text('85%')
          .fontColor(white)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)

        Blank().height(4)

        Row() {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .fillColor(gold)

          Blank().width(4)

          Text('12 Day Streak!')
            .fontColor(white)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .height(140)
    .backgroundColor(primaryBlack)
    .borderRadius(24)
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HabitItem {
  @Prop iconName: Resource
  @Prop title: string
  @Prop subtitle: string
  @State isCompleted: boolean = false

  build() {
    Row() {
      // Icon circle
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(surfaceGray)

        Image(this.iconName)
          .width(24)
          .height(24)
          .fillColor(primaryBlack)
      }
      .width(48)
      .height(48)

      Blank().width(16)

      // Text info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? textSecondary : primaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: textSecondary
          })
          .width('100%')

        Blank().height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(textSecondary)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isCompleted ? accentGreen : '#00000000')

        Circle()
          .width(32)
          .height(32)
          .fillOpacity(0)
          .stroke(this.isCompleted ? accentGreen : surfaceGray)
          .strokeWidth(2)

        if (this.isCompleted) {
          Image($r('app.media.startIcon'))
            .width(18)
            .height(18)
            .fillColor(white)
        }
      }
      .width(32)
      .height(32)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(white)
    .borderRadius(16)
    .border({ width: 1, color: surfaceGray, radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}

@Entry
@Component
struct HabitTrackerScreen {
  @State habits: HabitData[] = [
    {
      iconName: $r('app.media.startIcon'),
      title: 'Morning Meditation',
      subtitle: '15 minutes mindfulness',
      isCompleted: true
    },
    {
      iconName: $r('app.media.startIcon'),
      title: 'Gym Session',
      subtitle: 'Upper body workout',
      isCompleted: false
    },
    {
      iconName: $r('app.media.startIcon'),
      title: 'Learn Spanish',
      subtitle: 'Daily lesson completed',
      isCompleted: false
    },
    {
      iconName: $r('app.media.startIcon'),
      title: 'Drink Water',
      subtitle: '2L target',
      isCompleted: false
    }
  ]

  @State habitStates: boolean[] = [true, false, false, false]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(backgroundWhite)

      Scroll() {
        Column() {
          Blank().height(24)

          // Top Bar
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .fontColor(textSecondary)

              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(primaryBlack)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
              .layoutWeight(1)

            // Settings button
            Stack() {
              Circle()
                .width(40)
                .height(40)
                .fillOpacity(0)
                .stroke(surfaceGray)
                .strokeWidth(1)

              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor(primaryBlack)
            }
            .width(40)
            .height(40)
            .onClick(() => {
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // Stats Card
          StatsCard()

          Blank().height(32)

          // Today's Goals label
          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(textSecondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          // Habit Items
          HabitItemStateful({
            iconName: $r('app.media.startIcon'),
            title: 'Morning Meditation',
            subtitle: '15 minutes mindfulness',
            initialCompleted: true
          })

          HabitItemStateful({
            iconName: $r('app.media.startIcon'),
            title: 'Gym Session',
            subtitle: 'Upper body workout',
            initialCompleted: false
          })

          HabitItemStateful({
            iconName: $r('app.media.startIcon'),
            title: 'Learn Spanish',
            subtitle: 'Daily lesson completed',
            initialCompleted: false
          })

          HabitItemStateful({
            iconName: $r('app.media.startIcon'),
            title: 'Drink Water',
            subtitle: '2L target',
            initialCompleted: false
          })

          Blank().height(24)

          // Inspiration Section
          Column() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor(textSecondary)

            Blank().height(12)

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(primaryBlack)
              .lineHeight(20)
              .width('100%')
          }
          .padding(20)
          .width('100%')
          .backgroundColor(surfaceGray)
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)

          Blank().height(48)
        }
        .padding(24)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HabitItemStateful {
  @Prop iconName: Resource
  @Prop title: string
  @Prop subtitle: string
  @Prop initialCompleted: boolean
  @State isCompleted: boolean = false

  aboutToAppear() {
    this.isCompleted = this.initialCompleted
  }

  build() {
    Row() {
      // Icon circle
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(surfaceGray)

        Image(this.iconName)
          .width(24)
          .height(24)
          .fillColor(primaryBlack)
      }
      .width(48)
      .height(48)

      Blank().width(16)

      // Text info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? textSecondary : primaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: textSecondary
          })
          .width('100%')

        Blank().height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(textSecondary)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isCompleted ? accentGreen : '#00000000')

        Circle()
          .width(32)
          .height(32)
          .fillOpacity(0)
          .stroke(this.isCompleted ? accentGreen : surfaceGray)
          .strokeWidth(2)

        if (this.isCompleted) {
          Text('✓')
            .fontSize(16)
            .fontColor(white)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(white)
    .borderRadius(16)
    .border({ width: 1, color: surfaceGray, radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}