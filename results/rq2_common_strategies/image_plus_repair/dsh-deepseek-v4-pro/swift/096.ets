// MARK: - 1. Colors
// 定义自定义颜色常量，以便在整个应用中保持一致性，并易于修改。
// 对应 SwiftUI 的 extension Color { static let ... }。ArkUI 使用十六进制颜色字符串表示。
const pureWhite: string = '#FFFFFF'
const offWhite: string = '#FAFAFA'
const textPrimary: string = '#1A1A1A'
const textSecondary: string = '#757575'
const accentGreen: string = '#4CAF50'
const accentWarning: string = '#FF9800'
const dividerColor: string = '#EEEEEE'

// MARK: - 2. Main App Structure (@main 入口)
// 这是 SwiftUI 应用的入口点。
// SwiftUI 的 @main + App + WindowGroup 对应 ArkUI 的 @Entry 装饰器组件。
@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      AeroSenseContentView()
    }
    .width('100%')
    .height('100%')
    // 要求 2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
    // .ignoresSafeArea(.all) 使内容延伸到屏幕边缘 —— 对应 expandSafeArea。
    // .statusBarHidden() 隐藏顶部状态栏 —— ArkUI 通过窗口 API 实现，此处省略。
    .expandSafeArea([SafeAreaType.SYSTEM, SafeAreaType.CUTOUT])
  }
}

// 整个应用的主视图，模拟 Android 的 Scaffold 结构。
@Component
struct AeroSenseContentView {
  build() {
    Stack({ alignContent: Alignment.TopStart }) { // 使用 Stack 来分层内容，将底部控制栏置于最上层。
      // 主垂直堆栈，用于顶部标题、主要内容和底部控制栏。
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24 }) // 对应 Android 的 padding(horizontal = 24.dp)
          .padding({ top: 24, bottom: 24 }) // 对应 Android 的 padding(vertical = 24.dp)

        // MainContent 包含滚动视图，并填充可用空间。
        MainContent()
          .padding({ left: 24, right: 24 }) // 对应 Android 的 contentPadding(horizontal = 24.dp)
          .padding({ bottom: 16 }) // 在滚动内容和底部栏之间添加一些底部留白
          .layoutWeight(1) // 使 MainContent 填充所有可用空间。
          .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(pureWhite) // 确保内容后面的背景是白色。

      Column() {
        Blank() // 将 BottomControlBar 推到底部。
        BottomControlBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(pureWhite) // Color.pureWhite.ignoresSafeArea() —— 设置整个屏幕的背景色。
  }
}

