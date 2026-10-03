// MARK: - 1. Colors
// 定义自定义颜色常量，以便在整个应用中保持一致性，并易于修改。
class AppColors {
  static readonly pureWhite: string = '#FFFFFF';
  static readonly offWhite: string = '#FAFAFA';
  static readonly textPrimary: string = '#1A1A1A';
  static readonly textSecondary: string = '#757575';
  static readonly accentGreen: string = '#4CAF50';
  static readonly accentWarning: string = '#FF9800';
  static readonly dividerColor: string = '#EEEEEE';
  static readonly accentGreenOpacity10: string = '#1A4CAF50'; // 10% opacity
}

// MARK: - 2. Main App Structure (@main 入口)
// 这是 ArkTS 应用的入口点。
@Entry
@Component
struct AeroSenseApp {
  build() {
    // 要求 2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
    // 在 ArkTS 中，可以通过配置窗口或使用 expandSafeArea 来实现类似效果
    Column() {
      AeroSenseContentView()
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .backgroundColor(AppColors.pureWhite)
  }
}

// 整个应用的主视图，模拟 Android 的 Scaffold 结构。
@Component
export struct AeroSenseContentView {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 使用 Stack 来分层内容，将底部控制栏置于最上层。
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        // MainContent 包含滚动视图，并填充可用空间。
        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1) // 使 MainContent 填充所有可用空间。
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.pureWhite)

      // 将 BottomControlBar 推到底部。
      Column() {
        Blank()
        BottomControlBar()
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 3. Top Header (顶部标题栏)
@Component
struct TopHeader {
  build() {
    // 对应 Android 的 Row
    Row() {
      // 对应 Android 的 Column
      Column() {
        Text('Living Room')
          // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.textSecondary)
        Text('AeroSense')
          // 对应 MaterialTheme.typography.headlineMedium (通常为 34sp)
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      // 对应 Android 的 horizontalArrangement = Arrangement.SpaceBetween
      Blank()

      Button({ type: ButtonType.Normal }) {
        // 对应 Icons.Filled.Settings (使用系统资源或自定义资源)
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(AppColors.textPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(AppColors.offWhite)
      .borderRadius(24) // 对应 CircleShape
      .stateEffect(false)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - 4. Main Content (主内容区域)
@Component
struct MainContent {
  build() {
    // 对应 Android 的 LazyColumn
    Scroll() {
      Column() {
        // 1. Main Air Quality Indicator
        AirQualityCircle({ aqi: 42 })

        // 2. Metrics Grid
        // 对应 Android 的 Spacer(modifier = Modifier.height(16.dp))
        Column({ space: 16 }) {
          // 对应 Android 的 Row, horizontalArrangement = Arrangement.spacedBy(16.dp)
          Row({ space: 16 }) {
            MetricCard({
              label: 'Temp',
              value: '23°C',
              iconName: $r('sys.media.ohos_ic_public_info'), // 对应 Icons.Filled.Info
              statusColor: AppColors.textPrimary
            })
            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconName: $r('sys.media.ohos_ic_public_ok'), // 对应 Icons.Filled.Check
              statusColor: AppColors.accentGreen
            })
          }
          .width('100%')

          // 对应 Android 的 Row, horizontalArrangement = Arrangement.spacedBy(16.dp)
          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconName: $r('sys.media.ohos_ic_public_ok'), // 对应 Icons.Filled.CheckCircle
              statusColor: AppColors.accentGreen
            })
            MetricCard({
              label: 'CO2',
              value: '850',
              iconName: $r('sys.media.ohos_ic_public_warning'), // 对应 Icons.Filled.Warning
              statusColor: AppColors.accentWarning
            })
          }
          .width('100%')
        }
        .margin({ top: 32 }) // 对应 Android 的 verticalArrangement = Arrangement.spacedBy(32.dp)

        // 3. Status Message
        StatusBanner()
          .margin({ top: 32 })
      }
      .padding({ top: 16, bottom: 16 }) // 对应 Android 的 contentPadding(vertical = 16.dp)
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// MARK: - 5. Air Quality Circle (空气质量指示器)
@Component
struct AirQualityCircle {
  private aqi: number = 0;

  build() {
    // 使用 Stack 模拟 Android 的 Box，并设置内容居中对齐。
    Stack({ alignContent: Alignment.Center }) {
      // 使用 Canvas 进行自定义绘图
      Canvas({ width: 220, height: 220 }) {
        // 背景轨道
        Arc()
          .width(220)
          .height(220)
          .startAngle(135) // 对应 startAngle = 135f
          .totalAngle(270) // 对应 sweepAngle = 270f
          .strokeWidth(40) // 对应 Stroke(width = 40f)
          .strokeColor(AppColors.offWhite)
          .strokeLineCap(LineCapStyle.Round)

        // 进度轨道 (根据 AQI 42/100 大致计算)
        Arc()
          .width(220)
          .height(220)
          .startAngle(135) // 对应 startAngle = 135f
          .totalAngle(110) // 对应 sweepAngle = 110f (270 * 42/100 ≈ 113.4，这里使用 110 接近)
          .strokeWidth(40)
          .strokeColor(AppColors.accentGreen)
          .strokeLineCap(LineCapStyle.Round)

        // 装饰点 (位于进度条的末端)
        // 在 ArkTS Canvas 中，绘制点需要计算坐标
        Circle({ width: 12, height: 12 })
          .fill(AppColors.pureWhite)
          // 计算进度条末端坐标: center(110, 110), radius=90, angle=135+110=245
          // x = 110 + 90 * cos(245 * PI / 180) ≈ 71.9
          // y = 110 + 90 * sin(245 * PI / 180) ≈ 128.2
          .offset({ x: 65.9, y: 122.2 }) // 调整偏移以对齐圆心
      }
      .width(220)
      .height(220) // 对应 Modifier.size(220.dp)

      // 对应 Android 的 Column, horizontalAlignment = Alignment.CenterHorizontally
      Column() {
        Text('AQI')
          // 对应 MaterialTheme.typography.labelLarge (通常为 14sp)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.textSecondary)
          .letterSpacing(2) // 对应 letterSpacing = 2.sp

        Text(`${this.aqi}`)
          // 对应 MaterialTheme.typography.displayLarge, fontSize = 80.sp
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.textPrimary)

        Text('Excellent')
          // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 }) // 对应 padding(horizontal = 12.dp, vertical = 6.dp)
          .backgroundColor(AppColors.accentGreenOpacity10) // 对应 AccentGreen.copy(alpha = 0.1f)
          .borderRadius(16) // 对应 RoundedCornerShape(16.dp)
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%') // 对应 Modifier.fillMaxWidth()
    .aspectRatio(1.2) // 对应 Modifier.aspectRatio(1.2f)
  }
}

// MARK: - 6. Metric Card (指标卡片)
@Component
struct MetricCard {
  private label: string = '';
  private value: string = '';
  private iconName: Resource = $r('sys.media.ohos_ic_public_info');
  private statusColor: string = AppColors.textPrimary;

  build() {
    // 对应 Android 的 Column, verticalArrangement = Arrangement.SpaceBetween
    Column() {
      Row() {
        Image(this.iconName)
          .width(20)
          .height(20)
          .fillColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      // 将内容推向顶部和底部
      Blank()

      // 对应 Android 的 Column
      Column() {
        Text(this.value)
          // 对应 MaterialTheme.typography.headlineSmall (通常为 24sp)
          .fontSize(24)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppColors.textPrimary)
        Text(this.label)
          // 对应 MaterialTheme.typography.bodySmall (通常为 12sp)
          .fontSize(12)
          .fontColor(AppColors.textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16) // 对应 Modifier.padding(16.dp)
    .height(110) // 对应 Modifier.height(110.dp)
    .layoutWeight(1) // 对应 Modifier.weight(1f)
    .backgroundColor(AppColors.offWhite) // 对应 CardDefaults.cardColors(containerColor = OffWhite)
    .borderRadius(24) // 对应 RoundedCornerShape(24.dp)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - 7. Status Banner (状态横幅)
@Component
struct StatusBanner {
  build() {
    // 对应 Android 的 Column
    Column() {
      // 对应 Android 的 Row, verticalAlignment = Alignment.CenterVertically
      Row() {
        Image($r('sys.media.ohos_ic_public_home')) // 对应 Icons.Filled.Home
          .width(24)
          .height(24)
          .fillColor(AppColors.textPrimary)

        // 对应 Spacer(modifier = Modifier.width(12.dp))
        Blank()
          .width(12)

        Text('Room Analysis')
          // 对应 MaterialTheme.typography.titleMedium (通常为 16sp)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.textPrimary)
      }
      .alignItems(VerticalAlign.Center)

      // 对应 Spacer(modifier = Modifier.height(12.dp))
      Blank()
        .height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        // 对应 MaterialTheme.typography.bodyMedium (通常为 14sp)
        .fontSize(14)
        .fontColor(AppColors.textSecondary)
        // 对应 lineHeight = 22.sp。对于 14sp 的字体，22sp 的行高意味着行间距增加。
        .lineHeight(22)
        // 允许文本换行并占据所需垂直空间
        .maxLines(0)
        .textOverflow({ overflow: TextOverflow.CLIP })
    }
    .padding(20) // 对应 Modifier.padding(20.dp)
    .width('100%') // 对应 Modifier.fillMaxWidth()
    .alignItems(HorizontalAlign.Start)
    .border({
      width: 1,
      color: AppColors.dividerColor,
      radius: 20
    }) // 对应 border(1.dp, DividerColor, RoundedCornerShape(20.dp))
  }
}

// MARK: - 8. Bottom Control Bar (底部控制栏)
@Component
struct BottomControlBar {
  build() {
    // 对应 Android 的 Column
    Column() {
      // 对应 HorizontalDivider(color = DividerColor)
      Divider()
        .color(AppColors.dividerColor)
        .strokeWidth(1)

      // 对应 Android 的 Row, verticalAlignment = Alignment.CenterVertically
      Row() {
        ControlIcon({
          iconName: $r('sys.media.ohos_ic_public_menu'), // 对应 Icons.Filled.Menu
          description: 'Menu'
        })

        Button({ type: ButtonType.Normal }) {
          // 对应 Spacer(modifier = Modifier.width(8.dp))
          Row({ space: 8 }) {
            Image($r('sys.media.ohos_ic_public_refresh')) // 对应 Icons.Filled.Refresh
              .width(18)
              .height(18)
              .fillColor(AppColors.pureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.pureWhite)
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 }) // 对应 contentPadding = PaddingValues(horizontal = 24.dp, vertical = 16.dp)
          .backgroundColor(AppColors.textPrimary) // 对应 ButtonDefaults.buttonColors(containerColor = TextPrimary)
          .borderRadius(16) // 对应 RoundedCornerShape(16.dp)
        }

        ControlIcon({
          iconName: $r('sys.media.ohos_ic_public_add'), // 对应 Icons.Filled.Add
          description: 'Add Room'
        })
      }
      .padding(24) // 对应 Modifier.padding(24.dp)
      .width('100%') // 对应 Modifier.fillMaxWidth()
      .backgroundColor(AppColors.pureWhite) // 对应 Modifier.background(PureWhite)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
  }
}

// MARK: - 9. Control Icon (底部控制图标)
@Component
struct ControlIcon {
  private iconName: Resource = $r('sys.media.ohos_ic_public_menu');
  private description: string = '';

  build() {
    Button({ type: ButtonType.Normal }) {
      Image(this.iconName)
        .width(24)
        .height(24)
        .fillColor(AppColors.textPrimary)
    }
    .width(48)
    .height(48) // 对应 Modifier.size(48.dp)
    .border({
      width: 1,
      color: AppColors.dividerColor,
      radius: 24
    }) // 对应 border(1.dp, DividerColor, CircleShape)
    .stateEffect(false)
    .accessibilityText(this.description) // 为无障碍功能提供描述
  }
}