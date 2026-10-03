@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0
  @State syncProgress: number = 0.3

  build() {
    Column() {
      // === Text (Subtitle Card) ===
      // props: { text: 'Sample Subtitle Line' }
      // modifier: { fontSize: this.fontSize, fontColor: '#1E1E1E', width: '100%', height: 200, backgroundColor: '#FFF', borderRadius: 22, shadow: { radius: 8, offsetY: 6, color: '#2D000000' }, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }
      Row() {
        Text('Sample Subtitle Line')
          .fontSize(this.fontSize)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(200)
      .backgroundColor('#FFF')
      .borderRadius(22)
      .shadow({ radius: 8, offsetY: 6, color: '#2D000000' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // === Text (Label) ===
      // props: { text: 'Font Size: 23sp' }
      // modifier: { fontSize: 14, fontColor: '#1E1E1E', margin: { top: 24 } }
      Text(`Font Size: ${Math.round(this.fontSize)}sp`)
        .fontSize(14)
        .fontColor('#1E1E1E')
        .margin({ top: 24 })

      // === Slider ===
      // props: { value: this.fontSize, min: 16, max: 48 }
      // modifier: { width: '100%' }
      Slider({ value: this.fontSize, min: 16, max: 48 })
        .width('100%')

      // === Text (Label) ===
      // props: { text: 'Sync Progress' }
      // modifier: { fontSize: 14, fontColor: '#1E1E1E', margin: { top: 24 } }
      Text('Sync Progress')
        .fontSize(14)
        .fontColor('#1E1E1E')
        .margin({ top: 24 })

      // === Progress ===
      // props: { value: this.syncProgress, total: 1.0, type: ProgressType.Linear }
      // modifier: { width: '100%', height: 6, color: '#FF8B5CF6', trackColor: '#F1E9FE' }
      Progress({ value: this.syncProgress, total: 1.0, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color('#FF8B5CF6')
        .backgroundColor('#F1E9FE')

      // === Row (Buttons) ===
      // props: { space: 12 }
      // modifier: { width: '100%', margin: { top: 24 } }
      // children: 2
      Row({ space: 12 }) {
        // === Button (Sync +) ===
        // modifier: { flex: 1, height: 48, backgroundColor: '#FF8B5CF6', borderRadius: 14, fontColor: '#FFF', fontSize: 18, fontWeight: FontWeight.Medium }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Sync +' }
          Text('Sync +')
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor('#FF8B5CF6')
        .borderRadius(14)
        .fontColor('#FFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0)
        })

        // === Button (Sync -) ===
        // modifier: { flex: 1, height: 48, backgroundColor: '#FFD946EF', borderRadius: 14, fontColor: '#FFF', fontSize: 18, fontWeight: FontWeight.Medium }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Sync -' }
          Text('Sync -')
        }
        .layoutWeight(1)
        .height(48)
        .backgroundColor('#FFD946EF')
        .borderRadius(14)
        .fontColor('#FFF')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0)
        })
      }
      .width('100%')
      .margin({ top: 24 })
    }
    // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#F9F5FF' }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#F9F5FF')
  }
}