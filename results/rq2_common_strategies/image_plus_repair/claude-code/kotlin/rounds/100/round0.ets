@Entry
@Component
struct HabitTrackerScreen {
  @State meditationChecked: boolean = true
  @State gymChecked: boolean = false
  @State spanishChecked: boolean = false
  @State waterChecked: boolean = false

  private readonly PrimaryBlack: string = '#FF121212'
  private readonly BackgroundWhite: string = '#FFFFFFFF'
  private readonly SurfaceGray: string = '#FFF5F5F5'
  private readonly TextSecondary: string = '#FF757575'
  private readonly AccentGreen: string = '#FF4CAF50'

  build() {
    Column() {
      // Top spacing
      Column()
        .height(24)

      // Top Bar
      Row() {
        Column() {
          Text('THURSDAY')
            .fontSize(12)
            .fontColor(this.TextSecondary)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
          Text('Dec 04')
            .fontSize(24)
            .fontColor(this.PrimaryBlack)
            .fontWeight(FontWeight.Bolder)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        // Settings button
        Stack() {
          Image($r('sys.media.ohos_ic_public_settings'))
            .width(24)
            .height(24)
            .fillColor(this.PrimaryBlack)
        }
        .width(40)
        .height(40)
        .border({ width: 1, color: this.SurfaceGray, radius: 20 })
        .borderRadius(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Stats Card spacing
      Column()
        .height(32)

      // Hero Stats Card
      Row() {
        Column() {
          Text('Overall Progress')
            .fontSize(14)
            .fontColor('rgba(255, 255, 255, 0.7)')
          Text('85%')
            .fontSize(48)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .height('100%')
      }
      .width('100%')
      .height(140)
      .backgroundColor(this.PrimaryBlack)
      .borderRadius(24)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      // Section spacing
      Column()
        .height(32)

      // Today's Goals header
      Text('TODAY\'S GOALS')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.TextSecondary)
        .letterSpacing(1.5)
        .width('100%')

      Column()
        .height(16)

      // Habit List
      HabitItem({
        iconRes: $r('sys.media.ohos_ic_public_user_head_portrait'),
        title: 'Morning Meditation',
        subtitle: '15 minutes mindfulness',
        isCompleted: $meditationChecked,
        primaryBlack: this.PrimaryBlack,
        surfaceGray: this.SurfaceGray,
        textSecondary: this.TextSecondary,
        accentGreen: this.AccentGreen
      })

      HabitItem({
        iconRes: $r('sys.media.ohos_ic_public_play'),
        title: 'Gym Session',
        subtitle: 'Upper body workout',
        isCompleted: $gymChecked,
        primaryBlack: this.PrimaryBlack,
        surfaceGray: this.SurfaceGray,
        textSecondary: this.TextSecondary,
        accentGreen: this.AccentGreen
      })

      HabitItem({
        iconRes: $r('sys.media.ohos_ic_public_star_black'),
        title: 'Learn Spanish',
        subtitle: 'Daily lesson completed',
        isCompleted: $spanishChecked,
        primaryBlack: this.PrimaryBlack,
        surfaceGray: this.SurfaceGray,
        textSecondary: this.TextSecondary,
        accentGreen: this.AccentGreen
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BackgroundWhite)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }
}

@Component
struct HabitItem {
  @Link isCompleted: boolean
  iconRes: Resource = $r('sys.media.ohos_ic_public_star_black')
  title: string = ''
  subtitle: string = ''
  primaryBlack: string = '#FF121212'
  surfaceGray: string = '#FFF5F5F5'
  textSecondary: string = '#FF757575'
  accentGreen: string = '#FF4CAF50'

  build() {
    Row() {
      // Icon Box
      Stack() {
        Image(this.iconRes)
          .width(24)
          .height(24)
          .fillColor(this.primaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(this.surfaceGray)
      .borderRadius(24)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? this.textSecondary : this.primaryBlack)
          .decoration({ type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(this.textSecondary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      // Checkbox Button
      Stack() {
        if (this.isCompleted) {
          Image($r('sys.media.ohos_ic_public_selected'))
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.isCompleted ? this.accentGreen : Color.Transparent)
      .border({
        width: 2,
        color: this.isCompleted ? this.accentGreen : this.surfaceGray,
        radius: 16
      })
      .borderRadius(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: this.surfaceGray, radius: 16 })
    .borderRadius(16)
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}
