// MARK: - Color Extension for Hex
// 方便地从十六进制值创建颜色
// 将 SwiftUI 的 Color(hex:alpha:) 扩展翻译为 ArkUI 十六进制颜色助手函数
// ArkUI 颜色字符串采用 #AARRGGBB 格式
function toHex2(value: number): string {
  let s: string = value.toString(16).toUpperCase()
  if (s.length < 2) {
    s = '0' + s
  }
  return s
}

function hexColor(hex: number, alpha: number = 1.0): string {
  const red: number = (hex >> 16) & 0xff
  const green: number = (hex >> 8) & 0xff
  const blue: number = hex & 0xff
  const a: number = Math.round(alpha * 255)
  return '#' + toHex2(a) + toHex2(red) + toHex2(green) + toHex2(blue)
}

// MARK: - Entry Point
// App 的入口点，对应 iOS 16.0 语法
@Entry
@Component
struct LumenApp {
  build() {
    // 要求2: App 必须设置为全屏显示，并确保顶部状态栏隐藏。
    Stack() {
      LumenAppScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Main Screen
// 对应 Kotlin 的 LumenAppScreen Composable
@Component
struct LumenAppScreen {
  // 对应 Kotlin 的 @Composable 状态管理
  @State selectedIso: string = '400'
  @State apertureValue: number = 2.8 // 改为 number 以兼容 Slider
  @State selectedSpeedIndex: number = 4

  private shutterSpeeds: string[] = ['1/1000', '1/500', '1/250', '1/125', '1/60', '1/30', '1/15', '1/8']

  // 定义常量，方便修改比例和控件大小，满足要求7
  private readonly screenPadding: number = 24
  private readonly verticalSpacingLarge: number = 32
  private readonly verticalSpacingMedium: number = 16
  private readonly horizontalSpacingSmall: number = 12

  build() {
    // 对应 Kotlin 的 MaterialTheme 和 Surface(color = Color.White)
    Stack() {
      Column() { // 对应 Kotlin 的 Column，spacing 0 允许内部 Spacer 控制间距
        // 1. Header
        HeaderSection()
          .padding({ bottom: this.verticalSpacingMedium }) // 对应 padding(bottom = 16.dp)

        // 2. Main Display (The "Shot")
        CurrentSettingsDisplay({
          iso: this.selectedIso,
          aperture: this.apertureValue.toFixed(1), // 格式化浮点数
          shutter: this.shutterSpeeds[this.selectedSpeedIndex]
        })

        // Spacer 模拟 Arrangement.SpaceBetween，将内容推向顶部和底部
        Blank().layoutWeight(1)

        // 3. Controls
        Column({ space: this.verticalSpacingLarge }) { // 对应 Arrangement.spacedBy(32.dp)
          // ISO Selector
          IsoSelector({
            currentIso: this.selectedIso,
            onIsoSelected: (iso: string) => {
              this.selectedIso = iso
            }
          })

          // Aperture Slider
          ApertureControl({ value: $apertureValue }) // 使用 @Link 双向绑定传递 Slider 状态

          // Shutter Speed Selector
          ShutterSpeedControl({
            speeds: this.shutterSpeeds,
            selectedIndex: this.selectedSpeedIndex,
            onSelect: (index: number) => {
              this.selectedSpeedIndex = index
            }
          })
        }
        .width('100%')

        // Spacer 模拟 Arrangement.SpaceBetween
        Blank().layoutWeight(1)

        // 4. Bottom Action
        LogShotButton()
      }
      .padding(this.screenPadding) // 对应 Modifier.padding(24.dp)
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White) // 确保背景覆盖整个屏幕，包括安全区域
    .width('100%')
    .height('100%')
    // ignoresSafeArea() 使得视图内容扩展到屏幕边缘，包括安全区域。
    // statusBarHidden(true) 隐藏顶部状态栏（对应 ArkUI 的系统栏属性，需通过窗口属性配置）。
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - Sub-Components
// 对应 Kotlin 的 HeaderSection Composable
@Component
struct HeaderSection {
  private readonly bottomPadding: number = 16
  private readonly letterSpacingHeader: number = 2 // 对应 letterSpacing = 2.sp
  private readonly iconButtonSize: number = 44 // 对应 Material IconButton 的默认触摸目标大小

  build() {
    Row() { // 对应 Kotlin 的 Row
      Column() { // 对应 Kotlin 的 Column
        Text('LUMEN LOG')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingHeader) // 对应 letterSpacing
          .fontColor(Color.Gray)
        Text('Roll #034')
          .fontSize(24)
          .fontWeight(FontWeight.Bolder) // ExtraBold 对应 .heavy，ArkUI 使用 Bolder 近似
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // 对应 fillMaxWidth 和 SpaceBetween

      Row() { // 对应 Kotlin 的 Row
        Button() {
          Text('☰') // 对应 Icons.Default.Menu (SF Symbol)
            .fontSize(22) // 调整图标大小
            .fontColor(Color.Black)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          /* No-op */
        })

        Button() {
          Text('⚙') // 对应 Icons.Default.Settings (SF Symbol)
            .fontSize(22) // 调整图标大小
            .fontColor(Color.Black)
        }
        .width(this.iconButtonSize)
        .height(this.iconButtonSize)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          /* No-op */
        })
      }
    }
    .width('100%')
  }
}

// 对应 Kotlin 的 CurrentSettingsDisplay Composable
@Component
struct CurrentSettingsDisplay {
  iso: string = ''
  aperture: string = ''
  shutter: string = ''

  private readonly cardHeight: number = 160 // 对应 height(160.dp)
  private readonly cornerRadius: number = 16 // 对应 RoundedCornerShape(16.dp)
  private readonly horizontalPadding: number = 24 // 对应 padding(start = 24.dp)
  private readonly dividerHeight: number = 80 // 对应 height(80.dp)
  private readonly detailSpacing: number = 16 // 对应 Spacer(modifier = Modifier.height(16.dp))

  build() {
    // 对应 Kotlin 的 Card
    Stack() {
      Row() { // 对应 Kotlin 的 Row，spacing 0 因为 Divider 是显式的
        // Aperture (Main Focus)
        Column() { // 对应 Column, verticalArrangement = Arrangement.Center
          Text('f/' + this.aperture)
            .fontSize(56)
            .fontWeight(FontWeight.Lighter) // .light
            .fontColor(Color.Black)
            .letterSpacing(-2) // 对应 letterSpacing = (-2).sp
          Text('APERTURE')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: this.horizontalPadding })
        .layoutWeight(1.5) // 模拟 weight(1.5f)，赋予更高的布局优先级

        // 使用矩形作为分隔线
        Column()
          .width(1)
          .height(this.dividerHeight) // 对应 width(1.dp).height(80.dp)
          .backgroundColor(hexColor(0xFFE0E0E0)) // 替代 Color.lightGray

        // Details Column
        Column() { // 对应 Column, verticalArrangement = Arrangement.Center
          SettingItemSmall({ label: 'ISO', value: this.iso })
          Blank() // 对应 Spacer(modifier = Modifier.height(16.dp))
            .height(this.detailSpacing)
          SettingItemSmall({ label: 'SHUTTER', value: this.shutter })
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: this.horizontalPadding })
        .layoutWeight(1) // 模拟 weight(1f)，赋予较低的布局优先级
      }
      .width('100%')
      .height('100%')
    }
    .height(this.cardHeight) // 对应 height(160.dp)
    .width('100%') // 对应 fillMaxWidth()
    .backgroundColor(hexColor(0xFFF8F8F8)) // 对应 CardDefaults.cardColors(containerColor)
    .borderRadius(this.cornerRadius)
    .border({ width: 1, color: hexColor(0xFFEEEEEE) }) // 对应 BorderStroke(1.dp)
  }
}

