// TeaMasterApp.ets
import drawing from '@ohos.drawing';

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

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  build() {
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
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
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
      }
      .type(ButtonType.Circle)
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
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
          .fontColor('#000000')
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor('#8D6E63')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Blank()

      Text('♥')
        .fontSize(24)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct CustomLeafIcon {
  build() {
    Stack() {
      // Circle outline
      Circle({ width: 30, height: 30 })
        .fill(Color.Transparent)
        .stroke({ color: '#6D4C41', width: 2 })

      // Vertical Line
      Line()
        .width(2)
        .height(15)
        .backgroundColor('#6D4C41')
    }
    .width(30)
    .height(30)
  }
}

@Component
struct TimerDisplay {
  private time: string = '02:00';

  build() {
    Stack() {
      // Background Circle
      Circle({ width: 220, height: 220 })
        .fill(Color.Transparent)
        .stroke({ color: '#F5F5F5', width: 12 })

      // Progress Arc
      Progress({ value: 66, total: 100, type: ProgressType.Ring })
        .style({ strokeWidth: 12 })
        .color('#6D4C41')
        .width(220)
        .height(220)

      VStack() {
        Text('STEEPING')
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
    Row() {
      // Reset
      Button() {
        Text('↺')
          .fontSize(24)
          .fontColor('#808080')
      }
      .type(ButtonType.Circle)
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })

      // Start
      Button() {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor(Color.White)
          Text('Start')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
      }
      .width(120)
      .height(60)
      .backgroundColor('#6D4C41')
      .borderRadius(24)

      // Add Note
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#808080')
      }
      .type(ButtonType.Circle)
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
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
        .fontColor('#CCCCCC')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      Divider().color('#F5F5F5').strokeWidth(1).margin({ top: 8, bottom: 8 })
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      Divider().color('#F5F5F5').strokeWidth(1).margin({ top: 8, bottom: 8 })
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
    Row() {
      Text(this.step)
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .borderRadius(12)
        .backgroundColor('#F5F5F5')

      Text(this.text)
        .fontSize(14)
        .fontColor('#808080')
        .margin({ left: 12 })

      Blank()

      Text('✓')
        .fontSize(12)
        .fontColor('#EEEEEE')
    }
    .width('100%')
    .height(40)
  }
}