// MARK: - 3. Top Header (顶部标题栏)
@Component
struct TopHeader {
  build() {
    Row() { // 对应 Android 的 Row
      Column() { // 对应 Android 的 Column
        Text('Living Room')
          // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(textSecondary)
        Text('AeroSense')
          // 对应 MaterialTheme.typography.headlineMedium (通常为 34sp)
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // 对应 Android 的 horizontalArrangement = Arrangement.SpaceBetween

      Button() { // action: { /* No op */ }
        Text('⚙') // Image(systemName: "gearshape.fill") —— 对应 Icons.Filled.Settings (SF Symbols)
          // 对应 Icon 默认大小
          .fontSize(24)
          .fontColor(textPrimary)
          // 对应 Modifier.size(48.dp)
          .width(48)
          .height(48)
          // 对应 Modifier.background(OffWhite, CircleShape)
          .backgroundColor(offWhite)
          // 对应 CircleShape
          .borderRadius(24)
      }
      .backgroundColor(Color.Transparent)
    }
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - 4. Main Content (主内容区域)
@Component
struct MainContent {
  build() {
    // 对应 Android 的 LazyColumn
    Scroll() {
      Column({ space: 32 }) { // 对应 Android 的 verticalArrangement = Arrangement.spacedBy(32.dp)
        // 1. Main Air Quality Indicator
        AirQualityCircle({ aqi: 42 })

        // 2. Metrics Grid
        Column({ space: 16 }) { // 对应 Android 的 Spacer(modifier = Modifier.height(16.dp))
          Row({ space: 16 }) { // 对应 Android 的 Row, horizontalArrangement = Arrangement.spacedBy(16.dp)
            MetricCard({ label: 'Temp', value: '23°C', iconName: 'ⓘ', statusColor: textPrimary }) // 对应 Icons.Filled.Info
              .layoutWeight(1)
            MetricCard({ label: 'Humidity', value: '45%', iconName: '✓', statusColor: accentGreen }) // 对应 Icons.Filled.Check
              .layoutWeight(1)
          }
          Row({ space: 16 }) { // 对应 Android 的 Row, horizontalArrangement = Arrangement.spacedBy(16.dp)
            MetricCard({ label: 'PM 2.5', value: '12', iconName: '✓', statusColor: accentGreen }) // 对应 Icons.Filled.CheckCircle
              .layoutWeight(1)
            MetricCard({ label: 'CO2', value: '850', iconName: '⚠', statusColor: accentWarning }) // 对应 Icons.Filled.Warning
              .layoutWeight(1)
          }
        }

        // 3. Status Message
        StatusBanner()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 }) // 对应 Android 的 contentPadding(vertical = 16.dp)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off) // showsIndicators: false
    .scrollable(ScrollDirection.Vertical)
    .align(Alignment.Top)
  }
}

// MARK: - 5. Air Quality Circle (空气质量指示器)
@Component
struct AirQualityCircle {
  @Prop aqi: number = 0

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    // 使用 Stack 模拟 Android 的 Box，并设置内容居中对齐。
    Stack({ alignContent: Alignment.Center }) {
      // 使用 Canvas 进行自定义绘图。
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          let lineWidth: number = 40.0 // 对应 Stroke(width = 40f)
          let radius: number = (Math.min(220, 220) - lineWidth) / 2
          let centerX: number = 220 / 2
          let centerY: number = 220 / 2

          // 背景轨道
          this.context.lineWidth = lineWidth
          this.context.lineCap = 'round'
          this.context.strokeStyle = offWhite
          this.context.beginPath()
          // 对应 startAngle = 135f, sweepAngle = 270f；clockwise: false 表示逆时针绘制。
          this.context.arc(centerX, centerY, radius, 135 * Math.PI / 180, (135 + 270) * Math.PI / 180, true)
          this.context.stroke()

          // 进度轨道 (根据 AQI 42/100 大致计算)
          this.context.strokeStyle = accentGreen
          this.context.beginPath()
          // 对应 startAngle = 135f, sweepAngle = 110f (270 * 42/100 ≈ 113.4，这里使用 110 接近)
          this.context.arc(centerX, centerY, radius, 135 * Math.PI / 180, (135 + 110) * Math.PI / 180, true)
          this.context.stroke()

          // 装饰点 (位于进度条的末端)
          let dotRadius: number = 12.0 // 对应 radius = 12f
          let angleForDot: number = (135 + 110) * Math.PI / 180 // 进度条结束的角度
          let xOffset: number = radius * Math.cos(angleForDot)
          let yOffset: number = radius * Math.sin(angleForDot)
          let dotCenterX: number = centerX + xOffset
          let dotCenterY: number = centerY + yOffset
          this.context.fillStyle = pureWhite
          this.context.beginPath()
          this.context.arc(dotCenterX, dotCenterY, dotRadius / 2, 0, 2 * Math.PI)
          this.context.fill()
        })

      Column() { // 对应 Android 的 Column, horizontalAlignment = Alignment.CenterHorizontally
        Text('AQI')
          // 对应 MaterialTheme.typography.labelLarge (通常为 14sp)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(textSecondary)
          .letterSpacing(2) // 对应 letterSpacing = 2.sp
        Text(`${this.aqi}`)
          // 对应 MaterialTheme.typography.displayLarge, fontSize = 80.sp
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(textPrimary)
        Text('Excellent')
          // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(accentGreen)
          .padding({ left: 12, right: 12 }) // 对应 padding(horizontal = 12.dp)
          .padding({ top: 6, bottom: 6 }) // 对应 padding(vertical = 6.dp)
          .backgroundColor('#1A4CAF50') // 对应 AccentGreen.copy(alpha = 0.1f)
          .borderRadius(16) // 对应 RoundedCornerShape(16.dp)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%') // 对应 Modifier.fillMaxWidth()
    .aspectRatio(1.2) // 对应 Modifier.aspectRatio(1.2f)
  }
}

// MARK: - 6. Metric Card (指标卡片)
@Component
struct MetricCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconName: string = ''
  @Prop statusColor: string = '#1A1A1A'

  build() {
    Column() { // 对应 Android 的 Column, verticalArrangement = Arrangement.SpaceBetween
      Row() {
        Text(this.iconName) // Image(systemName: iconName)
          .fontSize(20)
          .fontColor(this.statusColor)
        Blank() // 确保图标在左侧，并填充剩余空间
      }
      .width('100%')

      Blank() // 将内容推向顶部和底部

      Column({ space: 4 }) { // 对应 Android 的 Column
        Text(this.value)
          // 对应 MaterialTheme.typography.headlineSmall (通常为 24sp)
          .fontSize(24)
          .fontWeight(FontWeight.Medium) // .semibold —— ArkUI 无 Semibold，用 Medium 近似
          .fontColor(textPrimary)
        Text(this.label)
          // 对应 MaterialTheme.typography.bodySmall (通常为 12sp)
          .fontSize(12)
          .fontColor(textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16) // 对应 Modifier.padding(16.dp)
    .height(110) // 对应 Modifier.height(110.dp)
    .backgroundColor(offWhite) // 对应 CardDefaults.cardColors(containerColor = OffWhite)
    .borderRadius(24) // 对应 RoundedCornerShape(24.dp)
    // Android 的 CardDefaults.cardElevation(defaultElevation = 0.dp) 在 SwiftUI 中默认没有阴影，无需额外处理。
  }
}

// MARK: - 7. Status Banner (状态横幅)
@Component
struct StatusBanner {
  build() {
    Column({ space: 12 }) { // 对应 Android 的 Column
      Row({ space: 12 }) { // 对应 Android 的 Row, verticalAlignment = Alignment.CenterVertically
        Text('🏠') // Image(systemName: "house.fill") —— 对应 Icons.Filled.Home
          .fontSize(24)
          .fontColor(textPrimary)
        Text('Room Analysis')
          // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(textPrimary)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        // 对应 MaterialTheme.typography.bodyMedium (通常为 14sp)
        .fontSize(14)
        .fontColor(textSecondary)
        // 对应 lineHeight = 22.sp。对于 14sp 的字体，22sp 的行高意味着行间距增加。
        // lineSpacing 在 SwiftUI 中是行与行之间的额外空间。
        .lineHeight(22) // 22sp - 14sp = 8sp
        .width('100%')
        .textAlign(TextAlign.Start) // fixedSize(horizontal: false, vertical: true) —— 允许文本换行并占据所需垂直空间
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20) // 对应 Modifier.padding(20.dp)
    .width('100%') // 对应 Modifier.fillMaxWidth()
    .border({ width: 1, color: dividerColor, radius: 20 }) // 对应 border(1.dp, DividerColor, RoundedCornerShape(20.dp))
  }
}

// MARK: - 8. Bottom Control Bar (底部控制栏)
@Component
struct BottomControlBar {
  build() {
    Column() { // 对应 Android 的 Column
      Divider() // 对应 HorizontalDivider(color = DividerColor)
        .backgroundColor(dividerColor) // 设置 Divider 的颜色

      Row() { // 对应 Android 的 Row, verticalAlignment = Alignment.CenterVertically
        ControlIcon({ iconName: '☰', description: 'Menu' }) // 对应 Icons.Filled.Menu

        Button() { // action: { /* No op */ }
          Row({ space: 8 }) { // 对应 Spacer(modifier = Modifier.width(8.dp))
            Text('⟳') // Image(systemName: "arrow.clockwise") —— 对应 Icons.Filled.Refresh
              .fontSize(18) // 对应 Icon 默认大小
              .fontColor(pureWhite)
            Text('Refresh Data')
              .fontSize(16) // 对应 Text 默认大小
              .fontWeight(FontWeight.Medium)
              .fontColor(pureWhite)
          }
          .padding({ left: 24, right: 24 }) // 对应 contentPadding = PaddingValues(horizontal = 24.dp)
          .padding({ top: 16, bottom: 16 }) // 对应 contentPadding = PaddingValues(vertical = 16.dp)
          .backgroundColor(textPrimary) // 对应 ButtonDefaults.buttonColors(containerColor = TextPrimary)
          .borderRadius(16) // 对应 RoundedCornerShape(16.dp)
        }
        .backgroundColor(Color.Transparent)

        ControlIcon({ iconName: '+', description: 'Add Room' }) // 对应 Icons.Filled.Add
      }
      .alignItems(VerticalAlign.Center)
      .padding(24) // 对应 Modifier.padding(24.dp)
      .width('100%') // 对应 Modifier.fillMaxWidth()
      .backgroundColor(pureWhite) // 对应 Modifier.background(PureWhite)
    }
    .width('100%')
  }
}

// MARK: - 9. Control Icon (底部控制图标)
@Component
struct ControlIcon {
  @Prop iconName: string = ''
  @Prop description: string = ''

  build() {
    Button() { // action: { /* No op */ }
      Text(this.iconName) // Image(systemName: iconName)
        .fontSize(24) // 对应 Icon 默认大小
        .fontColor(textPrimary)
        .width(48) // 对应 Modifier.size(48.dp)
        .height(48)
        .border({ width: 1, color: dividerColor }) // 对应 border(1.dp, DividerColor, CircleShape)
        .borderRadius(24) // 对应 CircleShape
    }
    .backgroundColor(Color.Transparent)
    .accessibilityText(this.description) // 为无障碍功能提供描述
  }
}

// MARK: - Preview (预览)
// SwiftUI 的 PreviewProvider 仅用于 Xcode 预览；ArkTS 中对应 @Preview 装饰器，此处省略。
