@Entry
@Component
struct ChargingProgressApp {
  @State progress: number = 0.45

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column() {
        // Top Bar
        Row() {
          Image($r('app.media.startIcon')).width(24).height(24).fillColor(Color.Blue).margin({ left: 8 })
          Blank()
          Text('Charging Progress').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#111827')
          Blank()
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24).fillColor(Color.Orange)
          }.backgroundColor('Transparent')
        }.width('100%').padding({ left: 16, right: 16, top: 8, bottom: 8 }).backgroundColor('#FFF')

        // Content
        Column({ space: 14 }) {
          // Battery and Percentage
          Column({ space: 10 }) {
            // Custom Vertical Battery Icon
            Stack() {
              // Battery Body
              Column().width(50).height(90).borderRadius(8).backgroundColor('#3B82F6')
              // Battery Cap
              Column().width(20).height(10).borderRadius(3).backgroundColor('#3B82F6').position({ x: 15, y: -50 })
              // Lightning Bolt
              ShapeShape().width(25).height(40).fill(Color.White)
            }.width(60).height(100)

            // Percentage Text
            Text(`${Math.floor(this.progress * 100)}%`).fontSize(36).fontWeight(FontWeight.Bold).fontColor('#111827')
          }.padding({ top: 10 })

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Column().width('100%').height(12).borderRadius(6).backgroundColor('#FFF').border({ width: 1, color: '#D4D4D8' })
            // Indicator
            Column().width(`${this.progress * 100}%`).height(10).borderRadius(5).backgroundColor('#3B82F6')
          }.width('70%').padding({ top: 14 })

          // Simulate Button
          Button() {
            Text('Simulate Charge').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }.onClick(() => {
            this.progress += 0.1
            if (this.progress > 1.0) {
              this.progress = 0.0
            }
          }).backgroundColor('#22C55E').borderRadius(999).padding({ left: 24, right: 24, top: 12, bottom: 12 }).margin({ top: 14 })

          // Status Text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!').fontSize(18).fontWeight(FontWeight.SemiBold).fontColor(this.progress < 1.0 ? '#3B82F6' : '#22C55E').margin({ top: 10 })

          Blank()
        }.width('100%').layoutWeight(1).padding(14)
      }.width('100%').height('100%').backgroundColor('#F5F5F4')
    }.width('100%').height('100%')
  }
}

// Custom Shape for Lightning Bolt
class ShapeShape extends Shape {
  drawPath(ctx: CanvasRenderingContext2D, width: number, height: number): void {
    ctx.beginPath()
    const midX = width / 2
    const minY = 0
    const maxY = height
    const midY = height / 2

    ctx.moveTo(midX, minY + 5)
    ctx.lineTo(midX - 8, midY)
    ctx.lineTo(midX + 2, midY)
    ctx.lineTo(midX - 5, maxY - 5)
    ctx.lineTo(midX + 8, midY)
    ctx.lineTo(midX - 2, midY)
    ctx.closePath()
    ctx.fill()
  }
}