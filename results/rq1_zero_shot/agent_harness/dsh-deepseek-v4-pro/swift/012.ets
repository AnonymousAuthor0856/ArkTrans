// Translated from SwiftUI to ArkTS (ArkUI declarative syntax)

class Point {
  x: number;
  y: number;
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

@Component
struct ContentView {
  // 小蓝点实际位置在中心靠左，但坐标显示仍为(200, 400)
  @State markerPosition: Point = new Point(120, 200);
  @State displayedCoordinates: string = "(200, 400)";

  build() {
    Column({ space: 0 }) {
      // Top App Bar - 减少标题下方的空白
      Column() {
        Text("Favorite Spots Map")
          .fontSize(28)
          .fontWeight(FontWeight.Semibold)
          .fontColor("#111827")
      }
      .width("100%")
      .padding({ top: 10, bottom: 10 })
      .backgroundColor("#F9FAFB")

      // 主要内容区域
      Stack() {
        // 背景渐变
        Stack() {
        }
        .width("100%")
        .height("100%")
        .linearGradient({
          angle: 135,
          colors: [["#FFFFFF99", 0.0], ["#EFF6FF80", 0.5], ["#FFFFFFB3", 1.0]]
        })

        Column({ space: 0 }) {
          Blank()

          // 地图容器
          Stack() {
            // 径向渐变背景
            Stack() {
            }
            .width("100%")
            .height(400)
            .radialGradient({
              center: [0.5, 0.5],
              radius: 120,
              colors: [["#FFFFFFCC", 0.0], ["#EFF6FF99", 1.0]]
            })
            .borderRadius(24)

            // 边框
            Stack() {
            }
            .width("100%")
            .height(400)
            .borderRadius(24)
            .border({ width: 1, color: "#D1D5DB" })

            // 外圈 (radius = 180)
            Circle({ width: 360, height: 360 }).fill("#93C5FD33")

            // 内圈 (radius = 120)
            Circle({ width: 240, height: 240 }).fill("#93C5FD4D")

            // 标记点外圈 (radius = 12)
            Circle({ width: 24, height: 24 })
              .fill("#60A5FA4D")
              .position({ x: this.markerPosition.x, y: this.markerPosition.y })

            // 标记点实心圆 (radius = 4)
            Circle({ width: 8, height: 8 })
              .fill("#60A5FA")
              .position({ x: this.markerPosition.x, y: this.markerPosition.y })
          }
          .height(400)
          .padding({ left: 16, right: 16 })

          // 底部控制区域 - 直接放在地图框下方
          Column({ space: 16 }) {
            Text("Spot Coordinates: " + this.displayedCoordinates)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor("#111827")

            Button() {
              Text("Save Marker")
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor("#FFFFFF")
                .width("100%")
                .height(48)
                .backgroundColor("#60A5FA")
                .borderRadius(16)
            }
            .width("100%")
            .height(48)
            .onClick(() => {
              // 保存标记点操作
            })

            // 已保存的标记列表
            Column({ space: 12 }) {
              Text("Saved Markers")
                .fontSize(18)
                .fontWeight(FontWeight.Semibold)
                .fontColor("#111827")

              Column({ space: 8 }) {
                Row() {
                  Circle({ width: 8, height: 8 }).fill("#60A5FA")
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor("#111827")
                  Blank()
                }
                .width("100%")

                Row() {
                  Circle({ width: 8, height: 8 }).fill("#60A5FA")
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor("#111827")
                  Blank()
                }
                .width("100%")
              }
              .width("100%")
            }
            .width("100%")
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .width("100%")
          .padding({ left: 16, right: 16 })
          .padding({ top: 0 })
          .padding({ bottom: 24 })
        }
      }
      .width("100%")
      .layoutWeight(1)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#F9FAFB")
  }
}

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}
