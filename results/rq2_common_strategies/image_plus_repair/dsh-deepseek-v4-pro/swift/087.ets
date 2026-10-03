// ArkTS translation of SwiftUI source 087.swift
// Original: TeaMasterApp — a tea brewing timer UI.
// ContentView and TeaBrewingScreen are folded into the @Entry root so the
// page's build() method has a single built-in container node.

// MARK: - App Colors
class TeaColors {
  static readonly primary: string = '#6D4C41'; // #6D4C41
  static readonly secondary: string = '#A1887F'; // #A1887F
  static readonly surfaceVariant: string = '#FAFAFA'; // #FAFAFA
  static readonly outline: string = '#EEEEEE'; // #EEEEEE
  static readonly backgroundTint: string = '#F5F5F5'; // #F5F5F5
  static readonly teaLeafDetail: string = '#8D6E63'; // #8D6E63
  static readonly favoriteTint: string = '#FFCDD2'; // #FFCDD2
  static readonly textSecondary: string = '#808080'; // Color.gray
  static readonly textPrimary: string = '#000000'; // Color.black
}

@Entry
@Component
struct TeaMasterApp {
  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Header
        HeaderSection()
          .padding({ top: 24, bottom: 32 })

        // Main Card
        TeaSelectionCard()
          .padding({ bottom: 32 })

        // Timer
        TimerDisplay({ time: '02:00' })
          .padding({ bottom: 40 })

        // Action Buttons
        ControlButtons()

        Blank()

        // Steps
        PreparationSteps()
          .padding({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14) // BodyMedium approx
          .fontColor(TeaColors.textSecondary)
        Text('Tea Master')
          .fontSize(22) // TitleLarge approx
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

@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      // Icon Box
      Stack() {
        Circle()
          .width(60)
          .height(60)
          .fill('#EFEBE9') // #EFEBE9

        // Custom drawn leaf-like shape (SF Symbol "leaf" replaced with custom shape)
        CustomLeafIcon()
          .width(30)
          .height(30)
      }

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16) // TitleMedium approx
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        Text('Black Tea • 95°C')
          .fontSize(12) // BodySmall approx
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('♥')
        .fontSize(24)
        .fontColor(TeaColors.favoriteTint)
    }
    .alignItems(VerticalAlign.Center)
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
    // w = h = 30 (frame applied by parent)
    Stack() {
      // Circle outline
      Circle()
        .width(30)
        .height(30)
        .fill(Color.Transparent)
        .stroke(TeaColors.primary)
        .strokeWidth(2)

      // Vertical Line
      Path({ width: 30, height: 30, commands: 'M15 7.5 L15 22.5' })
        .fill(Color.Transparent)
        .stroke(TeaColors.primary)
        .strokeWidth(2)
        .strokeLineCap(LineCapStyle.Round)
    }
  }
}

@Component
struct TimerDisplay {
  @Prop time: string;

  build() {
    Stack() {
      // Background Circle
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke(TeaColors.backgroundTint)
        .strokeWidth(12)

      // Progress Arc (240 degrees, i.e. 0.66 of a full circle), rotated to start bottom-left
      Path({ width: 220, height: 220, commands: 'M 19.93 162 A 104 104 0 1 1 200.07 162' })
        .fill(Color.Transparent)
        .stroke(TeaColors.primary)
        .strokeWidth(12)
        .strokeLineCap(LineCapStyle.Round)

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12) // LabelMedium
          .fontWeight(FontWeight.Medium)
          .letterSpacing(2)
          .fontColor(TeaColors.textSecondary)

        Text(this.time)
          .fontSize(45) // DisplayMedium approx
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
      Button() {
        Text('↺')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .type(ButtonType.Circle)
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
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .type(ButtonType.Circle)
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
    Column({ space: 0 }) {
      Text('PREPARATION')
        .fontSize(11) // LabelSmall
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .opacity(0.8)
        .padding({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      Divider().color(TeaColors.backgroundTint)
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      Divider().color(TeaColors.backgroundTint)
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct StepItem {
  @Prop step: string;
  @Prop text: string;

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
        .fontSize(14) // BodyMedium
        .fontColor(Color.Gray)

      Blank()

      Text('✓')
        .fontSize(12)
        .fontColor(TeaColors.outline)
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }
}
