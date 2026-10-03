import { canvas } from '@kit.ArkGraphics'

@Entry
@Component
struct Index {
  @State paymentProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Surface Card with Graph
        Column() {
          CustomCanvas().width('100%').height('100%')
        }
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })
        .width('100%')
        .height(240)

        // Text Label
        Text('Payment Progress')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFA500')

        // Linear Progress Indicator
        Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FFA500')
          .backgroundColor('#FFEED6')
          .borderRadius(4)

        // Slider
        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .selectedColor('#FFA500')
          .trackColor('#FFEED6')
          .blockColor('#FFA500')
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        // Reset Button
        Button() {
          Text('Reset Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
        }
        .width('100%')
        .height(48)
        .backgroundColor('#FCE38A')
        .borderRadius(16)
        .onClick(() => {
          this.paymentProgress = 0
        })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FFF7D6', 0], ['#FFFBF2', 0.5], ['#FFF7D6', 1]]
      })

      // Top App Bar (Absolute Positioned)
      Row() {
        Text('Installment Plan')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}

// Custom Component for the Graph Visualization
@Component
struct CustomCanvas {
  private context: canvas.CanvasRenderingContext2D | null = null

  aboutToAppear() {
    // This is a placeholder logic to simulate the graph drawing
    // In a real scenario, you would use the canvas context provided by ArkTS
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady((context: canvas.CanvasRenderingContext2D) => {
        this.context = context
        // Drawing logic would go here
      })
  }
}