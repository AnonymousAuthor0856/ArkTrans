import { BusinessError } from '@kit.BasicServicesKit';

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
  static readonly primary: Color = new Color('#6D4C41');
  static readonly secondary: Color = new Color('#A1887F');
  static readonly surfaceVariant: Color = new Color('#FAFAFA');
  static readonly outline: Color = new Color('#EEEEEE');
  static readonly backgroundTint: Color = new Color('#F5F5F5');
  static readonly teaLeafDetail: Color = new Color('#8D6E63');
  static readonly favoriteTint: Color = new Color('#FFCDD2');
  static readonly textSecondary: Color = Color.Gray;
  static readonly textPrimary: Color = Color.Black;
}

// MARK: - Main Screen
@Component
struct TeaBrewingScreen {
  build() {
    Stack() {
      Column() {
        // Top Header
        HeaderSection()
          .padding({ top: 24, bottom: 32 })

        // Main Card
        TeaSelectionCard()
          .padding({ bottom: 32 })

        // Timer
        TimerDisplay({ time: "02:00" })
          .padding({ bottom: 40 })

        // Action Buttons
        ControlButtons()

        Blank()

        // Steps
        PreparationSteps()
          .padding({ bottom: 24 })
      }
      .padding({ left: 24, right: 24 })
      .width('100%')
    }
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
        Text("Good Morning,")
          .fontSize(14)
          .fontColor(TeaColors.textSecondary)
        
        Text("Tea Master")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 2 })

      Blank()

      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for gear icon
          .width(24)
          .height(24)
          .fillColor(TeaColors.textPrimary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(TeaColors.backgroundTint)
      .borderRadius(24)
      .width(48)
      .height(48)
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
        Circle()
          .fill(new Color('#EFEBE9'))
          .width(60)
          .height(60)
        
        CustomLeafIcon()
          .width(30)
          .height(30)
      }

      Column() {
        Text("Earl Grey Reserve")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TeaColors.textPrimary)
        
        Text("Black Tea • 95°C")
          .fontSize(12)
          .fontColor(TeaColors.teaLeafDetail)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 2 })

      Blank()

      Image($r('app.media.ic_heart')) // Placeholder for heart icon
        .width(24)
        .height(24)
        .fillColor(TeaColors.favoriteTint)
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
        .stroke(TeaColors.primary)
        .strokeWidth(2)
        .width('100%')
        .height('100%')

      // Vertical Line (Simplified representation of leaf vein)
      CanvasRenderingContext2D.drawPath((context: CanvasRenderingContext2D) => {
        context.beginPath();
        context.moveTo(context.canvas.width / 2, context.canvas.height / 4);
        context.lineTo(context.canvas.width / 2, context.canvas.height * 0.75);
        context.strokeStyle = '#6D4C41';
        context.lineWidth = 2;
        context.lineCap = 'round';
        context.stroke();
      })
      .width('100%')
      .height('100%')
    }
  }
}

@Component
struct TimerDisplay {
  @State time: string = "02:00";

  build() {
    Stack() {
      // Background Circle
      Circle()
        .stroke(TeaColors.backgroundTint)
        .strokeWidth(12)
        .width(220)
        .height(220)

      // Progress Arc
      Circle()
        .trim({ start: 0, end: 0.66 })
        .stroke(TeaColors.primary)
        .strokeWidth(12)
        .lineCap(LineCap.Round)
        .rotate({ angle: -210 })
        .width(220)
        .height(220)

      Column() {
        Text("Steeping")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(2)
          .fontColor(TeaColors.textSecondary)
        
        Text(this.time)
          .fontSize(45)
          .fontWeight(FontWeight.Light)
          .fontColor(TeaColors.textPrimary)
      }
      .justifyContent(FlexAlign.Center)
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
        Image($r('app.media.ic_refresh')) // Placeholder for refresh icon
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(30)
      .width(60)
      .height(60)
      .border({ width: 1, color: new Color('#E0E0E0') })

      // Start
      Button() {
        Row() {
          Image($r('app.media.ic_play')) // Placeholder for play icon
            .width(18)
            .height(18)
            .fillColor(Color.White)
          
          Text("Start")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .type(ButtonType.Normal)
      .backgroundColor(TeaColors.primary)
      .borderRadius(24)
      .width(120)
      .height(60)

      // Add Note
      Button() {
        Image($r('app.media.ic_add')) // Placeholder for plus icon
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(30)
      .width(60)
      .height(60)
      .border({ width: 1, color: new Color('#E0E0E0') })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width('100%')
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text("PREPARATION")
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
        .opacity(0.8)
        .margin({ bottom: 12 })
      
      StepItem({ step: "1", text: "Boil fresh water to 95°C" })
      Divider().color(TeaColors.backgroundTint)
      StepItem({ step: "2", text: "Add 1 tsp of loose leaf per cup" })
      Divider().color(TeaColors.backgroundTint)
      StepItem({ step: "3", text: "Pour water and wait for timer" })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct StepItem {
  @State step: string = "";
  @State text: string = "";

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
        .fontColor(Color.Gray)
      
      Blank()
      
      Image($r('app.media.ic_check')) // Placeholder for checkmark icon
        .width(12)
        .height(12)
        .fillColor(TeaColors.outline)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }
}