// 对应 Kotlin 的 SettingItemSmall Composable
@Component
struct SettingItemSmall {
  label: string = ''
  value: string = ''

  build() {
    Column() { // 对应 Kotlin 的 Column
      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium) // .semibold 的近似
        .fontColor(Color.Black)
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

// 对应 Kotlin 的 IsoSelector Composable
@Component
struct IsoSelector {
  private readonly isoValues: string[] = ['100', '200', '400', '800', '1600', '3200']
  currentIso: string = ''
  onIsoSelected: (iso: string) => void = (iso: string) => {
  }

  private readonly bottomPadding: number = 12 // 对应 padding(bottom = 12.dp)
  private readonly itemWidth: number = 60 // 对应 size(width = 60.dp)
  private readonly itemHeight: number = 36 // 对应 size(height = 36.dp)
  private readonly cornerRadius: number = 50 // 对应 RoundedCornerShape(50)
  private readonly horizontalSpacing: number = 12 // 对应 Arrangement.spacedBy(12.dp)

  build() {
    Column() { // 对应 Kotlin 的 Column
      Text('Film Stock ISO')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .padding({ bottom: this.bottomPadding })

      Scroll() { // 对应 LazyRow
        Row({ space: this.horizontalSpacing }) { // 对应 Arrangement.spacedBy(12.dp)
          ForEach(this.isoValues, (iso: string) => {
            Text(iso)
              .fontSize(13)
              .fontWeight(FontWeight.Medium) // .semibold 的近似
              .fontColor(this.currentIso === iso ? Color.White : Color.Black)
              .width(this.itemWidth)
              .height(this.itemHeight)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.currentIso === iso ? Color.Black : Color.Transparent) // 对应 background(...)
              .borderRadius(this.cornerRadius) // 对应 clip(RoundedCornerShape(50))
              .border({
                width: 1,
                color: this.currentIso === iso ? '#FF000000' : hexColor(0xFFE0E0E0) // 对应 border(width = 1.dp, color = ...)
              })
              .onClick(() => {
                this.onIsoSelected(iso)
              })
          }, (iso: string) => iso)
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// 对应 Kotlin 的 ApertureControl Composable
@Component
struct ApertureControl {
  @Link value: number // 使用 @Link 双向绑定传递 Slider 状态

  @State trackWidth: number = 0 // 记录轨道宽度，用于计算自定义滑块位置

  private readonly sliderTopSpacing: number = 8 // 对应 Spacer(modifier = Modifier.height(8.dp))
  private readonly iconSize: number = 16 // 对应 Modifier.size(16.dp)
  private readonly sliderStep: number = (16.0 - 1.4) / 20.0 // (valueRange.end - valueRange.start) / steps
  private readonly trackHeight: number = 2 // 对应 Compose SliderDefaults 的轨道高度
  private readonly thumbDiameter: number = 28 // 估算 Material3 Slider 的滑块直径

  private normalizedValue(): number {
    const totalRange: number = 16.0 - 1.4 // valueRange = 1.4f..16f
    return (this.value - 1.4) / totalRange // 当前值在范围内的比例
  }

  build() {
    Column() { // 对应 Kotlin 的 Column
      Row() { // 对应 Kotlin 的 Row
        Text('Aperture Control')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Blank()
        Text('⚙') // 对应 Icons.Default.Settings
          .fontSize(this.iconSize)
          .fontColor(Color.Gray)
      }
      .width('100%')

      Blank() // 对应 Spacer(modifier = Modifier.height(8.dp))
        .height(this.sliderTopSpacing)

      // 为了原子级对应 SliderDefaults.colors，使用 Stack 结合透明 Slider
      Stack({ alignContent: Alignment.Start }) {
        // 非活跃轨道 (inactiveTrackColor)
        Rect({ width: '100%', height: this.trackHeight, radius: this.trackHeight / 2 })
          .fill(hexColor(0xFFE0E0E0))

        // 活跃轨道 (activeTrackColor)
        Rect({ width: this.trackWidth * this.normalizedValue(), height: this.trackHeight, radius: this.trackHeight / 2 })
          .fill(Color.Black)

        // 滑块 (thumbColor)
        Circle({ width: this.thumbDiameter, height: this.thumbDiameter })
          .fill(Color.Black)
          .offset({ x: this.trackWidth * this.normalizedValue() - this.thumbDiameter / 2 })
          .shadow({ radius: 2, color: '#33000000' }) // 增加一点阴影以匹配 Material Design 风格

        // 实际的 Slider，使其透明以显示自定义视觉效果，但保留交互功能
        Slider({ value: this.value, min: 1.4, max: 16.0, step: this.sliderStep, style: SliderStyle.OutSet })
          .width('100%')
          .opacity(0.001) // 几乎完全透明，但仍可交互
          .trackColor(Color.Transparent) // 清除默认轨道颜色
          .selectedColor(Color.Transparent) // 清除默认选中轨道颜色
          .blockColor(Color.Transparent) // 清除默认滑块颜色，避免影响自定义滑块
          .onChange((value: number, mode: SliderChangeMode) => {
            this.value = value
          })
      }
      .width('100%')
      .height(this.thumbDiameter) // 确保 Slider 有足够的高度来显示和交互滑块
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.trackWidth = newValue.width as number
      })

      Row() { // 对应 Kotlin 的 Row
        Text('f/1.4')
          .fontSize(12)
          .fontColor(Color.Gray)
        Blank()
        Text('f/16')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// 对应 Kotlin 的 ShutterSpeedControl Composable
@Component
struct ShutterSpeedControl {
  speeds: string[] = []
  selectedIndex: number = 0
  onSelect: (index: number) => void = (index: number) => {
  }

  private readonly bottomPadding: number = 12 // 对应 padding(bottom = 12.dp)
  private readonly horizontalSpacing: number = 12 // 假设与 ISO 选择器相似的间距

  private prevText(): string {
    return this.selectedIndex - 1 >= 0 ? this.speeds[this.selectedIndex - 1] : '-'
  }

  private currText(): string {
    return this.speeds[this.selectedIndex]
  }

  private nextText(): string {
    return this.selectedIndex + 1 < this.speeds.length ? this.speeds[this.selectedIndex + 1] : '-'
  }

  build() {
    Column() { // 对应 Kotlin 的 Column
      Text('Shutter Speed')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .padding({ bottom: this.bottomPadding })

      Row({ space: this.horizontalSpacing }) { // 对应 Kotlin 的 Row, Arrangement.SpaceBetween
        // 简化显示，只显示选中项及其前后项
        SpeedOption({
          text: this.prevText(),
          isSelected: false,
          onClickCallback: () => {
            if (this.selectedIndex > 0) {
              this.onSelect(this.selectedIndex - 1)
            }
          }
        })

        SpeedOption({
          text: this.currText(),
          isSelected: true,
          onClickCallback: () => {
          }
        }) // 选中项不可点击

        SpeedOption({
          text: this.nextText(),
          isSelected: false,
          onClickCallback: () => {
            if (this.selectedIndex < this.speeds.length - 1) {
              this.onSelect(this.selectedIndex + 1)
            }
          }
        })
      }
      .width('100%') // 确保 Row 填充可用宽度
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// 对应 Kotlin 的 SpeedOption Composable
@Component
struct SpeedOption {
  text: string = ''
  isSelected: boolean = false
  onClickCallback: () => void = () => {
  }

  private readonly itemWidth: number = 100 // 对应 width(100.dp)
  private readonly itemHeight: number = 50 // 对应 height(50.dp)
  private readonly cornerRadius: number = 12 // 对应 RoundedCornerShape(12.dp)

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? 22 : 16)
      .fontWeight(this.isSelected ? FontWeight.Bold : FontWeight.Normal) // Normal 对应 .regular
      .fontColor(this.isSelected ? '#FF000000' : hexColor(0xFFE0E0E0)) // 修复：使用自定义灰色
      .width(this.itemWidth)
      .height(this.itemHeight)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected ? hexColor(0xFFF0F0F0) : '#00000000') // 对应 background
      .borderRadius(this.cornerRadius) // 对应 clip(RoundedCornerShape(12.dp))
      .onClick(() => { // 对应 clickable(enabled = ...)
        if (!this.isSelected && this.text !== '-') {
          this.onClickCallback()
        }
      })
  }
}

// 对应 Kotlin 的 LogShotButton Composable
@Component
struct LogShotButton {
  private readonly buttonHeight: number = 56 // 对应 height(56.dp)
  private readonly cornerRadius: number = 12 // 对应 RoundedCornerShape(12.dp)
  private readonly iconBoxSize: number = 24 // 对应 size(24.dp)
  private readonly iconSize: number = 16 // 对应 size(16.dp)
  private readonly iconTextSpacing: number = 12 // 对应 Spacer(modifier = Modifier.width(12.dp))
  private readonly letterSpacingButton: number = 1 // 对应 letterSpacing = 1.sp

  build() {
    Button() {
      Row({ space: this.iconTextSpacing }) { // 对应 Row, verticalAlignment = Alignment.Center
        Stack() { // 对应 Kotlin 的 Box
          Circle({ width: this.iconBoxSize, height: this.iconBoxSize })
            .fill(Color.White) // 对应 background(Color.White, CircleShape)
          Text('+') // 对应 Icons.Default.Add (SF Symbol)
            .fontSize(this.iconSize)
            .fontColor(Color.Black)
        }
        .width(this.iconBoxSize)
        .height(this.iconBoxSize)

        // Spacer(modifier = Modifier.width(12.dp)) 由 Row 的 spacing 处理
        Text('LOG EXPOSURE')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(this.letterSpacingButton) // 对应 letterSpacing
          .fontColor(Color.White) // 对应 contentColor
      }
      .width('100%')
      .height('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .height(this.buttonHeight) // 对应 height(56.dp)
    .width('100%') // 对应 fillMaxWidth()
    .backgroundColor(Color.Black) // 对应 containerColor
    .borderRadius(this.cornerRadius) // 对应 shape = RoundedCornerShape(12.dp)
    .onClick(() => {
      /* No-op */
    })
  }
}

// MARK: - Preview
// SwiftUI 的预览功能，对应 Kotlin 的 @Preview
@Preview
@Component
struct LumenAppScreen_Previews {
  build() {
    LumenAppScreen()
  }
}
