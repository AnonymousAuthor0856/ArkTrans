// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: TeaMasterApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    TeaBrewingScreen()
  }
}

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: 24, bottom: 32 })

        TeaSelectionCard()
          .padding({ bottom: 32 })

        TimerDisplay({ time: '02:00' })
          .padding({ bottom: 40 })

        ControlButtons()

        Blank()

        PreparationSteps()
          .padding({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor('#808080')
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
      }
      .onClick(() => {})
    }
    .width('100%')
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row({ space: 16 }) {
      Stack() {
        Circle()
          .fill('#EFEBE9')
          .width(60)
          .height(60)

        CustomLeafIcon()
          .width(30)
          .height(30)
      }
      .width(60)
      .height(60)

      Column({ space: 2 }) {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor('#8D6E63')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('❤')
        .fontSize(24)
        .fontColor('#FFCDD2')
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

// Custom leaf icon (approximation of the Kotlin Canvas drawing)
@Component
struct CustomLeafIcon {
  build() {
    Stack() {
      Circle()
        .fill('#00000000')
        .width('100%')
        .height('100%')
        .border({ width: 2, color: '#6D4C41' })

      Column()
        .width(2)
        .height('75%')
        .backgroundColor('#6D4C41')
        .borderRadius(1)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TimerDisplay {
  time: string = ''

  build() {
    Stack() {
      Circle()
        .fill('#00000000')
        .width(220)
        .height(220)
        .border({ width: 12, color: '#F5F5F5' })

      // Progress arc approximation (240 degrees ≈ 66%)
      Progress({ value: 66, total: 100, type: ProgressType.Ring })
        .width(220)
        .height(220)
        .color('#6D4C41')
        .style({ strokeWidth: 12 })

      Column({ space: 4 }) {
        Text('Steeping')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(2)
          .fontColor('#808080')

        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
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
      Button() {
        Text('↺')
          .fontSize(24)
          .fontColor('#808080')
          .width(60)
          .height(60)
          .backgroundColor('#FFFFFF')
          .borderRadius(30)
          .border({ width: 1, color: '#E0E0E0' })
      }
      .onClick(() => {})

      Button() {
        Row({ space: 8 }) {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width(120)
        .height(60)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#6D4C41')
        .borderRadius(24)
      }
      .onClick(() => {})

      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#808080')
          .width(60)
          .height(60)
          .backgroundColor('#FFFFFF')
          .borderRadius(30)
          .border({ width: 1, color: '#E0E0E0' })
      }
      .onClick(() => {})
    }
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
        .opacity(0.8)
        .padding({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      Divider().backgroundColor('#F5F5F5')
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      Divider().backgroundColor('#F5F5F5')
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct StepItem {
  step: string = ''
  text: string = ''

  build() {
    Row({ space: 12 }) {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width(24)
        .height(24)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
        .textAlign(TextAlign.Center)

      Text(this.text)
        .fontSize(14)
        .fontColor('#808080')

      Blank()

      Text('✓')
        .fontSize(12)
        .fontColor('#EEEEEE')
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }
}
