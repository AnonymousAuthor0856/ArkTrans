@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Blank()
          Text('Title').fontColor('#E2E8F0').fontSize(32)
          Blank()
        }.backgroundColor('#1E293B').padding({ top: 16, bottom: 16 })

        Scroll() {
          Column() {
            Text('Project Files').fontColor('#E2E8F0').fontSize(20)

            // LazyVStack equivalent using List for performance and structure match
            List() {
              ForEach([
                { id: '1', name: 'File A', desc: 'Description A' },
                { id: '2', name: 'File B', desc: 'Description B' }
              ], (item: { id: string, name: string, desc: string }) => {
                ListItem() {
                  Row() {
                    Stack() {
                      Rect().width(32).height(32).borderRadius(4).fill('#0EA5E9')
                      Text(item.id).fontColor('#FFFFFF').fontSize(12)
                    }
                    Column() {
                      Text(item.name).fontColor('#E2E8F0').fontSize(16)
                      Text(item.desc).fontColor('#CBD5E1').fontSize(14)
                    }
                  }.width('100%').alignItems(HorizontalAlign.Start).justifyContent(FlexAlign.Start)
                    .backgroundColor('#334155').borderRadius(8).padding(12)
                    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
                }
              })
            }.width('100%').layoutWeight(1).divider(null)

            Text('Live Terminal').fontColor('#E2E8F0').fontSize(20)

            Stack() {
              Rect().width('100%').height(240).borderRadius(8).fill('#334155')
                .overlay(
                  Rect().width('100%').height(240).borderRadius(8).border({ width: 1, color: '#475569' })
                )
              Text('> println("Hello, Kotlin!")').fontColor('#E2E8F0').fontSize(14).padding(16)
            }

            Button() {
              Text('Action').fontColor('#FFFFFF')
            }.width('100%').height(48).backgroundColor('#0EA5E9').borderRadius(12)
              .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
          }.width('100%').padding(16).alignItems(HorizontalAlign.Start)
        }.backgroundColor('#1E293B')
      }.width('100%').height('100%').backgroundColor('#1E293B')
    }.width('100%').height('100%')
  }
}