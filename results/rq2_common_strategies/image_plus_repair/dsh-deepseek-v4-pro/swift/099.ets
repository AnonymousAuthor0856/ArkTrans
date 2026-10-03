// MARK: - Color Extension for Hex Initialization
// 方便使用十六进制颜色值，与 Android Compose 的 Color(0xFF...) 对应
// ArkTS 没有 SwiftUI 的 extension 语法，这里用全局函数实现等价的十六进制颜色构造
function toHexByte(v: number): string {
  const s: string = v.toString(16)
  return s.length < 2 ? '0' + s : s
}

function colorFromHex(hex: number, alpha: number = 1.0): string {
  const r: number = (hex >> 16) & 0xFF
  const g: number = (hex >> 8) & 0xFF
  const b: number = hex & 0xFF
  const a: number = Math.round(alpha * 255)
  return '#' + toHexByte(a) + toHexByte(r) + toHexByte(g) + toHexByte(b)
}

// MARK: - MatchaBrewingScreen
@Component
struct MatchaBrewingScreen {
  build() {
    // STRICT: Pure White Background
    // 使用 Color.white 作为背景，并忽略安全区域，实现全屏效果
    Column() {
      // Top Section: Title
      // 对应 Android 的 Column(horizontalAlignment = Alignment.CenterHorizontally)
      Column() {
        // Spacer 对应 Android 的 Spacer(modifier = Modifier.height(X.dp))
        Blank().height(48)
        Text('MATCHA RITUAL')
          .fontSize(14) // fontSize = 14.sp
          .letterSpacing(4) // letterSpacing = 4.sp
          .fontWeight(FontWeight.Bold) // fontWeight = FontWeight.Bold
          .fontColor(Color.Gray) // color = Color.Gray
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28) // fontSize = 28.sp
          .fontWeight(FontWeight.Lighter) // fontWeight = FontWeight.Light
          .fontColor(Color.Black) // color = Color.Black
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')

      // Middle Section: Visual Art & Stats
      // 使用 layoutWeight(1) 配合 Column 实现 SpaceBetween 效果
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160) // modifier = Modifier.size(160.dp)

        Blank().height(40) // Spacer(modifier = Modifier.height(40.dp))

        // Info Row - 使用 Spacers 实现 SpaceEvenly 效果
        Row() { // 对应 Android 的 Row(horizontalArrangement = Arrangement.SpaceEvenly)
          Blank() // 左侧 Spacer
          InfoItem({ label: 'TEMP', value: '80°C' })
          Blank() // 元素间 Spacer
          InfoItem({ label: 'WATER', value: '70ml' })
          Blank() // 元素间 Spacer
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
          Blank() // 右侧 Spacer
        }
        .width('100%') // modifier = Modifier.fillMaxWidth()
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1) // 允许中间部分占据所有可用空间，实现垂直方向的 SpaceBetween

      // Bottom Section: Instructions & Action
      // 对应 Android 的 Column(horizontalAlignment = Alignment.CenterHorizontally)
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank().height(12) // Spacer(modifier = Modifier.height(12.dp))
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

        Blank().height(32) // Spacer(modifier = Modifier.height(32.dp))

        // 对应 Android Button 内部的 Icon 和 Text 以及 Spacer(modifier = Modifier.width(8.dp))
        Button({ type: ButtonType.Normal }) {
          Row({ space: 8 }) {
            Text('▶') // Icons.Default.PlayArrow 对应 SF Symbols 的 play.fill
              .fontSize(20) // modifier = Modifier.size(20.dp)
              .fontColor(Color.White) // 按钮内容颜色，对应 onPrimary = Color.White
            Text('START TIMER')
              .fontSize(16) // fontSize = 16.sp
              .fontWeight(FontWeight.Medium) // fontWeight = FontWeight.SemiBold
              .fontColor(Color.White) // 按钮内容颜色，对应 onPrimary = Color.White
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%') // 确保按钮占据最大宽度
        .height(56) // fillMaxWidth().height(56.dp)
        .backgroundColor(colorFromHex(0xFF556B2F)) // containerColor = Color(0xFF556B2F)
        .borderRadius(28) // shape = RoundedCornerShape(28.dp)
        .onClick(() => {
          // No logic required, just a placeholder action
        })

        Blank().height(24) // Spacer(modifier = Modifier.height(24.dp))
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%') // modifier = Modifier.fillMaxWidth()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24) // 对应 Android 的 modifier = Modifier.padding(24.dp)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // statusBarHidden(true)：隐藏状态栏，实现全屏沉浸式效果
  }
}

// MARK: - MatchaBowlCanvas
// 自定义绘制抹茶碗和蒸汽，对应 Android 的 @Composable fun MatchaBowlCanvas
@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  // Dark charcoal bowl
  private bowlColor: string = colorFromHex(0xFF333333)
  // Bright matcha green
  private matchaColor: string = colorFromHex(0xFF8BBD52)

