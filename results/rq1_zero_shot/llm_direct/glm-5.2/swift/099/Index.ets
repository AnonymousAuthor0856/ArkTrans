// MatchaBrewingScreen.ets

// MARK: - MatchaBrewingScreen
@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    // STRICT: Pure White Background
    // 使用 .backgroundColor(Color.White) 作为背景，并配合 expandSafeArea 实现全屏效果
    Column() {
      // Main Container with 24 padding
      Column() {
        // Top Section: Title
        Column() {
          Blank().height(48) // Spacer
          Text("MATCHA RITUAL")
            .fontSize(14)
            .letterSpacing(4)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
          Blank().height(8)
          Text("Ceremonial Grade")
            .fontSize(28)
            .fontWeight(FontWeight.Lighter) // Closest to .light
            .fontColor(Color.Black)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        // Middle Section: Visual Art & Stats
        // layoutWeight(1) allows this section to take all available space (SpaceBetween effect)
        Column() {
          MatchaBowlCanvas()
            .width(160)
            .height(160)

          Blank().height(40)

          // Info Row - SpaceEvenly effect
          Row() {
            InfoItem({ label: "TEMP", value: "80°C" })
            Blank() // Acts as spacer
            InfoItem({ label: "WATER", value: "70ml" })
            Blank()
            InfoItem({ label: "BAMBOO", value: "Whisk" })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
        .layoutWeight(1)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        // Bottom Section: Instructions & Action
        Column() {
          StepCard({ number: "01", text: "Sift 2g of matcha powder." })
          Blank().height(12)
          StepCard({ number: "02", text: "Add hot water. Whisk in 'M' shape." })

          Blank().height(32)

          // Button
          Row() {
            // Using built-in symbol or text representation for Play Icon
            Text("▶").fontSize(18).fontColor(Color.White)
            Text("START TIMER")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .width('100%')
          .height(56)
          .justifyContent(FlexAlign.Center)
          .backgroundColor("#556B2F")
          .borderRadius(28)

          Blank().height(24)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL]) // Equivalent to ignoresSafeArea
  }
}

// MARK: - MatchaBowlCanvas
// Custom drawing for Matcha Bowl and Steam
@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  
  // Colors
  private bowlColor: string = "#333333"
  private matchaColor: string = "#8BBD52"
  private steamColor: string = "rgba(128, 128, 128, 0.5)"

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        const w = this.context.width
        const h = this.context.height

        // 1. Draw the Bowl
        this.context.beginPath()
        this.context.moveTo(w * 0.15, h * 0.4)
        this.context.lineTo(w * 0.85, h * 0.4)
        // Quad curve approximation using bezierCurveTo
        this.context.bezierCurveTo(w * 0.9, h * 0.9, w * 0.9, h * 0.9, w * 0.5, h * 0.9)
        this.context.bezierCurveTo(w * 0.1, h * 0.9, w * 0.1, h * 0.9, w * 0.15, h * 0.4)
        this.context.closePath()
        this.context.fillStyle = this.bowlColor
        this.context.fill()

        // 2. Draw the Liquid (Matcha)
        this.context.beginPath()
        this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
        this.context.fillStyle = this.matchaColor
        this.context.fill()

        // 3. Draw Steam
        this.context.lineWidth = 4
        this.context.lineCap = "round"
        this.context.strokeStyle = this.steamColor

        // Steam 1
        this.context.beginPath()
        this.context.moveTo(w * 0.4, h * 0.3)
        this.context.lineTo(w * 0.4, h * 0.15)
        this.context.stroke()

        // Steam 2
        this.context.beginPath()
        this.context.moveTo(w * 0.5, h * 0.25)
        this.context.lineTo(w * 0.5, h * 0.1)
        this.context.stroke()

        // Steam 3
        this.context.beginPath()
        this.context.moveTo(w * 0.6, h * 0.3)
        this.context.lineTo(w * 0.6, h * 0.15)
        this.context.stroke()
      })
  }
}

// MARK: - InfoItem
@Component
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor("rgba(128, 128, 128, 0.5)")
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StepCard
@Component
struct StepCard {
  @Prop number: string
  @Prop text: string

  build() {
    Row() {
      // Circle Background with Number
      Stack() {
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)
      .backgroundColor("#F5F5F5")
      .borderRadius(16) // Circle

      Blank().width(16) // Spacer

      Text(this.text)
        .fontSize(14)
        .fontColor("rgba(0, 0, 0, 0.7)") // Dark Gray
        .layoutWeight(1) // Allow text to take remaining space if needed
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: "#EEEEEE", radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}