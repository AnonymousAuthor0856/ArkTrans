interface StepData {
  step: string;
  text: string;
}

@Entry
@Component
struct TeaMasterApp {
  build() {
    Column() {
      TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - App Colors
class TeaColors {
  static readonly primary: ResourceStr = '#6D4C41'
  static readonly secondary: ResourceStr = '#A1887F'
  static readonly surfaceVariant: ResourceStr = '#FAFAFA'
  static readonly outline: ResourceStr = '#EEEEEE'
  static readonly backgroundTint: ResourceStr = '#F5F5F5'
  static readonly teaLeafDetail: ResourceStr = '#8D6E63'
  static readonly favoriteTint: ResourceStr = '#FFCDD2'
  static readonly textSecondary: Color = Color.Gray
  static readonly textPrimary: Color = Color.Black
  static readonly iconBg: ResourceStr = '#EFEBE9'
  static readonly borderGray: ResourceStr = '#E0E0E0'
}

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderSection()
          .margin({ top: 24, bottom: 32 })

        TeaSelectionCard()
          .margin({ bottom: 32 })

        TimerDisplay({ time: '02:00' })
          .margin({ bottom: 40 })

        ControlButtons()

        Blank()

        PreparationSteps()
          .margin({ bottom: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - Header Section
@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(TeaColors.textPrimary)
      }
      .type(ButtonType.Circle)
      .width(48)
      .height(48)
      .backgroundColor(TeaColors.backgroundTint)
    }
    .width('100%')
  }
}

// MARK: - Tea Selection Card
@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill(TeaColors.iconBg)

        CustomLeafIcon()
          .width(30)
          .height(30)
      }

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('♥')
        .fontSize(24)
        .fontColor(TeaColors.favoriteTint)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline })
  }
}

// MARK: - Custom Leaf Icon
@Component
struct CustomLeafIcon {
  build() {
    Canvas() {
      // Circle outline
      Circle()
        .width(30)
        .height(30)
        .fill('transparent')
        .stroke(TeaColors.primary)
        .strokeWidth(2)
        .translate({ x: 0, y: 0 })

      // Vertical line
      Path()
        .width(30)
        .height(30)
        .commands('M15 7.5 L15 22.5')
        .fill('transparent')
        .stroke(TeaColors.primary)
        .strokeWidth(2)
        .strokeLineCap(LineCapStyle.Round)
    }
    .width(30)
    .height(30)
  }
}

// MARK: - Timer Display
@Component
struct TimerDisplay {
  @Prop time: string = '02:00'

  build() {
    Stack() {
      // Background circle
      Circle()
        .width(220)
        .height(220)
        .fill('transparent')
        .stroke(TeaColors.backgroundTint)
        .strokeWidth(12)

      // Progress arc - 240 degrees (0.66 of circle), starting from -210 degrees
      Canvas() {
        Path()
          .width(220)
          .height(220)
          .commands(this.buildArcPath(110, 110, 110, -210, 240))
          .fill('transparent')
          .stroke(TeaColors.primary)
          .strokeWidth(12)
          .strokeLineCap(LineCapStyle.Round)
      }
      .width(220)
      .height(220)

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
          .letterSpacing(2)

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
      }
    }
    .width(220)
    .height(220)
  }

  private buildArcPath(cx: number, cy: number, r: number, startAngle: number, sweepAngle: number): string {
    const startRad: number = (startAngle * Math.PI) / 180
    const endRad: number = ((startAngle + sweepAngle) * Math.PI) / 180

    const x1: number = cx + r * Math.cos(startRad)
    const y1: number = cy + r * Math.sin(startRad)
    const x2: number = cx + r * Math.cos(endRad)
    const y2: number = cy + r * Math.sin(endRad)

    const largeArc: number = sweepAngle > 180 ? 1 : 0

    return `M ${x1} ${y1} A ${r} ${r} 0 ${largeArc} 1 ${x2} ${y2}`
  }
}

// MARK: - Control Buttons
@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      // Reset button
      Button() {
        Text('↺')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .type(ButtonType.Circle)
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: TeaColors.borderGray })

      // Start button
      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .width(120)
      .height(60)
      .backgroundColor(TeaColors.primary)
      .borderRadius(24)

      // Add note button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .type(ButtonType.Circle)
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: TeaColors.borderGray })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}

// MARK: - Preparation Steps
@Component
struct PreparationSteps {
  @State steps: StepData[] = [
    { step: '1', text: 'Boil fresh water to 95°C' },
    { step: '2', text: 'Add 1 tsp of loose leaf per cup' },
    { step: '3', text: 'Pour water and wait for timer' }
  ]

  build() {
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .opacity(0.8)
        .margin({ bottom: 12 })

      ForEach(this.steps, (item: StepData, index: number) => {
        Column() {
          StepItem({ step: item.step, text: item.text })

          if (index < this.steps.length - 1) {
            Divider()
              .strokeWidth(1)
              .color(TeaColors.backgroundTint)
          }
        }
      }, (item: StepData, index: number) => `${index}_${item.step}`)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Step Item
@Component
struct StepItem {
  @Prop step: string = ''
  @Prop text: string = ''

  build() {
    Row({ space: 12 }) {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.textPrimary)
        .textAlign(TextAlign.Center)
        .width(24)
        .height(24)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(12)

      Text(this.text)
        .fontSize(14)
        .fontColor(Color.Gray)
        .layoutWeight(1)

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }
}