  build() {
    Canvas(this.context) // SwiftUI 的 Canvas 视图，用于自定义 2D 绘图
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawBowl()
      })
  }

  private drawBowl(): void {
    const w: number = this.context.width
    const h: number = this.context.height

    // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
    this.context.beginPath()
    this.context.moveTo(w * 0.15, h * 0.4) // moveTo
    this.context.lineTo(w * 0.85, h * 0.4) // lineTo
    // quadraticBezierTo
    this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    // quadraticBezierTo
    this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    this.context.closePath() // close()

    this.context.fillStyle = this.bowlColor
    this.context.fill() // drawPath

    // 2. Draw the Liquid (Matcha) inside
    this.context.beginPath()
    // drawOval：CGRect(x: w * 0.2, y: h * 0.42, width: w * 0.6, height: h * 0.15)
    this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, 2 * Math.PI)
    this.context.fillStyle = this.matchaColor
    this.context.fill()

    // 3. Draw Steam (Simple lines)
    // Color.LightGray.copy(alpha = 0.5f)
    this.context.strokeStyle = '#80808080'
    // strokeWidth = 4f, cap = StrokeCap.Round
    this.context.lineWidth = 4
    this.context.lineCap = 'round'

    this.context.beginPath()
    this.context.moveTo(w * 0.4, h * 0.3)
    this.context.lineTo(w * 0.4, h * 0.15)
    this.context.stroke() // drawLine

    this.context.beginPath()
    this.context.moveTo(w * 0.5, h * 0.25)
    this.context.lineTo(w * 0.5, h * 0.1)
    this.context.stroke() // drawLine

    this.context.beginPath()
    this.context.moveTo(w * 0.6, h * 0.3)
    this.context.lineTo(w * 0.6, h * 0.15)
    this.context.stroke() // drawLine
  }
}

// MARK: - InfoItem
// 对应 Android 的 @Composable fun InfoItem
@Component
struct InfoItem {
  label: string = ''
  value: string = ''

  build() {
    // horizontalAlignment = Alignment.CenterHorizontally
    Column() {
      Text(this.label)
        .fontSize(10) // fontSize = 10.sp
        .fontWeight(FontWeight.Bold) // fontWeight = FontWeight.Bold
        .fontColor('#80808080') // Color.LightGray（.gray.opacity(0.5)）
      Blank().height(4) // Spacer(modifier = Modifier.height(4.dp))
      Text(this.value)
        .fontSize(16) // fontSize = 16.sp
        .fontWeight(FontWeight.Medium) // fontWeight = FontWeight.Medium
        .fontColor(Color.Black) // color = Color.Black
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StepCard
// 对应 Android 的 @Composable fun StepCard
@Component
struct StepCard {
  number: string = ''
  text: string = ''

  build() {
    // verticalAlignment = Alignment.CenterVertically
    Row() {
      Stack() { // 对应 Android 的 Box
        Circle() // 对应 Android 的 CircleShape
          .fill(colorFromHex(0xFFF5F5F5)) // background(Color(0xFFF5F5F5))
          .width(32)
          .height(32) // size(32.dp)
        Text(this.number)
          .fontSize(12) // fontSize = 12.sp
          .fontWeight(FontWeight.Bold) // fontWeight = FontWeight.Bold
          .fontColor(Color.Black) // color = Color.Black
      }
      Blank().width(16) // Spacer(modifier = Modifier.width(16.dp))
      Text(this.text)
        .fontSize(14) // fontSize = 14.sp
        .fontColor('#4D4D4D') // Color.DarkGray（Color(white: 0.3)）
    }
    .alignItems(VerticalAlign.Center)
    .width('100%') // fillMaxWidth()
    .padding(16) // padding(16.dp)
    // 使用 border 模拟 Android 的 border 修饰符
    .border({ width: 1, color: colorFromHex(0xFFEEEEEE), radius: 12 }) // border(1.dp, Color(0xFFEEEEEE))
    // 注意：SwiftUI 的 cornerRadius 默认裁剪内容，这里为了确保边框和内容都圆角，可以再加一个
    // 但由于 border 已经提供了圆角边框，这里可以省略，或者用于裁剪内容
    // .borderRadius(12)
  }
}

// MARK: - App Entry Point
// SwiftUI 应用的入口点，对应 Android 的 MainActivity
@Entry
@Component
struct MatchaApp {
  build() {
    // @Entry 的 build 必须有且仅有一个容器组件作为根节点，这里用 Column 承载内容视图
    Column() {
      MatchaBrewingScreen()
      // .statusBarHidden(true) 已经移到 MatchaBrewingScreen 内部，确保只影响该视图
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Preview Provider
// 对应 Android 的 @Preview
@Preview
@Component
struct MatchaBrewingScreen_Previews {
  build() {
    MatchaBrewingScreen()
  }
}
