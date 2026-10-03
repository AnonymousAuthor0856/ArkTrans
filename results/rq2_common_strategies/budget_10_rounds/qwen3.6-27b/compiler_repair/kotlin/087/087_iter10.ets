import { window } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

// Define the main entry component
@Entry
@Component
struct TeaBrewingApp {
  @State isImmersive: boolean = false

  aboutToAppear() {
    // Attempt to set immersive mode (hide system bars)
    try {
      const ctx = getContext(this) as common.UIAbilityContext
      const windowClass: window.Window = window.getWindowSync(ctx)
      windowClass.setWindowSystemBarEnable([window.SystemBarType.NAVIGATION], false)
      this.isImmersive = true
    } catch (e) {
      console.error('Failed to set immersive mode', e)
    }
  }

  build() {
    Column() {
      TeaBrewingScreenFixed()
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

      TimerDisplay()

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
        Image($r('app.media.settings')) // Placeholder for Settings Icon
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
    Canvas()
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
  @State time: string = "02:00"

  build() {
    Stack() {
      // Outer Progress Ring
      Canvas()
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
          .fontWeight(FontWeight.Lighter)
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
        Image($r('app.media.refresh')) // Placeholder
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
          Image($r('app.media.play_arrow')) // Placeholder
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
        Image($r('app.media.add')) // Placeholder
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

// Preparation Steps Refactored
@Component
struct PreparationStepsRefactored {
  build() {
    Column() {
      Text("PREPARATION")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#A9A9A9')
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
        .fontColor('#A9A9A9')
        .layoutWeight(1)

      Image($r('app.media.check'))
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

      TimerDisplay()

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