// 小蓝点实际位置在中心靠左，但坐标显示仍为(200, 400)

// 颜色扩展 (对应 Swift extension Color { init(hex: UInt) })
function toHex2(v: number): string {
  const digits = '0123456789ABCDEF'
  return digits.charAt((v >> 4) & 0xF) + digits.charAt(v & 0xF)
}

// 根据 RGB hex (忽略高 8 位 alpha) 与透明度生成 ArkUI 颜色字符串 (#AARRGGBB)
function colorHex(hex: number, alpha: number = 1): string {
  return '#'
    + toHex2(Math.round(alpha * 255))
    + toHex2((hex >> 16) & 0xFF)
    + toHex2((hex >> 8) & 0xFF)
    + toHex2(hex & 0xFF)
}

@Entry
@Component
struct ContentView {
  @State markerPositionX: number = 120
  @State markerPositionY: number = 200
  @State displayedCoordinates: string = '(200, 400)'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column({ space: 0 }) {
      // Top App Bar - 减少标题下方的空白
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorHex(0xFF111827))
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 }) // 减少标题栏的垂直内边距
      .backgroundColor(colorHex(0xFFF9FAFB))

      // 主要内容区域
      Stack() {
        // 背景渐变
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 135,
            colors: [
              [colorHex(0xFFFFFF, 0.6), 0.0],
              [colorHex(0xEFF6FF, 0.5), 0.5],
              [colorHex(0xFFFFFF, 0.7), 1.0]
            ]
          })

        Column({ space: 0 }) {
          Blank()
            .layoutWeight(1)

          // 地图容器 (带水平外边距)
          Column() {
            Stack() {
              // 径向渐变背景
              Column()
                .width('100%')
                .height('100%')
                .radialGradient({
                  center: ['50%', '50%'],
                  radius: 120,
                  colors: [
                    [colorHex(0xFFFFFF, 0.8), 0.0],
                    [colorHex(0xEFF6FF, 0.6), 1.0]
                  ]
                })

              // 绘制圆圈和标记
              Canvas(this.context)
                .width('100%')
                .height('100%')
                .onReady(() => {
                  const w = this.context.width
                  const h = this.context.height
                  const centerX = w / 2
                  const centerY = h / 2

                  // 内圈 (radius = 120)
                  this.context.beginPath()
                  this.context.arc(centerX, centerY, 120, 0, 2 * Math.PI, false)
                  this.context.fillStyle = colorHex(0x93C5FD, 0.3)
                  this.context.fill()

                  // 外圈 (radius = 180)
                  this.context.beginPath()
                  this.context.arc(centerX, centerY, 180, 0, 2 * Math.PI, false)
                  this.context.fillStyle = colorHex(0x93C5FD, 0.2)
                  this.context.fill()

                  // 标记点实心圆 (radius = 4) - 进一步减小半径
                  this.context.beginPath()
                  this.context.arc(this.markerPositionX, this.markerPositionY, 4, 0, 2 * Math.PI, false)
                  this.context.fillStyle = colorHex(0x60A5FA)
                  this.context.fill()

                  // 标记点外圈 (radius = 12, stroke width = 1) - 进一步减小半径和线宽
                  this.context.beginPath()
                  this.context.arc(this.markerPositionX, this.markerPositionY, 12, 0, 2 * Math.PI, false)
                  this.context.strokeStyle = colorHex(0x60A5FA, 0.3)
                  this.context.lineWidth = 1
                  this.context.stroke()
                })
            }
            .height(400)
            .width('100%')
            .borderRadius(24)
            .border({ width: 1, color: colorHex(0xFFD1D5DB) })
            .clip(true)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          // 底部控制区域 - 直接放在地图框下方，没有上方空白
          Column({ space: 16 }) {
            Text('Spot Coordinates: ' + this.displayedCoordinates)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorHex(0xFF111827))

            Button('Save Marker', { type: ButtonType.Normal })
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .width('100%')
              .height(48)
              .backgroundColor(colorHex(0xFF60A5FA))
              .borderRadius(16)
              .onClick(() => {
                // 保存标记点操作
              })

            // 添加已保存的标记列表
            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(colorHex(0xFF111827))

              Column({ space: 8 }) {
                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill(colorHex(0xFF60A5FA))
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(colorHex(0xFF111827))
                  Blank()
                }
                .width('100%')

                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill(colorHex(0xFF60A5FA))
                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(colorHex(0xFF111827))
                  Blank()
                }
                .width('100%')
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .padding({ left: 16, right: 16 })
          .padding({ top: 0 }) // 确保没有上方空白
          .padding({ bottom: 24 })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorHex(0xFFF9FAFB))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    // statusBar(hidden: true) — ArkUI 无直接对应属性，由系统状态栏控制
  }
}
