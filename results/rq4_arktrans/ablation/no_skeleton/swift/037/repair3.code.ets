import { canvas } from '@kit.ArkGraphics'

interface BudgetItem {
  name: string
  value: number
  colorStart: string
  colorEnd: string
}

@Entry
@Component
struct BudgetPieApp {
  @State v: number = 0

  private budgetData: BudgetItem[] = [
    { name: "Housing", value: 1250.00, colorStart: '#63B3ED', colorEnd: '#4299E1' },
    { name: "Food", value: 480.50, colorStart: '#4FD1C5', colorEnd: '#38B2AC' },
    { name: "Transport", value: 210.75, colorStart: '#667EEA', colorEnd: '#5A67D8' },
    { name: "Entertainment", value: 150.00, colorStart: '#ED64A6', colorEnd: '#D53F8C' },
    { name: "Utilities", value: 320.00, colorStart: '#F6AD55', colorEnd: '#ED8936' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', backgroundColor: '#F7FAFC' }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'Monthly Budget' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Semibold, fontColor: '#4A5568', padding: { top: 16, bottom: 16 } }
        Text('Monthly Budget')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A5568')
          .padding({ top: 16, bottom: 16 })

        // === List ===
        // props: { space: 16 }
        // modifier: { width: '100%', layoutWeight: 1, padding: { left: 24, right: 24 } }
        // children: 6
        List({ space: 16 }) {
          ListItem() {
            // === PieChart ===
            // props: { items: this.budgetData, strokeWidth: 20 }
            // modifier: { width: 240, height: 240, padding: { top: 24, bottom: 24 } }
            PieChart({ items: this.budgetData, strokeWidth: 20 })
              .width(240)
              .height(240)
              .padding({ top: 24, bottom: 24 })
          }

          ForEach(this.budgetData, (item: BudgetItem) => {
            ListItem() {
              // === CardView ===
              // props: { item: item }
              // modifier: { width: '100%' }
              CardView({ item: item }).width('100%')
            }
          })

          ListItem() {
            // === Blank ===
            // modifier: { height: 128 }
            Blank().height(128)
          }
        }.width('100%').layoutWeight(1).padding({ left: 24, right: 24 })
      }.width('100%').backgroundColor('#F7FAFC')

      // === BottomBar ===
      // props: {}
      // modifier: { width: '100%' }
      BottomBar()
    }.width('100%').height('100%')
  }
}

// Components

@Component
struct PieChart {
  @Prop items: BudgetItem[]
  @Prop strokeWidth: number

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Center }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Center }) {
      // === Canvas ===
      // props: { drawTask: this.drawSlices }
      // modifier: { width: '100%', height: '100%' }
      Canvas({ syncCanvasResource: this.drawSlices.bind(this) }).width('100%').height('100%')

      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', alignItems: ItemAlign.Center }
      // children: 2
      Column() {
        // === Text ===
        // props: { text: 'Total Spent' }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#718096' }
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#718096')

        // === Text ===
        // props: { text: '$2,411.25' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Semibold, fontColor: '#4A5568' }
        Text('$2,411.25')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#4A5568')
      }.width('100%').alignItems(HorizontalAlign.Center)
    }.width('100%').height('100%')
  }

  private drawSlices(context: canvas.CanvasRenderingContext2D, size: canvas.Size): void {
    const totalValue = this.items.reduce((sum, item) => sum + item.value, 0)
    let currentAngle = -Math.PI / 2
    const centerX = size.width / 2
    const centerY = size.height / 2
    const radius = Math.min(size.width, size.height) / 2 - this.strokeWidth / 2

    for (const item of this.items) {
      const sweep = (item.value / totalValue) * 2 * Math.PI
      
      context.beginPath()
      context.arc(centerX, centerY, radius, currentAngle, currentAngle + sweep)
      
      // Create gradient
      const gradient = context.createLinearGradient(centerX, centerY - radius, centerX, centerY + radius)
      gradient.addColorStop(0, item.colorStart)
      gradient.addColorStop(1, item.colorEnd)
      
      context.strokeStyle = gradient
      context.lineWidth = this.strokeWidth
      context.lineCap = 'butt'
      context.stroke()
      
      currentAngle += sweep
    }
  }
}

