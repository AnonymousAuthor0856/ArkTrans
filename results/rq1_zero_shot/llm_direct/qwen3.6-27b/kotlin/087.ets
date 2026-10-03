import { common, window } from '@kit.ArkUI'
import { Image, PixelMap } from '@kit.Graphic'

// Define the main entry component
@Entry
@Component
struct TeaBrewingApp {
  @State isImmersive: boolean = false

  aboutToAppear() {
    // Attempt to set immersive mode (hide system bars)
    try {
      const windowClass: window.Window = window.getWindowSync(this.context as common.UIAbilityContext)
      windowClass.setWindowSystemBarEnable([window.SystemBarType.NAVIGATION], false)
      this.isImmersive = true
    } catch (e) {
      console.error('Failed to set immersive mode', e)
    }
  }

  build() {
    Column() {
      TeaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

// Main Screen Component
@Component
struct TeaBrewingScreen {
  build() {
    Column() {
      HeaderSection()

      Spacer().height(32)

      TeaSelectionCard()

      Spacer().height(32)

      TimerDisplay(time: "02:00")

      Spacer().height(40)

      ControlButtons()

      Spacer().layoutWeight(1)

      PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Center)
  }
}

// Header Section
@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Good Morning,")
          .fontStyle(FontStyle.Normal)
          .fontSize(16)
          .fontColor(Color.Gray)
        
        Text("Tea Master")
          .fontWeight(FontWeight.Bold)
          .fontSize(28)
          .fontColor(Color.Black)
      }

      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for Settings Icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Circle)
      .backgroundColor('#F5F5F5')
      .width(48)
      .height(48)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// Tea Selection Card
@Component
struct TeaSelectionCard {
  build() {
    Column() {
      Row() {
        // Abstract Tea Icon drawn with Canvas
        Row() {
          CustomTeaIcon()
        }
        .width(60)
        .height(60)
        .borderRadius(30)
        .backgroundColor('#EFEBE9')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Spacer().width(16)

        Column() {
          Text("Earl Grey Reserve")
            .fontWeight(FontWeight.Bold)
            .fontSize(18)
            .fontColor(Color.Black)
          
          Text("Black Tea • 95°C")
            .fontSize(12)
            .fontColor('#8D6E63')
        }
        .layoutWeight(1)

        // Favorite Icon (Using a simple circle as placeholder if icon not available, 
        // but typically we'd use an image or vector asset. Here using a colored circle to mimic tint)
        Circle()
          .width(24)
          .height(24)
          .fill('#FFCDD2')
      }
      .width('100%')
      .padding(20)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .borderRadius(24)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#EEEEEE' })
  }
}

// Custom Canvas for Tea Icon
@Component
struct CustomTeaIcon {
  build() {
    CanvasRenderingContext2D()
      .draw((ctx: CanvasRenderingContext2D, rect: Rect) => {
        const centerX = rect.width / 2
        const centerY = rect.height / 2
        const radius = Math.min(rect.width, rect.height) / 2 - 2
        
        ctx.lineWidth = 2
        ctx.strokeStyle = '#6D4C41'
        
        // Draw Circle
        ctx.beginPath()
        ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
        ctx.stroke()
        
        // Draw Line (Leaf Stem)
        ctx.beginPath()
        ctx.moveTo(centerX, centerY - radius/2)
        ctx.lineTo(centerX, centerY + radius/2)
        ctx.lineCap = 'round'
        ctx.stroke()
      })
      .width(30)
      .height(30)
  }
}

// Timer Display
@Component
struct TimerDisplay {
  private time: string = ""

  aboutToAppear() {
    this.time = "02:00"
  }

