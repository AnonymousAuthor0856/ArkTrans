interface Marker {
  id: number;
  name: string;
  desc: string;
}

@Entry
@Component
struct CodeIDE {
  @State markers: Array<Marker> = [
    { id: 1, name: 'Main.kt', desc: 'Entry point for Compose app' },
    { id: 2, name: 'Utils.kt', desc: 'Helper functions' },
    { id: 3, name: 'Theme.kt', desc: 'Color & Typography setup' },
    { id: 4, name: 'Data.kt', desc: 'Repository and model classes' }
  ]

  build() {
    // === Column (Root) ===
    // props: { space: 16 }
    // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#1E293B' }
    // children: 5
    Column({ space: 16 }) {
      // === Text (Title) ===
      // props: { text: 'CodeIDE Terminal' }
      // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, color: '#E2E8F0' }
      Text('CodeIDE Terminal').fontSize(26).fontWeight(FontWeight.Bold).fontColor('#E2E8F0')

      // === Text (Section Header) ===
      // props: { text: 'Project Files' }
      // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#E2E8F0' }
      Text('Project Files').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#E2E8F0')

      // === List (Files) ===
      // props: { space: 8 }
      // modifier: { width: '100%' }
      // children: 4
      List({ space: 8 }) {
        ForEach(this.markers, (item: Marker) => {
          ListItem() {
            // === Row (Card Content) ===
            // props: { space: 12 }
            // modifier: { width: '100%', padding: 12, backgroundColor: '#334155', borderRadius: 8 }
            // children: 2
            Row({ space: 12 }) {
              // === Column (Icon Box) ===
              // modifier: { width: 32, height: 32, backgroundColor: '#0EA5E9', borderRadius: 4, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }
              // children: 1
              Column() {
                // === Text (ID) ===
                // props: { text: item.id.toString() }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
                Text(item.id.toString()).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }.width(32).height(32).backgroundColor('#0EA5E9').borderRadius(4).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

              // === Column (Text Info) ===
              // props: { space: 4 }
              // modifier: { layoutWeight: 1 }
              // children: 2
              Column({ space: 4 }) {
                // === Text (Name) ===
                // props: { text: item.name }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#E2E8F0' }
                Text(item.name).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#E2E8F0')
                
                // === Text (Desc) ===
                // props: { text: item.desc }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#E2E8F0' }
                Text(item.desc).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#E2E8F0')
              }.layoutWeight(1)
            }.width('100%').padding(12).backgroundColor('#334155').borderRadius(8)
          }
        }, (item: Marker) => JSON.stringify(item))
      }.width('100%')

      // === Text (Terminal Header) ===
      // props: { text: 'Live Terminal' }
      // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#E2E8F0' }
      Text('Live Terminal').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#E2E8F0')

      // === Column (Terminal Box) ===
      // modifier: { width: '100%', height: 240, backgroundColor: '#334155', borderRadius: 8, borderColor: '#475569', borderWidth: 1, padding: 12 }
      // children: 1
      Column() {
        // === Text (Terminal Output) ===
        // props: { text: '> println("Hello, Kotlin!")' }
        // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#E2E8F0' }
        Text('> println("Hello, Kotlin!")').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#E2E8F0')
      }.width('100%').height(240).backgroundColor('#334155').borderRadius(8).border({ width: 1, color: '#475569' }).padding(12)
    }.width('100%').height('100%').padding(16).backgroundColor('#1E293B')
  }
}