@Component
struct CardView {
  @Prop item: BudgetItem

  build() {
    // === Row ===
    // props: { space: 16 }
    // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, shadow: { radius: 3, color: '#0D000000', offsetY: 1 } }
    // children: 3
    Row() {
      // === Circle ===
      // modifier: { width: 20, height: 20, backgroundColor: this.item.colorStart }
      Circle()
        .width(20)
        .height(20)
        .backgroundColor(this.item.colorStart)

      // === Text ===
      // props: { text: this.item.name }
      // modifier: { fontSize: 16, fontWeight: FontWeight.Regular, fontColor: '#1A202C' }
      Text(this.item.name)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor('#1A202C')

      // === Blank ===
      Blank()

      // === Text ===
      // props: { text: formatCurrency(this.item.value) }
      // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#1A202C' }
      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A202C')
    }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
  }
}

@Component
struct BottomBar {
  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: 80, padding: { left: 24, right: 24 }, backgroundColor: '#FFF', shadow: { radius: 15, color: '#1A000000', offsetY: -5 } }
      // children: 4
      Row() {
        // === BottomBarItem ===
        // props: { text: 'Home', active: true }
        // modifier: { layoutWeight: 1 }
        BottomBarItem({ text: 'Home', active: true }).layoutWeight(1)

        // === BottomBarItem ===
        // props: { text: 'Reports', active: false }
        // modifier: { layoutWeight: 1 }
        BottomBarItem({ text: 'Reports', active: false }).layoutWeight(1)

        // === Blank ===
        // modifier: { width: 56 }
        Blank().width(56)

        // === BottomBarItem ===
        // props: { text: 'Goals', active: false }
        // modifier: { layoutWeight: 1 }
        BottomBarItem({ text: 'Goals', active: false }).layoutWeight(1)

        // === BottomBarItem ===
        // props: { text: 'Settings', active: false }
        // modifier: { layoutWeight: 1 }
        BottomBarItem({ text: 'Settings', active: false }).layoutWeight(1)
      }.width('100%').height(80).padding({ left: 24, right: 24 }).backgroundColor('#FFF').shadow({ radius: 15, color: '#1A000000', offsetY: -5 })

      // === Button ===
      // modifier: { width: 56, height: 56, backgroundColor: '#4A5568', borderRadius: 28, shadow: { radius: 4, color: '#1A000000', offsetY: 4 }, margin: { top: -28 } }
      // children: 1
      Button() {
        // === Image ===
        // modifier: { width: 24, height: 24, fill: '#FFF' }
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Fill)
      }.width(56).height(56).backgroundColor('#4A5568').borderRadius(28).shadow({ radius: 4, color: '#1A000000', offsetY: 4 }).margin({ top: -28 })
    }.width('100%')
  }
}

@Component
struct BottomBarItem {
  @Prop text: string
  @Prop active: boolean

  build() {
    // === Column ===
    // props: { space: 4 }
    // modifier: { width: '100%', alignItems: ItemAlign.Center }
    // children: 2
    Column() {
      // === Circle ===
      // modifier: { width: 24, height: 24, backgroundColor: this.active ? '#4A5568' : '#A0AEC0', opacity: 0.2 }
      Circle()
        .width(24)
        .height(24)
        .backgroundColor(this.active ? '#4A5568' : '#A0AEC0')
        .opacity(0.2)

      // === Text ===
      // props: { text: this.text }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: this.active ? '#4A5568' : '#A0AEC0' }
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? '#4A5568' : '#A0AEC0')
    }.width('100%').alignItems(HorizontalAlign.Center)
  }
}

function formatCurrency(value: number): string {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(value)
}