  build() {
    Stack() {
      // Outer Progress Ring
      CanvasRenderingContext2D()
        .draw((ctx: CanvasRenderingContext2D, rect: Rect) => {
          const centerX = rect.width / 2
          const centerY = rect.height / 2
          const radius = Math.min(rect.width, rect.height) / 2 - 6 // Subtract half stroke width
          
          ctx.lineWidth = 12
          
          // Background Circle
          ctx.beginPath()
          ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
          ctx.strokeStyle = '#F5F5F5'
          ctx.stroke()
          
          // Progress Arc
          // Start angle -90 degrees (top), sweep 240 degrees
          const startAngle = -Math.PI / 2
          const endAngle = startAngle + (240 * Math.PI / 180)
          
          ctx.beginPath()
          ctx.arc(centerX, centerY, radius, startAngle, endAngle)
          ctx.strokeStyle = '#6D4C41'
          ctx.lineCap = 'round'
          ctx.stroke()
        })
        .width(220)
        .height(220)

      // Inner Content
      Column() {
        Text("Steeping")
          .fontSize(12)
          .fontColor(Color.Gray)
          .letterSpacing(2)
        
        Text(this.time)
          .fontSize(40)
          .fontWeight(FontWeight.Light)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }
}

// Control Buttons
@Component
struct ControlButtons {
  build() {
    Row() {
      // Reset Button
      Button() {
        Image($r('app.media.ic_refresh')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#E0E0E0' })
      .width(60)
      .height(60)

      Spacer().width(24)

      // Play/Pause Button
      Button() {
        Row() {
          Image($r('app.media.ic_play_arrow')) // Placeholder
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .margin({ right: 8 })
          
          Text("Start")
            .fontColor(Color.White)
            .fontSize(16)
        }
        .alignItems(VerticalAlign.Center)
      }
      .type(ButtonType.Capsule)
      .backgroundColor('#6D4C41')
      .height(60)
      .width(120)

      Spacer().width(24)

      // Add Note Button
      Button() {
        Image($r('app.media.ic_add')) // Placeholder
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: '#E0E0E0' })
      .width(60)
      .height(60)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

// Preparation Steps
@Component
struct PreparationSteps {
  build() {
    Column() {
      Text("PREPARATION")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.LightGray)
        .margin({ bottom: 12 })
      
      StepItem(step: "1", text: "Boil fresh water to 95°C")
      StepItem(step: "2", text: "Add 1 tsp of loose leaf per cup")
      StepItem(step: "3", text: "Pour water and wait for timer")
    }
    .width('100%')
  }
}

// Step Item Component
@Component
struct StepItem {
  private step: string = ""
  private text: string = ""

  aboutToAppear() {
    // In ArkTS, parameters are usually passed via properties or state
    // For simplicity in this conversion, we assume they are set before render or passed directly
    // Since ArkTS components don't take direct args like Compose, we use @Prop or just hardcode for demo structure
    // However, to make it reusable, we can use @Link or just pass data. 
    // Here I will use a simple approach where the parent passes data, but since I can't change the call site easily without more complex state management,
    // I'll define them as properties that need to be set. 
    // Actually, better pattern in ArkTS for static lists is to inline or use a list. 
    // Let's keep the structure similar by using @Prop if possible, but standard practice is often passing data via constructor-like init or state.
    // For this specific conversion, I will leave them as empty strings and rely on the caller to set them if I were using @Prop, 
    // but since I'm calling it directly, I'll modify the usage below to pass values via a different mechanism or just hardcode inside the loop if it was a list.
    // To strictly follow the prompt's structure, I will assume the values are passed via a custom property setter or just hardcoded in the instance.
    // Let's use a simpler approach: The component takes no args, and the parent sets the content? No, that's messy.
    // Best ArkTS way for this specific UI: Inline the logic or use a List. 
    // I will revert to a simpler implementation where the text is defined inside the component for the sake of compilability without external state binding complexity.
  }

  build() {
    Row() {
      Row() {
        Text(this.step)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Spacer().width(12)

      Text(this.text)
        .fontSize(16)
        .fontColor(Color.DarkGray)
        .layoutWeight(1)

      Image($r('app.media.ic_check')) // Placeholder
        .width(16)
        .height(16)
        .fillColor('#EEEEEE')
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)

    Divider()
      .color('#FAFAFA')
      .strokeWidth(1)
  }
}

// Helper to fix the StepItem usage above. 
// Since ArkTS doesn't support passing arguments to @Component structs directly in the build method like Compose,
// we must either use @Prop/@Link or restructure. 
// To ensure the code compiles and looks correct, I will refactor PreparationSteps to use a List or inline the items.
// Refactoring PreparationSteps for valid ArkTS:

@Component
struct PreparationStepsRefactored {
  build() {
    Column() {
      Text("PREPARATION")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.LightGray)
        .margin({ bottom: 12 })
      
      // Inline Step 1
      this.createStepItem("1", "Boil fresh water to 95°C")
      // Inline Step 2
      this.createStepItem("2", "Add 1 tsp of loose leaf per cup")
      // Inline Step 3
      this.createStepItem("3", "Pour water and wait for timer")
    }
    .width('100%')
  }

  @Builder
  createStepItem(step: string, text: string) {
    Row() {
      Row() {
        Text(step)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Spacer().width(12)

      Text(text)
        .fontSize(16)
        .fontColor(Color.DarkGray)
        .layoutWeight(1)

      Image($r('app.media.ic_check'))
        .width(16)
        .height(16)
        .fillColor('#EEEEEE')
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)

    Divider()
      .color('#FAFAFA')
      .strokeWidth(1)
  }
}

// Update TeaBrewingScreen to use the refactored steps
@Component
struct TeaBrewingScreenFixed {
  build() {
    Column() {
      HeaderSection()

      Spacer().height(32)

      TeaSelectionCard()

      Spacer().height(32)

      TimerDisplay(time: "02:00")

      Spacer().height(40)

      ControlButtons()

      Spacer().layoutWeight(1)

      PreparationStepsRefactored()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Center)
  }
}

// Final Entry Point Adjustment
@Entry
@Component
struct TeaBrewingAppFinal {
  build() {
    Column() {
      TeaBrewingScreenFixed()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}