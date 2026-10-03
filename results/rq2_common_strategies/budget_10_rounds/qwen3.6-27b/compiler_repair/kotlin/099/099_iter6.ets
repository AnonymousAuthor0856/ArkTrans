import { window } from '@kit.ArkUI'

@Entry
@Component
struct MatchaBrewingApp {
  @State isImmersive: boolean = false

  aboutToAppear() {
    // Simulate immersive mode setup (ArkTS handles system bars via window properties usually)
    this.isImmersive = true
  }

  build() {
    Column() {
      MatchaBrewingScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24 })
  }
}

@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Blank().height(48)
        Text("MATCHA RITUAL")
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        
        Blank().height(8)
        
        Text("Ceremonial Grade")
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
      
      // Middle Section: Visual Art & Stats
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160)
        
        Blank().height(40)
        
        Row() {
          InfoItem({ label: "TEMP", value: "80°C" })
          InfoItem({ label: "WATER", value: "70ml" })
          InfoItem({ label: "BAMBOO", value: "Whisk" })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: "01", text: "Sift 2g of matcha powder." })
        
        Blank().height(12)
        
        StepCard({ number: "02", text: "Add hot water. Whisk in 'M' shape." })
        
        Blank().height(32)

        Button() {
          Row() {
            // Play Icon Simulation using a simple triangle path or text for simplicity in pure ArkTS without assets
            // Using a custom drawing for the icon to match the request strictly
            CustomPlayIcon()
            
            Text("START TIMER")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .onClick(() => {
          // No logic required
        })
        
        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct CustomPlayIcon {
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  build() {
    Canvas(this.ctx)
      .onReady((context: CanvasRenderingContext2D) => {
        context.beginPath()
        context.moveTo(4, 2)
        context.lineTo(16, 10)
        context.lineTo(4, 18)
        context.closePath()
        context.fillStyle = '#FFFFFF'
        context.fill()
      })
      .width(20)
      .height(20)
  }
}

@Component
struct MatchaBowlCanvas {
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  build() {
    Canvas(this.ctx)
      .onReady((context: CanvasRenderingContext2D) => {
        const w = context.canvas.width
        const h = context.canvas.height
        
        // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
        context.beginPath()
        context.moveTo(w * 0.15, h * 0.4) // Top Left
        context.lineTo(w * 0.85, h * 0.4) // Top Right
        context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9) // Control, Bottom Center
        context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4) // Control, Back to Top Left
        context.closePath()
        context.fillStyle = '#333333'
        context.fill()
        
        // 2. Draw the Liquid (Matcha) inside
        context.beginPath()
        context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, 2 * Math.PI)
        context.fillStyle = '#8BBD52'
        context.fill()
        
        // 3. Draw Steam (Simple lines)
        context.strokeStyle = 'rgba(211, 211, 211, 0.5)'
        context.lineWidth = 4
        context.lineCap = 'round'
        
        // Line 1
        context.beginPath()
        context.moveTo(w * 0.4, h * 0.3)
        context.lineTo(w * 0.4, h * 0.15)
        context.stroke()
        
        // Line 2
        context.beginPath()
        context.moveTo(w * 0.5, h * 0.25)
        context.lineTo(w * 0.5, h * 0.1)
        context.stroke()
        
        // Line 3
        context.beginPath()
        context.moveTo(w * 0.6, h * 0.3)
        context.lineTo(w * 0.6, h * 0.15)
        context.stroke()
      })
      .width('100%')
      .height('100%')
  }
}

@Component
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3') // LightGray
      
      Blank().height(4)
      
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop number: string
  @Prop text: string

  build() {
    Row() {
      Row() {
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)
      .backgroundColor('#F5F5F5')
      .borderRadius(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      
      Blank().width(16)
      
      Text(this.text)
        .fontSize(14)
        .fontColor('#A9A9A9') // DarkGray
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}