@Entry
@Component
struct RootScreen {
  @State progress: number = 0.4

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column() {
        // === Row ===
        // props: { space: 0, alignItems: ItemAlign.Center }
        // modifier: { width: '100%', height: 56, justifyContent: FlexAlign.Center, backgroundColor: '#FFFBF2' }
        // children: 1
        Row() {
          // === Text ===
          // props: { text: 'Transfer Wizard' }
          // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#1E1E1E' }
          Text('Transfer Wizard').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#1E1E1E')
        }.width('100%').height(56).justifyContent(FlexAlign.Center).backgroundColor('#FFFBF2')

        // === Stack ===
        // props: { alignContent: Alignment.Bottom }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 3
        Stack({ alignContent: Alignment.Bottom }) {
          // === Canvas ===
          // props: { onDraw: this.onDrawCanvas }
          // modifier: { width: '100%', height: '100%', padding: 24 }
          Canvas(this.ctx).width('100%').height('100%').padding(24)

          // === Column ===
          // props: { space: 16, horizontalAlignment: HorizontalAlign.Center }
          // modifier: { width: '100%', paddingBottom: 32 }
          // children: 3
          Column({ space: 16, horizontalAlignment: HorizontalAlign.Center }) {
            // === Text ===
            // props: { text: 'Transfer Progress' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1E1E1E' }
            Text('Transfer Progress').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')

            // === RelativeContainer ===
            // props: {}
            // modifier: { width: '80%', height: 8 }
            // children: 2
            RelativeContainer() {
              // === Rect ===
              // props: { id: 'track', constraints: { left: { anchor: '__container__', align: VerticalAlign.Top }, right: { anchor: '__container__', align: VerticalAlign.Top }, top: { anchor: '__container__', align: HorizontalAlign.Start }, bottom: { anchor: '__container__', align: HorizontalAlign.End } } }
              // modifier: { borderRadius: 4, backgroundColor: '#FFEED6' }
              Rect({ id: 'track', constraints: { left: { anchor: '__container__', align: VerticalAlign.Top }, right: { anchor: '__container__', align: VerticalAlign.Top }, top: { anchor: '__container__', align: HorizontalAlign.Start }, bottom: { anchor: '__container__', align: HorizontalAlign.End } } }).borderRadius(4).backgroundColor('#FFEED6')

              // === Rect ===
              // props: { id: 'progress', constraints: { left: { anchor: '__container__', align: VerticalAlign.Top }, right: { anchor: '__container__', align: VerticalAlign.Top, offset: { x: -this.progress * 100 + '%' } }, top: { anchor: '__container__', align: HorizontalAlign.Start }, bottom: { anchor: '__container__', align: HorizontalAlign.End } } }
              // modifier: { borderRadius: 4, backgroundColor: '#FFA500' }
              Rect({ id: 'progress', constraints: { left: { anchor: '__container__', align: VerticalAlign.Top }, right: { anchor: '__container__', align: VerticalAlign.Top, offset: { x: -(this.progress * 100) + '%' } }, top: { anchor: '__container__', align: HorizontalAlign.Start }, bottom: { anchor: '__container__', align: HorizontalAlign.End } } }).borderRadius(4).backgroundColor('#FFA500')
            }.width('80%').height(8)

            // === Row ===
            // props: { space: 12, verticalAlignment: VerticalAlign.Center }
            // modifier: { width: 'auto' }
            // children: 2
            Row({ space: 12, verticalAlignment: VerticalAlign.Center }) {
              // === Button ===
              // props: {}
              // modifier: { width: 64, height: 64, backgroundColor: '#FFA500', borderRadius: 32 }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: '+' }
                // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#FFFFFF' }
                Text('+').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
              }.width(64).height(64).backgroundColor('#FFA500').borderRadius(32).onClick(() => {
                if (this.progress < 1) {
                  this.progress += 0.1
                }
              })

              // === Button ===
              // props: {}
              // modifier: { width: 64, height: 64, backgroundColor: '#FFC300', borderRadius: 32 }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: '-' }
                // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, color: '#1E1E1E' }
                Text('-').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1E1E1E')
              }.width(64).height(64).backgroundColor('#FFC300').borderRadius(32).onClick(() => {
                if (this.progress > 0) {
                  this.progress -= 0.1
                }
              })
            }
          }.width('100%').padding({ bottom: 32 })
        }.width('100%').layoutWeight(1)
      }.width('100%').height('100%')

      // === LinearGradient ===
      // props: { colors: [ { color: '#FFC300', position: 0 }, { color: '#FFFBF2', position: 0.5 }, { color: '#FFA500', position: 1 } ], direction: GradientDirection.TOP_BOTTOM }
      // modifier: { width: '100%', height: '100%', opacity: 0.2 }
      LinearGradient({ colors: [{ color: '#FFC300', position: 0 }, { color: '#FFFBF2', position: 0.5 }, { color: '#FFA500', position: 1 }], direction: GradientDirection.TOP_BOTTOM }).width('100%').height('100%').opacity(0.2)
    }.width('100%').height('100%')
  }

  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private onDrawCanvas(context: CanvasRenderingContext2D, canvas: Canvas) {
    const size = canvas.getSize()
    const centerX = size.width / 2
    const centerY = size.height / 2

    // Draw large background circle
    context.beginPath()
    context.arc(centerX, centerY, 260, 0, Math.PI * 2)
    context.fillStyle = '#FFEED6'
    context.fill()

    // Draw marker circle
    // Mapping SwiftUI CGPoint(x: 200, y: 400) relative to center for visual consistency
    // In the screenshot, the marker is slightly below and right of center
    const markerX = centerX + 40
    const markerY = centerY + 60
    
    context.beginPath()
    context.arc(markerX, markerY, 20, 0, Math.PI * 2)
    context.fillStyle = '#FFA500'
    context.fill()
  }
}