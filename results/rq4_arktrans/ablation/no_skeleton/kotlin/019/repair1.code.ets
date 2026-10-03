@Entry
@Component
struct SubtitleEditor {
  @State fontSize: number = 24
  @State syncProgress: number = 0.3

  build() {
    Column() {
      // Top Bar
      Text('Subtitle Editor')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 40, bottom: 16 })

      // Main Content Area
      Column() {
        // === Surface Card ===
        // props: {}
        // modifier: { width: '100%', height: 200, backgroundColor: '#FFF', borderRadius: 22, shadow: { radius: 12, color: '#2D000000' } }
        // children: 1
        Column() {
          // === Text ===
          // props: { text: 'Sample Subtitle Line' }
          // modifier: { fontSize: this.fontSize, fontColor: '#1E1E1E', textAlign: TextAlign.Center }
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor('#1E1E1E')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFF')
        .borderRadius(22)
        .shadow({ radius: 12, color: '#2D000000' })

        // === Text ===
        // props: { text: 'Font Size: ${this.fontSize}sp' }
        // modifier: { fontSize: 14, fontColor: '#1E1E1E', margin: { top: 16, bottom: 8 }, textAlign: TextAlign.Center }
        Text(`Font Size: ${this.fontSize}sp`)
          .fontSize(14)
          .fontColor('#1E1E1E')
          .margin({ top: 16, bottom: 8 })
          .textAlign(TextAlign.Center)

        // === Slider ===
        // props: { value: this.fontSize, min: 16, max: 48 }
        // modifier: { width: '100%' }
        Slider({ value: this.fontSize, min: 16, max: 48 })
          .width('100%')
          .trackColor('#F1E9FE')
          .selectedColor('#D946EF')

        // === Text ===
        // props: { text: 'Sync Progress' }
        // modifier: { fontSize: 14, fontColor: '#1E1E1E', margin: { top: 16, bottom: 8 }, textAlign: TextAlign.Center }
        Text('Sync Progress')
          .fontSize(14)
          .fontColor('#1E1E1E')
          .margin({ top: 16, bottom: 8 })
          .textAlign(TextAlign.Center)

        // === Progress ===
        // props: { value: this.syncProgress, total: 1, type: ProgressType.Linear }
        // modifier: { width: '100%', height: 6, color: '#8B5CF6' }
        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#8B5CF6')
          .backgroundColor('#F1E9FE')

        // === Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', margin: { top: 16 } }
        // children: 2
        Row({ space: 12 }) {
          // === Button ===
          // modifier: { layoutWeight: 1, height: 48, backgroundColor: '#8B5CF6', fontColor: '#FFF', borderRadius: 14 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Sync +' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
            Text('Sync +').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#8B5CF6')
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1)
          })

          // === Button ===
          // modifier: { layoutWeight: 1, height: 48, backgroundColor: '#D946EF', fontColor: '#FFF', borderRadius: 14 }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Sync -' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
            Text('Sync -').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#D946EF')
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0)
          })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9F5FF')
  }
}