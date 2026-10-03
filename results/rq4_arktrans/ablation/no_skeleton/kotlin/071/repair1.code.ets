@Entry
@Component
struct QuizForge {
  @State selectedIndex: number = -1
  private readonly options: string[] = ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip']

  build() {
    // === Column (Root) ===
    // modifier: { width: '100%', height: '100%', padding: { left: 20, right: 20 }, backgroundColor: '#FFF9F2' }
    // children: 3
    Column() {
      // === Row (Header) ===
      // props: { space: 16 }
      // modifier: { width: '100%', height: 56, justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
      // children: 3
      Row() {
        // === Image (Left Icon Placeholder) ===
        // modifier: { width: 30, height: 30, borderRadius: 15, backgroundColor: '#FFE4CC' }
        Image($r('app.media.startIcon')).width(30).height(30).borderRadius(15).backgroundColor('#FFE4CC')

        // === Column (Center Text) ===
        // modifier: { alignItems: HorizontalAlign.Center }
        // children: 2
        Column() {
          // === Text ===
          // props: { text: 'QuizForge' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#311F10' }
          Text('QuizForge').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#311F10')
          
          // === Text ===
          // props: { text: 'Aroma sprint' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#311F10', opacity: 0.7 }
          Text('Aroma sprint').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#311F10').opacity(0.7)
        }

        // === Image (Right Icon Placeholder) ===
        // modifier: { width: 30, height: 30, borderRadius: 15, backgroundColor: '#FF8A2A', opacity: 0.35 }
        Image($r('app.media.startIcon')).width(30).height(30).borderRadius(15).backgroundColor('#FF8A2A').opacity(0.35)
      }.width('100%').height(56).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

      // === Blank ===
      // modifier: { height: 16 }
      Blank().height(16)

      // === Column (Question Card) ===
      // modifier: { width: '100%', padding: 16, backgroundColor: '#FFFFFF', borderRadius: 28, shadow: { radius: 8, offsetY: 4, color: '#38000000' } }
      // children: 5
      Column() {
        // === Row (Category & Progress %) ===
        // props: { space: 16 }
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
        // children: 2
        Row() {
          // === Text ===
          // props: { text: 'Citrus crafts' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#311F10' }
          Text('Citrus crafts').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#311F10')
          
          // === Text ===
          // props: { text: '45%' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#FFC857' }
          Text('45%').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#FFC857')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

        // === Blank ===
        // modifier: { height: 12 }
        Blank().height(12)

        // === Progress ===
        // props: { value: 45, total: 100, type: ProgressType.Linear }
        // modifier: { width: '100%', height: 4, color: '#FF8A2A', trackColor: '#E2B088', opacity: 0.2 }
        Progress({ value: 45, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(4)
          .color('#FF8A2A')
          .trackBackground('#E2B088')
          .opacity(0.2)

        // === Blank ===
        // modifier: { height: 12 }
        Blank().height(12)

        // === Text (Prompt) ===
        // props: { text: 'Which zest carrier gives the brightest aroma when infused cold?' }
        // modifier: { fontSize: 22, fontWeight: FontWeight.SemiBold, lineHeight: 28, color: '#311F10' }
        Text('Which zest carrier gives the brightest aroma when infused cold?')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .lineHeight(28)
          .fontColor('#311F10')

        // === Blank ===
        // modifier: { height: 12 }
        Blank().height(12)

        // === Column (Options) ===
        // props: { space: 8 }
        // modifier: { width: '100%' }
        // children: 4
        Column({ space: 8 }) {
          ForEach(this.options, (option: string, index: number) => {
            // === Column (Option Chip) ===
            // modifier: { 
            //   width: '100%', 
            //   padding: 12, 
            //   borderRadius: 18, 
            //   border: { width: 1, color: this.selectedIndex === index ? '#FF8A2A' : '#E2B088' },
            //   backgroundColor: this.selectedIndex === index ? '#FF8A2A' : '#FFE4CC',
            //   opacity: this.selectedIndex === index ? 1 : 1 
            // }
            // Note: ArkTS doesn't support dynamic colors in modifiers easily without state binding per item or complex logic.
            // We will use a simple conditional style approach.
            Column() {
              // === Text ===
              // props: { text: option }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#311F10' }
              Text(option).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#311F10')
            }
            .width('100%')
            .padding(12)
            .borderRadius(18)
            .border({ width: 1, color: this.selectedIndex === index ? '#FF8A2A' : '#E2B088' })
            .backgroundColor(this.selectedIndex === index ? '#FF8A2A' : '#FFE4CC')
            .onClick(() => {
              this.selectedIndex = index
            })
          })
        }.width('100%')

        // === Blank ===
        // modifier: { height: 12 }
        Blank().height(12)

        // === Column (Hint) ===
        // modifier: { width: 'auto', padding: { left: 12, right: 12, top: 4, bottom: 4 }, backgroundColor: '#FFC857', opacity: 0.2, borderRadius: 10 }
        // children: 1
        Column() {
          // === Text ===
          // props: { text: 'Hint: Think surface area' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#311F10' }
          Text('Hint: Think surface area').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#311F10')
        }
        .width('auto')
        .padding({ left: 12, right: 12, top: 4, bottom: 4 })
        .backgroundColor('#FFC857')
        .opacity(0.2)
        .borderRadius(10)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(28)
      .shadow({ radius: 8, offsetY: 4, color: '#38000000' })

      // === Blank ===
      // modifier: { height: 16 }
      Blank().height(16)

      // === Column (Trackers) ===
      // modifier: { width: '100%', padding: 16, backgroundColor: '#FFFFFF', borderRadius: 28, shadow: { radius: 4, offsetY: 2, color: '#2E000000' } }
      // children: 3
      Column() {
        // === Text (Title) ===
        // props: { text: 'Trackers' }
        // modifier: { fontSize: 22, fontWeight: FontWeight.SemiBold, lineHeight: 28, color: '#311F10' }
        Text('Trackers').fontSize(22).fontWeight(FontWeight.Bold).lineHeight(28).fontColor('#311F10')

        // === Blank ===
        // modifier: { height: 8 }
        Blank().height(8)

        // === Row (Stats) ===
        // props: { space: 12 }
        // modifier: { width: '100%' }
        // children: 3
        Row({ space: 12 }) {
          // === Column (Stat 1) ===
          // modifier: { layoutWeight: 1, padding: 12, backgroundColor: '#FFE4CC', borderRadius: 18, alignItems: HorizontalAlign.Center }
          // children: 2
          Column() {
            // === Text ===
            // props: { text: 'Current streak' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#311F10', opacity: 0.7 }
            Text('Current streak').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#311F10').opacity(0.7)
            
            // === Text ===
            // props: { text: '5 days' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#311F10' }
            Text('5 days').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#311F10')
          }
          .layoutWeight(1)
          .padding(12)
          .backgroundColor('#FFE4CC')
          .borderRadius(18)
          .alignItems(HorizontalAlign.Center)

          // === Column (Stat 2) ===
          // modifier: { layoutWeight: 1, padding: 12, backgroundColor: '#FFE4CC', borderRadius: 18, alignItems: HorizontalAlign.Center }
          // children: 2
          Column() {
            // === Text ===
            // props: { text: 'Accuracy' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#311F10', opacity: 0.7 }
            Text('Accuracy').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#311F10').opacity(0.7)
            
            // === Text ===
            // props: { text: '84%' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#311F10' }
            Text('84%').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#311F10')
          }
          .layoutWeight(1)
          .padding(12)
          .backgroundColor('#FFE4CC')
          .borderRadius(18)
          .alignItems(HorizontalAlign.Center)

          // === Column (Stat 3) ===
          // modifier: { layoutWeight: 1, padding: 12, backgroundColor: '#FFE4CC', borderRadius: 18, alignItems: HorizontalAlign.Center }
          // children: 2
          Column() {
            // === Text ===
            // props: { text: 'Rank' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#311F10', opacity: 0.7 }
            Text('Rank').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#311F10').opacity(0.7)
            
            // === Text ===
            // props: { text: 'Top 12%' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#311F10' }
            Text('Top 12%').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#311F10')
          }
          .layoutWeight(1)
          .padding(12)
          .backgroundColor('#FFE4CC')
          .borderRadius(18)
          .alignItems(HorizontalAlign.Center)
        }.width('100%')

        // === Blank ===
        // modifier: { height: 16 }
        Blank().height(16)

        // === Button ===
        // modifier: { width: '100%', height: 44, backgroundColor: '#FF8A2A', borderRadius: 18 }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Submit answer' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#2C0D00' }
          Text('Submit answer').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2C0D00')
        }
        .width('100%')
        .height(44)
        .backgroundColor('#FF8A2A')
        .borderRadius(18)
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(28)
      .shadow({ radius: 4, offsetY: 2, color: '#2E000000' })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 20, right: 20 })
    .backgroundColor('#FFF9F2')
  }
}