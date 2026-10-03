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
      Column()
        .height(24)

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

        Stack() {
          Text('⚙')
            .fontSize(24)
            .fontColor(this.PrimaryBlack)
        }
        .width(40)
        .height(40)
        .border({ width: 1, color: this.SurfaceGray, radius: 20 })
        .borderRadius(20)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column()
        .height(32)

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

      Column()
        .height(32)

      Text('TODAY\'S GOALS')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.TextSecondary)
        .letterSpacing(1.5)
        .width('100%')

      Column()
        .height(16)

      HabitItem({
        iconSymbol: '🙂',
        title: 'Morning Meditation',
        subtitle: '15 minutes mindfulness',
        isCompleted: $meditationChecked,
        primaryBlack: this.PrimaryBlack,
        surfaceGray: this.SurfaceGray,
        textSecondary: this.TextSecondary,
        accentGreen: this.AccentGreen
      })

      HabitItem({
        iconSymbol: '▶',
        title: 'Gym Session',
        subtitle: 'Upper body workout',
        isCompleted: $gymChecked,
        primaryBlack: this.PrimaryBlack,
        surfaceGray: this.SurfaceGray,
        textSecondary: this.TextSecondary,
        accentGreen: this.AccentGreen
      })

      HabitItem({
        iconSymbol: '★',
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
  iconSymbol: string = '★'
  title: string = ''
  subtitle: string = ''
  primaryBlack: string = '#FF121212'
  surfaceGray: string = '#FFF5F5F5'
  textSecondary: string = '#FF757575'
  accentGreen: string = '#FF4CAF50'

  build() {
    Row() {
      Stack() {
        Text(this.iconSymbol)
          .fontSize(24)
          .fontColor(this.primaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(this.surfaceGray)
      .borderRadius(24)

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
