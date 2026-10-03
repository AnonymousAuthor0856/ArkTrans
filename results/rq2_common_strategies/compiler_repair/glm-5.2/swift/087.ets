// TeaMasterApp.ets

// MARK: - App Colors
class TeaColors {
  static primary: string = '#6D4C41';
  static secondary: string = '#A1887F';
  static surfaceVariant: string = '#FAFAFA';
  static outline: string = '#EEEEEE';
  static backgroundTint: string = '#F5F5F5';
  static teaLeafDetail: string = '#8D6E63';
  static favoriteTint: string = '#FFCDD2';
  static textSecondary: string = '#808080';
  static textPrimary: string = '#000000';
}

@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Column() {
        // Top Header
        HeaderSection()
          .margin({ top: 24, bottom: 32 })

        // Main Card
        TeaSelectionCard()
          .margin({ bottom: 32 })

        // Timer
        TimerDisplay({ time: '02:00' })
          .margin({ bottom: 40 })

        // Action Buttons
        ControlButtons()

        Blank()

        // Steps
        PreparationSteps()
          .margin({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 2 })

      Blank()

      Button({ type: ButtonType.Circle }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(TeaColors.textPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(TeaColors.backgroundTint)
    }
    .width('100%')
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Circle({ width: 60, height: 60 })
          .fill('#EFEBE9')

        CustomLeafIcon()
          .width(30)
          .height(30)
      }
      .width(60)
      .height(60)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
          .margin({ top: 2 })
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

@Component
struct CustomLeafIcon {
  build() {
    Stack() {
      // Circle outline
      Circle()
        .width('100%')
        .height('100%')
        .fill(Color.Transparent)
        .stroke(TeaColors.primary)
        .strokeWidth(2)

      // Vertical Line
      Line()
        .width(2)
        .height('50%')
        .backgroundColor(TeaColors.primary)
        .borderRadius(1)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TimerDisplay {
  private time: string = '02:00';

  build() {
    Stack() {
      // Background Circle
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke(TeaColors.backgroundTint)
        .strokeWidth(12)

      // Progress Arc
      Progress({ value: 66, total: 100, type: ProgressType.Ring })
        .style({ strokeWidth: 12 })
        .color(TeaColors.primary)
        .width(220)
        .height(220)
        .backgroundColor(Color.Transparent)

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(2)
          .fontColor(TeaColors.textSecondary)

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TeaColors.textPrimary)
      }
    }
    .width(220)
    .height(220)
  }
}

@Component
struct ControlButtons {
  build() {
    Row({ space: 24 }) {
      // Reset
      Button({ type: ButtonType.Circle }) {
        Text('↻')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })

      // Start
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

      // Add Note
      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })
    }
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#CCCCCC')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      Divider().color(TeaColors.backgroundTint).strokeWidth(1)
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      Divider().color(TeaColors.backgroundTint).strokeWidth(1)
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  private step: string = '';
  private text: string = '';

  build() {
    Row({ space: 12 }) {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TeaColors.textPrimary)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(TeaColors.backgroundTint)
        .borderRadius(12)

      Text(this.text)
        .fontSize(14)
        .fontColor(Color.Gray)

      Blank()

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .height(40)
  }
}