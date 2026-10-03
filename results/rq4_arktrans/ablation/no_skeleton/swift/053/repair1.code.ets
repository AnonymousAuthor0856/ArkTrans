@Entry
@Component
struct RootScreen {
  @State markers: CodeMarker[] = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ]

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#1E293B' }
    // children: 2
    Column() {
      // === Text ===
      // props: { text: 'CodeIDE Terminal' }
      // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, fontColor: '#E2E8F0', padding: 12, textAlign: TextAlign.Center, width: '100%' }
      Text('CodeIDE Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#E2E8F0')
        .padding(12)
        .textAlign(TextAlign.Center)
        .width('100%')

      // === Scroll ===
      // props: {}
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 1
      Scroll() {
        // === Column ===
        // props: { space: 16 }
        // modifier: { width: '100%', padding: 16 }
        // children: 5
        Column({ space: 16 }) {
          // === Text ===
          // props: { text: 'Project Files' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#E2E8F0' }
          Text('Project Files')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          // === ForEach ===
          // props: { data: this.markers }
          // children: 1
          ForEach(this.markers, (item: CodeMarker) => {
            // === Row ===
            // props: { space: 12 }
            // modifier: { width: '100%', padding: 12, backgroundColor: '#334155', borderRadius: 8, shadow: { radius: 2, color: '#1A000000', offsetY: 1 } }
            // children: 2
            Row({ space: 12 }) {
              // === Stack ===
              // props: { alignContent: Alignment.Center }
              // modifier: { width: 32, height: 32, backgroundColor: '#0EA5E9', borderRadius: 4 }
              // children: 1
              Stack({ alignContent: Alignment.Center }) {
                // === Text ===
                // props: { text: item.id.toString() }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
                Text(item.id.toString())
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFF')
              }.width(32).height(32).backgroundColor('#0EA5E9').borderRadius(4)

              // === Column ===
              // props: { space: 4 }
              // modifier: { layoutWeight: 1 }
              // children: 2
              Column({ space: 4 }) {
                // === Text ===
                // props: { text: item.name }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#E2E8F0' }
                Text(item.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E2E8F0')

                // === Text ===
                // props: { text: item.desc }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#E2E8F0' }
                Text(item.desc)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor('#E2E8F0')
              }.layoutWeight(1)
            }.width('100%').padding(12).backgroundColor('#334155').borderRadius(8).shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
          })

          // === Text ===
          // props: { text: 'Live Terminal' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#E2E8F0' }
          Text('Live Terminal')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          // === Stack ===
          // props: { alignContent: Alignment.TopStart }
          // modifier: { width: '100%', height: 240, backgroundColor: '#334155', borderRadius: 8, borderColor: '#475569', borderWidth: 1 }
          // children: 1
          Stack({ alignContent: Alignment.TopStart }) {
            // === Text ===
            // props: { text: '> println("Hello, Kotlin!")' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#E2E8F0', padding: 12 }
            Text('> println("Hello, Kotlin!")')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor('#E2E8F0')
              .padding(12)
          }.width('100%').height(240).backgroundColor('#334155').borderRadius(8).border({ width: 1, color: '#475569' })

          // === Button ===
          // modifier: { width: '60%', height: 48, backgroundColor: '#0EA5E9', borderRadius: 12, shadow: { radius: 2, color: '#1A000000', offsetY: 1 }, margin: { bottom: 24 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Run Code' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
            Text('Run Code')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFF')
          }.width('60%').height(48).backgroundColor('#0EA5E9').borderRadius(12).shadow({ radius: 2, color: '#1A000000', offsetY: 1 }).margin({ bottom: 24 })
        }.width('100%').padding(16)
      }.width('100%').layoutWeight(1)
    }.width('100%').height('100%').backgroundColor('#1E293B')
  }
}

interface CodeMarker {
  id: number;
  name: string;
  desc: string;
}