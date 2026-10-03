import { Window } from '@kit.ArkUI'

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
          .fontWeight(FontWeight.Light)
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
          InfoItem(label: "TEMP", value: "80°C")
          InfoItem(label: "WATER", value: "70ml")
          InfoItem(label: "BAMBOO", value: "Whisk")
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard(number: "01", text: "Sift 2g of matcha powder.")
        
        Blank().height(12)
        
        StepCard(number: "02", text: "Add hot water. Whisk in 'M' shape.")
        
        Blank().height(32)

        Button() {
          Row() {
            // Play Icon Simulation using a simple triangle path or text for simplicity in pure ArkTS without assets
            // Using a custom drawing for the icon to match the request strictly
            CustomPlayIcon()
            
            Text("START TIMER")
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
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
  build() {
    CanvasRenderingContext2D()
      .draw((ctx: CanvasRenderingContext2D, width: number, height: number) => {
        ctx.beginPath()
        ctx.moveTo(4, 2)
        ctx.lineTo(16, 10)
        ctx.lineTo(4, 18)
        ctx.closePath()
        ctx.fillStyle = '#FFFFFF'
        ctx.fill()
      })
      .width(20)
      .height(20)
  }
}

@Component
struct MatchaBowlCanvas {
  build() {
    CanvasRenderingContext2D()
      .draw((ctx: CanvasRenderingContext2D, width: number, height: number) => {
        const w = width
        const h = height
        
        // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
        ctx.beginPath()
        ctx.moveTo(w * 0.15, h * 0.4) // Top Left
        ctx.lineTo(w * 0.85, h * 0.4) // Top Right
        ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9) // Control, Bottom Center
        ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4) // Control, Back to Top Left
        ctx.closePath()
        ctx.fillStyle = '#333333'
        ctx.fill()
        
        // 2. Draw the Liquid (Matcha) inside
        ctx.beginPath()
        ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, 2 * Math.PI)
        ctx.fillStyle = '#8BBD52'
        ctx.fill()
        
        // 3. Draw Steam (Simple lines)
        ctx.strokeStyle = 'rgba(211, 211, 211, 0.5)'
        ctx.lineWidth = 4
        ctx.lineCap = 'round'
        
        // Line 1
        ctx.beginPath()
        ctx.moveTo(w * 0.4, h * 0.3)
        ctx.lineTo(w * 0.4, h * 0.15)
        ctx.stroke()
        
        // Line 2
        ctx.beginPath()
        ctx.moveTo(w * 0.5, h * 0.25)
        ctx.lineTo(w * 0.5, h * 0.1)
        ctx.stroke()
        
        // Line 3
        ctx.beginPath()
        ctx.moveTo(w * 0.6, h * 0.3)
        ctx.lineTo(w * 0.6, h * 0.15)
        ctx.stroke()
      })
      .width('100%')
      .height('100%')
  }
}

@Component
struct InfoItem {
  label: string
  value: string

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
  number: string
  text: string

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