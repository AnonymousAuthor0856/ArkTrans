@Entry
@Component
struct CryptoMarketApp {
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%', backgroundColor: '#FFFDF5' }
      // children: 2
      Column({ space: 0 }) {
        // === Text ===
        // props: { text: 'Crypto Market' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#1E1E1E', padding: { top: 16, bottom: 16 }, width: '100%', textAlign: TextAlign.Center }
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .padding({ top: 16, bottom: 16 })
          .width('100%')
          .textAlign(TextAlign.Center)

        // === Column ===
        // props: { space: 16 }
        // modifier: { width: '100%', layoutWeight: 1, padding: 16, background: LinearGradient(...) }
        // children: 4
        Column({ space: 16 }) {
          // === Row ===
          // props: { space: 12 }
          // modifier: { width: '100%', justifyContent: FlexAlign.Start }
          // children: 4
          Row({ space: 12 }) {
            // === Button (Filter Chip) ===
            // modifier: { type: ButtonType.Normal, stateEffect: false, borderRadius: 6, margin: 0, padding: { left: 12, right: 12, top: 8, bottom: 8 }, backgroundColor: '#FFA8A8' }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'BTC' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
              Text('BTC').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')
            }
            .type(ButtonType.Normal)
            .stateEffect(false)
            .borderRadius(6)
            .margin(0)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.selectedChip === 'BTC' ? '#FFA8A8' : '#F7F7F7')
            .onClick(() => { this.selectedChip = 'BTC' })

            // === Button (Filter Chip) ===
            // modifier: { type: ButtonType.Normal, stateEffect: false, borderRadius: 6, margin: 0, padding: { left: 12, right: 12, top: 8, bottom: 8 }, backgroundColor: '#F7F7F7' }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'ETH' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
              Text('ETH').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')
            }
            .type(ButtonType.Normal)
            .stateEffect(false)
            .borderRadius(6)
            .margin(0)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.selectedChip === 'ETH' ? '#FFA8A8' : '#F7F7F7')
            .onClick(() => { this.selectedChip = 'ETH' })

            // === Button (Filter Chip) ===
            // modifier: { type: ButtonType.Normal, stateEffect: false, borderRadius: 6, margin: 0, padding: { left: 12, right: 12, top: 8, bottom: 8 }, backgroundColor: '#F7F7F7' }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'SOL' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
              Text('SOL').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')
            }
            .type(ButtonType.Normal)
            .stateEffect(false)
            .borderRadius(6)
            .margin(0)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.selectedChip === 'SOL' ? '#FFA8A8' : '#F7F7F7')
            .onClick(() => { this.selectedChip = 'SOL' })

            // === Button (Filter Chip) ===
            // modifier: { type: ButtonType.Normal, stateEffect: false, borderRadius: 6, margin: 0, padding: { left: 12, right: 12, top: 8, bottom: 8 }, backgroundColor: '#F7F7F7' }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'ADA' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#1E1E1E' }
              Text('ADA').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#1E1E1E')
            }
            .type(ButtonType.Normal)
            .stateEffect(false)
            .borderRadius(6)
            .margin(0)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .backgroundColor(this.selectedChip === 'ADA' ? '#FFA8A8' : '#F7F7F7')
            .onClick(() => { this.selectedChip = 'ADA' })
          }.width('100%').justifyContent(FlexAlign.Start)

          // === Column ===
          // props: { space: 16 }
          // modifier: { width: '100%' }
          // children: 3
          Column({ space: 16 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: '100%', height: 260, borderRadius: 20, shadow: { radius: 8, color: '#2D000000', offsetY: 4 }, backgroundColor: '#FFF' }
            // children: 1
            Stack({ alignContent: Alignment.Center }) {
              // === Custom Component (Chart) ===
              ChartView({ progress: this.progress })
            }.width('100%').height(260).borderRadius(20).shadow({ radius: 8, color: '#2D000000', offsetY: 4 }).backgroundColor('#FFF')

            // === Text ===
            // props: { text: 'Price Variation' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#FFA8A8', textAlign: TextAlign.Center, width: '100%' }
            Text('Price Variation')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFA8A8')
              .textAlign(TextAlign.Center)
              .width('100%')

            // === Progress ===
            // props: { value: this.progress, total: 1, type: ProgressType.Linear }
            // modifier: { width: '100%', height: 8, color: '#FFA8A8', trackColor: '#F7F7F7', controlHeight: 8 }
            Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color('#FFA8A8')
              .trackColor('#F7F7F7')
              .controlHeight(8)
          }.width('100%')

          // === Row ===
          // props: { space: 12 }
          // modifier: { width: '100%', alignItems: ItemAlign.Center }
          // children: 2
          Row({ space: 12 }) {
            // === Text ===
            // props: { text: 'Auto Update' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#1E1E1E' }
            Text('Auto Update').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#1E1E1E')

            // === Blank ===
            Blank()

            // === Toggle ===
            // props: { isOn: this.isAutoUpdate }
            // modifier: { width: 51, height: 31 }
            Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
              .width(51)
              .height(31)
              .onChange((isOn: boolean) => {
                this.isAutoUpdate = isOn
              })
              .selectedColor('#FFE1A8')
              .trackNormalColor('#E2E2E2')
              .trackSelectedColor('#FFA8A8')
          }.width('100%').alignItems(ItemAlign.Center)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .background(LinearGradient({
          angle: 90,
          colors: [['#FFE1A8', 0.3], ['#FFFDF5', 0.5], ['#A8FFE1', 0.3]]
        }))
      }.width('100%').height('100%').backgroundColor('#FFFDF5')
    }.width('100%').height('100%')
  }
}

// === Custom Component Definition ===
@Component
struct ChartView {
  private progress: number = 0

  build() {
    // === Canvas ===
    // props: { drawEvent: (canvas: CanvasRenderingContext2D, rect: Rect) => void }
    // modifier: { width: '100%', height: '100%' }
    Canvas({
      drawImage: (context: CanvasRenderingContext2D, canvas: CanvasRenderingContext2D) => {
        const w = canvas.width
        const h = canvas.height
        const step = w / 30
        const initialPrevY = h / 2

        context.beginPath()
        context.moveTo(-step, initialPrevY)

        for (let i = 0; i <= 30; i++) {
          const x = i * step
          const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
          context.lineTo(x, y)
        }

        context.lineWidth = 5
        context.strokeStyle = '#FFA8A8'
        context.stroke()
      }
    }).width('100%').height('100%')
  }
}