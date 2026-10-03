// Translated from Kotlin (Jetpack Compose) to ArkTS (ArkUI)
// File ID: 026 — Glassmorphic "Glass Doc Reader" page

@Entry
@Component
struct DocReaderPage {
  @State scrollY: number = 0;
  private lines: string[] = [];

  aboutToAppear(): void {
    for (let i = 0; i < 8; i++) {
      this.lines.push('This is a sample line of text content number ' + (i + 1) + '.');
    }
  }

  build() {
    Column() {
      // Center-aligned top app bar
      Row() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')

      // Content area with a vertical gradient (glassmorphic) background
      Stack() {
        Column({ space: 12 }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')

          ForEach(this.lines, (line: string) => {
            Text(line)
              .fontSize(14)
              .fontColor('#1E1E1E')
          }, (line: string, index: number) => index.toString())
        }
        .width('90%')
        .height(400)
        .padding(16)
        .backgroundColor('#B3FFFFFF')
        .borderRadius(20)
        .offset({ y: this.scrollY / 5 })
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
        .align(Alignment.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [['#CCE2E8F0', 0.0], ['#F1F5F9', 0.5], ['#CCE2E8F0', 1.0]]
      })
      .gesture(
        PanGesture()
          .onActionUpdate((event: GestureEvent) => {
            this.scrollY += event.offsetY;
          })
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
