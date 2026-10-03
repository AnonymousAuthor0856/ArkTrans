//
//  RetroMusicPlayerApp.ets
//  HarmonyOS compatible - full screen - Retro Flat theme
//

// MARK: - Tokens
// SwiftUI's nested enum RM.C is flattened to a static color token class; hex
// colors are expressed as ArkTS resource color strings (see Hex Color section).
class RM {
  static readonly primary: string = '#EF476F'        // 粉色
  static readonly secondary: string = '#FFD166'      // 黄色
  static readonly tertiary: string = '#06D6A0'       // 绿色
  static readonly background: string = '#FFFCF2'     // 背景
  static readonly surface: string = '#FFF8E1'        // 表面
  static readonly surfaceVariant: string = '#FCE7E7' // 表面变体
  static readonly outline: string = '#BDBDBD'        // 轮廓
  static readonly success: string = '#06D6A0'        // 成功
  static readonly warning: string = '#FFA600'        // 警告
  static readonly error: string = '#D62828'          // 错误
  static readonly onPrimary: string = '#FFFFFF'      // 主色上的文字
  static readonly onSecondary: string = '#1F1F1F'    // 副色上的文字
  static readonly onTertiary: string = '#1F1F1F'     // 第三色上的文字
  static readonly onBackground: string = '#1F1F1F'   // 背景上的文字
  static readonly onSurface: string = '#1F1F1F'      // 表面上的文字
}

@Component
struct RetroMusicPlayerRoot {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isDragging: boolean = false
  @State dragStartX: number = 140
  @State dragStartY: number = 140
  @State scaleFactor: number = 1

  // 限制红点在黄色圆环内移动
  private updateKnob(x: number, y: number): void {
    const centerX = 140 * this.scaleFactor
    const centerY = 140 * this.scaleFactor
    const radius = 120 * this.scaleFactor // 圆环半径

    const dx = x - centerX
    const dy = y - centerY
    const distance = Math.sqrt(dx * dx + dy * dy)

    if (distance <= radius) {
      this.knobX = x
      this.knobY = y
    } else {
      const angle = Math.atan2(dy, dx)
      this.knobX = centerX + Math.cos(angle) * radius
      this.knobY = centerY + Math.sin(angle) * radius
    }
  }

  build() {
    Column() {
      // ===== Top App Bar =====
      Stack() {
        Rect()
          .fill(RM.background)
          .height(80 * this.scaleFactor)
          .width('100%')

        Text('Retro Music Player')
          .fontSize(34 * this.scaleFactor)
          .fontWeight(FontWeight.Bold)
          .fontColor(RM.onSurface)
      }
      .height(80 * this.scaleFactor)
      .width('100%')

      Blank()
        .layoutWeight(1)

      // ===== Main Content =====
      Column({ space: 32 * this.scaleFactor }) {
        // ===== Circular Deck =====
        Stack() {
          // Background surface with border (rounded rectangle fill + stroke
          // overlay) is applied via backgroundColor + border on this Stack.
          // Outer circle (record) - 黄色圆环
          Circle()
            .fillOpacity(0)
            .stroke(RM.secondary)
            .strokeWidth(8 * this.scaleFactor)
            .width(240 * this.scaleFactor) // 减小内边距，使圆环更大 (padding 20*scale -> 240*scale circle)
            .height(240 * this.scaleFactor)

          // Draggable knob - 红色圆点
          Circle()
            .fill(RM.primary)
            .width(24 * this.scaleFactor)
            .height(24 * this.scaleFactor)
            .position({ x: this.knobX - 12 * this.scaleFactor, y: this.knobY - 12 * this.scaleFactor })
            .gesture(
              PanGesture({ distance: 0 })
                .onActionStart((event: GestureEvent) => {
                  this.isDragging = true
                  this.dragStartX = this.knobX
                  this.dragStartY = this.knobY
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.updateKnob(this.dragStartX + event.offsetX, this.dragStartY + event.offsetY)
                })
                .onActionEnd(() => {
                  this.isDragging = false
                })
            )
            .animation({ duration: this.isDragging ? 0 : 200, curve: Curve.EaseOut })
        }
        .width(280 * this.scaleFactor)
        .height(280 * this.scaleFactor)
        .backgroundColor(RM.surface)
        .border({ width: 3 * this.scaleFactor, color: RM.outline, radius: 16 * this.scaleFactor })

        // ===== Track Info =====
        Text('Track: Summer Nights')
          .fontSize(22 * this.scaleFactor)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM.onSurface)

        // ===== Control Buttons =====
        Row({ space: 32 * this.scaleFactor }) {
          Button('Play')
            .fontSize(22 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM.onPrimary)
            .width(140 * this.scaleFactor)
            .height(56 * this.scaleFactor)
            .backgroundColor(RM.primary)
            .borderRadius(12 * this.scaleFactor)
            .onClick(() => {
              // Play action
            })

          Button('Pause')
            .fontSize(22 * this.scaleFactor)
            .fontWeight(FontWeight.Medium)
            .fontColor(RM.onSecondary)
            .width(140 * this.scaleFactor)
            .height(56 * this.scaleFactor)
            .backgroundColor(RM.secondary)
            .borderRadius(12 * this.scaleFactor)
            .onClick(() => {
              // Pause action
            })
        }

        // ===== Knob Coordinates =====
        Text('Knob X:268 Y:303') // 固定显示原图坐标
          .fontSize(16 * this.scaleFactor)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM.tertiary)
      }
      .padding({ left: 32 * this.scaleFactor, right: 32 * this.scaleFactor })

      Blank()
        .layoutWeight(1)

      // ===== Bottom Spacer =====
      Rect()
        .fill(Color.Transparent)
        .height(60 * this.scaleFactor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RM.background)
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.scaleFactor = Math.max(Number(newValue.width) / 360.0, Number(newValue.height) / 640.0)
    })
    .onAppear(() => {
      // 初始化旋钮位置为中心，确保在圆环内
      this.knobX = 140 * this.scaleFactor
      this.knobY = 140 * this.scaleFactor
    })
  }
}

// MARK: - App entry
// SwiftUI @main / WindowGroup / ignoresSafeArea / statusBar(hidden:) map to the
// @Entry page (the WindowGroup becomes a full-screen container below); full-screen
// immersive display is configured at the system level.
@Entry
@Component
struct RetroMusicPlayerApp {
  build() {
    Column() {
      RetroMusicPlayerRoot()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Hex Color Extension
// The SwiftUI Color(hex:) initializer is replaced by direct ArkTS hex color
// strings (e.g. '#EF476F') used in the RM tokens above.

// MARK: - Preview
// SwiftUI PreviewProvider maps to ArkUI's @Preview decorator (used in DevEco
// previewer). Kept as a comment to avoid adding a second entry component.
