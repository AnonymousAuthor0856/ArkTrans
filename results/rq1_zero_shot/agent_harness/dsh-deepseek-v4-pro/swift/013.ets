// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)
// RetroMusicPlayerApp - iOS 16 compatible - full screen - Retro Flat theme

class Point {
  x: number;
  y: number;
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

// MARK: - Tokens
class RM {
  static readonly C = {
    primary: "#EF476F",        // 粉色
    secondary: "#FFD166",      // 黄色
    tertiary: "#06D6A0",       // 绿色
    background: "#FFFCF2",     // 背景
    surface: "#FFF8E1",        // 表面
    surfaceVariant: "#FCE7E7", // 表面变体
    outline: "#BDBDBD",        // 轮廓
    success: "#06D6A0",        // 成功
    warning: "#FFA600",        // 警告
    error: "#D62828",          // 错误
    onPrimary: "#FFFFFF",      // 主色上的文字
    onSecondary: "#1F1F1F",    // 副色上的文字
    onTertiary: "#1F1F1F",     // 第三色上的文字
    onBackground: "#1F1F1F",   // 背景上的文字
    onSurface: "#1F1F1F",      // 表面上的文字
  };
}

@Component
struct RetroMusicPlayerRoot {
  @State knobPosition: Point = new Point(140, 140);
  @State isDragging: boolean = false;

  build() {
    Column({ space: 0 }) {
      // ===== Top App Bar =====
      Stack() {
        Rect()
          .width("100%")
          .height(80)
          .fill(RM.C.background)

        Text("Retro Music Player")
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(RM.C.onSurface)
      }
      .width("100%")
      .height(80)

      Blank()

      // ===== Main Content =====
      Column({ space: 32 }) {
        // ===== Circular Deck =====
        Stack() {
          // Background surface with border
          Rect()
            .width(280)
            .height(280)
            .fill(RM.C.surface)
            .radius(16)
            .border({ width: 3, color: RM.C.outline })

          // Outer circle (record) - 黄色圆环
          Circle({ width: 240, height: 240 })
            .stroke(RM.C.secondary)
            .strokeWidth(8)

          // Draggable knob - 红色圆点
          Circle({ width: 24, height: 24 })
            .fill(RM.C.primary)
            .position({ x: this.knobPosition.x - 12, y: this.knobPosition.y - 12 })
            .gesture(
              PanGesture({ fingers: 1, direction: PanDirection.All })
                .onActionStart(() => {
                  this.isDragging = true;
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.isDragging = true;
                  // 限制红点在黄色圆环内移动
                  let centerX = 140;
                  let centerY = 140;
                  let radius = 120; // 圆环半径
                  let dx = event.offsetX - centerX;
                  let dy = event.offsetY - centerY;
                  let distance = Math.sqrt(dx * dx + dy * dy);
                  if (distance <= radius) {
                    this.knobPosition = new Point(event.offsetX, event.offsetY);
                  } else {
                    let angle = Math.atan2(dy, dx);
                    this.knobPosition = new Point(
                      centerX + Math.cos(angle) * radius,
                      centerY + Math.sin(angle) * radius
                    );
                  }
                })
                .onActionEnd(() => {
                  this.isDragging = false;
                })
            )
        }
        .width(280)
        .height(280)

        // ===== Track Info =====
        Text("Track: Summer Nights")
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM.C.onSurface)

        // ===== Control Buttons =====
        Row({ space: 32 }) {
          Button() {
            Text("Play")
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(RM.C.onPrimary)
              .width(140)
              .height(56)
          }
          .width(140)
          .height(56)
          .backgroundColor(RM.C.primary)
          .borderRadius(12)
          .onClick(() => {
            // Play action
          })

          Button() {
            Text("Pause")
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(RM.C.onSecondary)
              .width(140)
              .height(56)
          }
          .width(140)
          .height(56)
          .backgroundColor(RM.C.secondary)
          .borderRadius(12)
          .onClick(() => {
            // Pause action
          })
        }

        // ===== Knob Coordinates =====
        Text("Knob X:268 Y:303") // 固定显示原图坐标
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(RM.C.tertiary)
      }
      .padding({ left: 32, right: 32 })

      Blank()

      // ===== Bottom Spacer =====
      Rect()
        .width("100%")
        .height(60)
        .fill("#00000000")
    }
    .width("100%")
    .height("100%")
    .backgroundColor(RM.C.background)
    .onAppear(() => {
      // 初始化旋钮位置为中心，确保在圆环内
      this.knobPosition = new Point(140, 140);
    })
  }
}

@Entry
@Component
struct Index {
  build() {
    RetroMusicPlayerRoot()
  }
}
