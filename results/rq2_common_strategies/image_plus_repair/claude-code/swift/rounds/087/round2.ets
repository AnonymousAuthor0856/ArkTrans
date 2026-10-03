// Tea Master - ArkTS implementation
// Converted from SwiftUI

@Entry
@Component
struct TeaMasterApp {
  build() {
    Stack() {
      TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - App Colors
class TeaColors {
  static readonly primary: ResourceColor = '#6D4C41'
  static readonly secondary: ResourceColor = '#A1887F'
  static readonly surfaceVariant: ResourceColor = '#FAFAFA'
  static readonly outline: ResourceColor = '#EEEEEE'
  static readonly backgroundTint: ResourceColor = '#F5F5F5'
  static readonly teaLeafDetail: ResourceColor = '#8D6E63'
  static readonly favoriteTint: ResourceColor = '#FFCDD2'
  static readonly textSecondary: ResourceColor = '#888888'
  static readonly textPrimary: ResourceColor = '#000000'
  static readonly leafIconBg: ResourceColor = '#EFEBE9'
  static readonly borderGray: ResourceColor = '#E0E0E0'
}

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  build() {
    Column() {
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
    .height('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(Color.White)
  }
}

// MARK: - Header Section
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
    Row() {
      // Leaf Icon background circle
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill(TeaColors.leafIconBg)

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
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Blank()

      Text('♥')
        .fontSize(28)
        .fontColor(TeaColors.favoriteTint)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(TeaColors.surfaceVariant)
    .borderRadius(24)
    .border({ width: 1, color: TeaColors.outline })
  }
}

// MARK: - Custom Leaf Icon (circle with vertical line)
@Component
struct CustomLeafIcon {
  build() {
    Stack() {
      // Circle outline
      Circle()
        .width('100%')
        .height('100%')
        .fill(Color.Transparent)
        .stroke({ color: TeaColors.primary, width: 2 })

      // Vertical line (using thin rect)
      Rect()
        .width(2)
        .height('50%')
        .fill(TeaColors.primary)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Timer Display
@Component
struct TimerDisplay {
  @Prop time: string = '02:00'

  build() {
    Stack() {
      // Background track circle
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke(TeaColors.backgroundTint, 12)

      // Progress ring - 66% filled, rotated so gap is at bottom
      Progress({ value: 66, total: 100, type: ProgressType.Ring })
        .width(220)
        .height(220)
        .color(TeaColors.primary)
        .backgroundColor(Color.Transparent)
        .style({ strokeWidth: 12, scale: 1 })
        .rotate({ angle: 240 })

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(TeaColors.textSecondary)
          .letterSpacing(2)
          .margin({ bottom: 4 })

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

// MARK: - Control Buttons
@Component
struct ControlButtons {
  build() {
    Row() {
      // Reset button
      Button() {
        Text('↺')
          .fontSize(24)
          .fontColor('#888888')
      }
      .type(ButtonType.Circle)
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: TeaColors.borderGray })

      // Start button
      Button() {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
      }
      .type(ButtonType.Capsule)
      .width(120)
      .height(60)
      .backgroundColor(TeaColors.primary)
      .margin({ left: 24, right: 24 })

      // Add button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#888888')
      }
      .type(ButtonType.Circle)
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: TeaColors.borderGray })
    }
    .justifyContent(FlexAlign.Center)
  }
}

// MARK: - Preparation Steps
@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#AAAAAA')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })

      Divider()
        .color(TeaColors.backgroundTint)

      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })

      Divider()
        .color(TeaColors.backgroundTint)

      StepItem({ step: '3', text: 'Pour water and wait for timer' })
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
    Row() {
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
        .fontColor('#888888')
        .margin({ left: 12 })

      Blank()

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }
}
