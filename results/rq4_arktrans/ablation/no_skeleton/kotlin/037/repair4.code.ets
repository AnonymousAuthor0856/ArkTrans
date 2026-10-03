import { DashArray } from '@kit.ArkGraphics'

@Entry
@Component
struct BudgetPieChart {
  @State v: number = 0

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // children: 3
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 16 }
      // modifier: { width: '100%', height: '100%', padding: { left: 24, right: 24 }, backgroundColor: '#F7FAFC' }
      // children: 2
      Column({ space: 16 }) {
        // === Text ===
        // props: { text: 'Monthly Budget' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.SemiBold, color: '#4A5568', textAlign: TextAlign.Center, margin: { top: 40, bottom: 16 } }
        Text('Monthly Budget')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#4A5568')
          .textAlign(TextAlign.Center)
          .margin({ top: 40, bottom: 16 })

        // === Custom Component (PieChart) ===
        PieChartComponent()

        // === List ===
        // props: { space: 16 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 5
        List({ space: 16 }) {
          ListItem() {
            // === Row ===
            // props: { space: 16 }
            // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, shadow: { radius: 3, color: '#0D000000', offsetY: 1 } }
            // children: 2
            Row({ space: 16 }) {
              // === Circle ===
              // modifier: { width: 20, height: 20, backgroundColor: '#63B3ED' }
              Circle().width(20).height(20).backgroundColor('#63B3ED')
              
              // === Text ===
              // props: { text: 'Housing' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Normal, color: '#1A202C', layoutWeight: 1 }
              Text('Housing').fontSize(16).fontWeight(FontWeight.Normal).fontColor('#1A202C').layoutWeight(1)
              
              // === Text ===
              // props: { text: '$1,250.00' }
              // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1A202C' }
              Text('$1,250.00').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1A202C')
            }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
          }
          ListItem() {
            Row({ space: 16 }) {
              Circle().width(20).height(20).backgroundColor('#4FD1C5')
              Text('Food').fontSize(16).fontWeight(FontWeight.Normal).fontColor('#1A202C').layoutWeight(1)
              Text('$480.50').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1A202C')
            }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
          }
          ListItem() {
            Row({ space: 16 }) {
              Circle().width(20).height(20).backgroundColor('#667EEA')
              Text('Transport').fontSize(16).fontWeight(FontWeight.Normal).fontColor('#1A202C').layoutWeight(1)
              Text('$210.75').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1A202C')
            }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
          }
          ListItem() {
            Row({ space: 16 }) {
              Circle().width(20).height(20).backgroundColor('#ED64A6')
              Text('Entertainment').fontSize(16).fontWeight(FontWeight.Normal).fontColor('#1A202C').layoutWeight(1)
              Text('$150.00').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1A202C')
            }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
          }
          ListItem() {
            Row({ space: 16 }) {
              Circle().width(20).height(20).backgroundColor('#F6AD55')
              Text('Utilities').fontSize(16).fontWeight(FontWeight.Normal).fontColor('#1A202C').layoutWeight(1)
              Text('$320.00').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1A202C')
            }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
          }
        }.width('100%').layoutWeight(1)
        
        // === Blank ===
        Blank()
      }.width('100%').height('100%').padding({ left: 24, right: 24 }).backgroundColor('#F7FAFC')

      // === Button (FAB) ===
      // modifier: { width: 56, height: 56, backgroundColor: '#4A5568', fontColor: '#FFF', borderRadius: 28, shadow: { radius: 15, color: '#1A000000', offsetY: 5 }, margin: { bottom: 90, right: 24 } }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: '+' }
        // modifier: { fontSize: 32, fontWeight: FontWeight.Bold, color: '#FFF' }
        Text('+').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#FFF')
      }
      .width(56).height(56).backgroundColor('#4A5568').fontColor('#FFF').borderRadius(28).shadow({ radius: 15, color: '#1A000000', offsetY: 5 }).margin({ bottom: 90, right: 24 })
      .position({ x: 'auto', y: 'auto' }) // Position handled by Stack alignment if needed, but here explicit margin is used in skeleton style
      
      // === Bottom Bar ===
      // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', position: { bottom: 0 } }
      // children: 1
      Column() {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center, padding: { top: 16, bottom: 16 } }
        // children: 4
        Row() {
          // === Column (Home) ===
          // modifier: { width: 60, alignItems: ItemAlign.Center }
          // children: 2
          Column() {
            // === Circle ===
            // modifier: { width: 24, height: 24, backgroundColor: '#E2E8F0' }
            Circle().width(24).height(24).backgroundColor('#E2E8F0')
            // === Text ===
            // props: { text: 'Home' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#4A5568', marginTop: 4 }
            Text('Home').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#4A5568').margin({ top: 4 })
          }.width(60).alignItems(HorizontalAlign.Center)

          // === Column (Reports) ===
          Column() {
            Circle().width(24).height(24).backgroundColor('#CBD5E0')
            Text('Reports').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#A0AEC0').margin({ top: 4 })
          }.width(60).alignItems(HorizontalAlign.Center)

          // === Spacer ===
          // modifier: { width: 48 }
          Blank().width(48)

          // === Column (Goals) ===
          Column() {
            Circle().width(24).height(24).backgroundColor('#CBD5E0')
            Text('Goals').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#A0AEC0').margin({ top: 4 })
          }.width(60).alignItems(HorizontalAlign.Center)

          // === Column (Settings) ===
          Column() {
            Circle().width(24).height(24).backgroundColor('#CBD5E0')
            Text('Settings').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#A0AEC0').margin({ top: 4 })
          }.width(60).alignItems(HorizontalAlign.Center)
        }.width('100%').justifyContent(FlexAlign.SpaceAround).alignItems(VerticalAlign.Center).padding({ top: 16, bottom: 16 })
      }.width('100%').height(80).backgroundColor('#FFF').position({ bottom: 0 })
    }.width('100%').height('100%')
  }
}

// Helper component for the Pie Chart visualization
@Component
struct PieChartComponent {
  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Center }
    // modifier: { width: 240, height: 240 }
    // children: 2
    Stack({ alignContent: Alignment.Center }) {
      // === Canvas (Simulated with Image/Shape for simplicity in ArkTS without complex drawing API calls in this specific format, or using a placeholder image if allowed. Since only $r('app.media.startIcon') is allowed, we use a Shape/Circle combination to mimic the ring) ===
      // Note: True Canvas drawing requires more verbose ArkTS code. Here we approximate the visual result using a large circle with a border gradient effect if possible, or just a placeholder structure. 
      // To strictly follow "Implement every child", I will use a Circle with a stroke to represent the chart visually as best as possible within standard components.
      
      // Outer Ring (Approximation of the pie chart)
      Circle()
        .width(240)
        .height(240)
        .fill(Color.Transparent)
        .strokeWidth(20)
        .stroke(new DashArray([100, 10]).color('#63B3ED')) // Simplified representation
        
      // Inner Content
      Column() {
        // === Text ===
        // props: { text: 'Total Spent' }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#718096' }
        Text('Total Spent').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#718096')
        
        // === Text ===
        // props: { text: '$2,411.25' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.SemiBold, color: '#4A5568', marginTop: 4 }
        Text('$2,411.25').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#4A5568').margin({ top: 4 })
      }
    }.width(240).height(240)
  }
}