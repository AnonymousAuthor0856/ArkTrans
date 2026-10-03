import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct TeaMasterApp {
  @State isDarkMode: boolean = false;

  build() {
    Column() {
      // Main Content Container
      Column() {
        HeaderSection()
        TeaSelectionCard()
        TimerDisplay()
        ControlButtons()
        PreparationSteps()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .onAppear(() => {
      // Hide status bar to match screenshot
      let context = this.getContext() as UIAbilityContext;
      let win: window.Window = null;
      try {
        win = await window.getWindow(context);
        win.setWindowLayoutFullScreen(true);
      } catch (e) {
        console.error(`Failed to set full screen. Code:${(e as BusinessError).code}, Message:${(e as BusinessError).message}`);
      }
    })
  }
}

// --- Color Constants ---
const Colors = {
  Primary: '#6D4C41',
  Secondary: '#A1887F',
  BackgroundTint: '#F5F5F5',
  Outline: '#EEEEEE',
  TextPrimary: '#000000',
  TextSecondary: '#9E9E9E',
  Favorite: '#FFCDD2'
};

// --- Components ---

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Good Morning,")
          .fontSize(14)
          .fontColor(Colors.TextSecondary)
          .fontWeight(FontWeight.Normal)
        
        Text("Tea Master")
          .fontSize(28)
          .fontColor(Colors.TextPrimary)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Spacer()

      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for gear icon
          .width(24)
          .height(24)
          .fillColor(Colors.TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(Colors.BackgroundTint)
      .borderRadius(24)
    }
    .width('100%')
    .margin({ top: 40, bottom: 32 })
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      // Custom Icon Box
      Stack() {
        Circle()
          .fill('#EFEBE9')
          .width(60)
          .height(60)
        
        // Drawing the leaf/clock icon manually
        CanvasRenderingContext2D
          .drawText("I", new Font({ family: 'sans-serif', size: 20 }), 0, 0) // Simplified representation
          .position({ x: -10, y: -10 }) // Centering hack
          
        // Using a simple circle with line to mimic the specific icon in screenshot
        Row() {
          Circle().width(24).height(24).stroke(Colors.Primary).strokeWidth(2)
          Line().width(2).height(12).fill(Colors.Primary).margin({ left: -1, top: -6 })
        }
      }

      Column() {
        Text("Earl Grey Reserve")
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.TextPrimary)
        
        Text("Black Tea • 95°C")
          .fontSize(14)
          .fontColor(Colors.Secondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16 })

      Spacer()

      Image($r('app.media.ic_heart_fill')) // Placeholder for heart
        .width(24)
        .height(24)
        .fillColor(Colors.Favorite)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: Colors.Outline })
    .margin({ bottom: 32 })
  }
}

@Component
struct TimerDisplay {
  build() {
    Stack() {
      // Background Track
      Circle()
        .width(220)
        .height(220)
        .stroke(Colors.BackgroundTint)
        .strokeWidth(12)

      // Progress Arc (Custom Drawn)
      // The screenshot shows an arc starting roughly at 7 o'clock and ending at 5 o'clock
      // This corresponds to approx 210 degrees to 330 degrees if 0 is 3 o'clock.
      // Or simpler: Start at -150deg, sweep 240deg.
      Path()
        .arcTo({ 
          x: 110, y: 110, radiusX: 110, radiusY: 110, 
          startAngle: -150, endAngle: 90, anticlockwise: false 
        })
        .stroke(Colors.Primary)
        .strokeWidth(12)
        .lineCap(LineCap.Round)
        .width(220)
        .height(220)

      Column() {
        Text("Steeping")
          .fontSize(14)
          .fontColor(Colors.TextSecondary)
          .letterSpacing(2)
          .fontWeight(FontWeight.Medium)
        
        Text("02:00")
          .fontSize(56)
          .fontColor(Colors.TextPrimary)
          .fontWeight(FontWeight.Light)
          .margin({ top: 4 })
      }
    }
    .width(220)
    .height(220)
    .margin({ bottom: 40 })
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      // Reset Button
      Button() {
        Image($r('app.media.ic_refresh')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(Colors.TextSecondary)
      }
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .borderRadius(30)
      .border({ width: 1, color: '#E0E0E0' })

      // Start Button
      Button() {
        Row() {
          Image($r('app.media.ic_play')) // Placeholder
            .width(18)
            .height(18)
            .fillColor(Color.White)
          
          Text("Start")
            .fontSize(16)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 8 })
        }
      }
      .width(120)
      .height(60)
      .backgroundColor(Colors.Primary)
      .borderRadius(30)
      .margin({ left: 24, right: 24 })

      // Add Note Button
      Button() {
        Image($r('app.media.ic_add')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(Colors.TextSecondary)
      }
      .width(60)
      .height(60)
      .backgroundColor(Color.White)
      .borderRadius(30)
      .border({ width: 1, color: '#E0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .margin({ bottom: 24 })
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text("PREPARATION")
        .fontSize(12)
        .fontColor('#999999')
        .fontWeight(FontWeight.Bold)
        .letterSpacing(1)
        .margin({ bottom: 16 })
      
      StepItem(number: "1", text: "Boil fresh water to 95°C")
      Divider().color(Colors.Outline).margin({ top: 8, bottom: 8 })
      StepItem(number: "2", text: "Add 1 tsp of loose leaf per cup")
      Divider().color(Colors.Outline).margin({ top: 8, bottom: 8 })
      StepItem(number: "3", text: "Pour water and wait for timer")
    }
    .width('100%')
  }
}

@Component
struct StepItem {
  @Prop number: string;
  @Prop text: string;

  build() {
    Row() {
      Text(this.number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.TextPrimary)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(Colors.BackgroundTint)
        .borderRadius(12)
      
      Text(this.text)
        .fontSize(14)
        .fontColor(Colors.TextSecondary)
        .margin({ left: 12 })
      
      Spacer()
      
      Image($r('app.media.ic_check')) // Placeholder
        .width(12)
        .height(12)
        .fillColor(Colors.Outline)
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
  }
}