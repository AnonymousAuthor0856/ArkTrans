@Entry
@Component
struct CourseDashboardScreen {
  @State ongoingProgress: number = 75

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Scrollable Content Column ===
      // props: {}
      // modifier: { width: '100%', height: '100%' }
      // children: 5
      Scroll() {
        Column() {
          // === Header Section ===
          Row() {
            Column() {
              Text('Hello, Sophie').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
              Text("Let's start learning!").fontSize(16).fontColor('#888888').margin({ top: 4 })
            }
            Blank()
            Row({ space: 8 }) {
              Image($r('app.media.startIcon')).width(24).height(24)
              Image($r('app.media.startIcon')).width(48).height(48).borderRadius(24).backgroundColor('#EADDFF')
            }
          }.width('100%').padding(24).alignItems(VerticalAlign.Center)

          // === Search Bar Section ===
          Row() {
            Image($r('app.media.startIcon')).width(24).height(24)
            Text('Search for course...').fontSize(16).fontColor('#CCCCCC').layoutWeight(1).margin({ left: 16 })
            Image($r('app.media.startIcon')).width(24).height(24)
          }.width('100%').height(56).padding({ left: 16, right: 16 }).backgroundColor('#FFF').borderRadius(16).margin({ left: 24, right: 24, top: 16 }).alignItems(VerticalAlign.Center)

          // === Ongoing Course Section ===
          Column() {
            Text('Ongoing Course').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
            Row() {
              Column() {
                Text('3D Modeling').fontSize(14).fontColor('#FFFFFF').opacity(0.7)
                Text('Blender Basic').fontSize(22).fontWeight(FontWeight.Bold).fontColor('#FFFFFF').margin({ top: 8 })
                Row({ space: 8 }) {
                  Text('75%').fontSize(12).fontColor('#FFFFFF')
                  Progress({ value: this.ongoingProgress, total: 100, type: ProgressType.Linear }).width('100%').height(6).color('#FFA726').trackColor('#FFFFFF').trackOpacity(0.2)
                }.margin({ top: 16 })
              }.layoutWeight(1)
              Image($r('app.media.startIcon')).width(60).height(60).borderRadius(30).backgroundColor('#FFFFFF')
            }.width('100%').height(140).backgroundColor('#4E31AA').borderRadius(24).margin({ top: 16 }).padding(20).alignItems(VerticalAlign.Center)
          }.width('100%').padding({ left: 24, right: 24, top: 24 })

          // === Categories Section ===
          List({ space: 12 }) {
            ListItem() {
              Button('Coding').backgroundColor('#FFF').fontColor('#888888').borderRadius(12).height(48).width('auto').padding({ left: 24, right: 24 })
            }
            ListItem() {
              Button('Design').backgroundColor('#FF7043').fontColor('#FFF').borderRadius(12).height(48).width('auto').padding({ left: 24, right: 24 })
            }
            ListItem() {
              Button('Business').backgroundColor('#FFF').fontColor('#888888').borderRadius(12).height(48).width('auto').padding({ left: 24, right: 24 })
            }
          }.width('100%').listDirection(Axis.Horizontal).margin({ top: 24, left: 24, right: 24 })

          // === Recommended Section ===
          Column() {
            Row() {
              Text('Recommended').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
              Blank()
              Text('See all').fontSize(16).fontColor('#888888')
            }.width('100%')

            // Course Card 1
            Row() {
              Column() {
                Image($r('app.media.startIcon')).width(32).height(32)
              }.width(100).height('100%').backgroundColor('#E3F2FD').justifyContent(FlexAlign.Center)
              Column() {
                Text('Android Compose').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#4E31AA')
                Text('Mobile Dev').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1C1B1F').margin({ top: 4 })
                Row({ space: 4 }) {
                  Image($r('app.media.startIcon')).width(16).height(16)
                  Text('4.9').fontSize(12).fontColor('#888888')
                }.margin({ top: 4 })
              }.layoutWeight(1).padding(16)
              Image($r('app.media.startIcon')).width(24).height(24)
            }.width('100%').height(100).backgroundColor('#FFF').borderRadius(20).margin({ top: 16 }).alignItems(VerticalAlign.Center)

            // Course Card 2
            Row() {
              Column() {
                Image($r('app.media.startIcon')).width(32).height(32)
              }.width(100).height('100%').backgroundColor('#FCE4EC').justifyContent(FlexAlign.Center)
              Column() {
                Text('Master Lighting').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#4E31AA')
                Text('Photography').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1C1B1F').margin({ top: 4 })
                Row({ space: 4 }) {
                  Image($r('app.media.startIcon')).width(16).height(16)
                  Text('4.7').fontSize(12).fontColor('#888888')
                }.margin({ top: 4 })
              }.layoutWeight(1).padding(16)
              Image($r('app.media.startIcon')).width(24).height(24)
            }.width('100%').height(100).backgroundColor('#FFF').borderRadius(20).margin({ top: 16 }).alignItems(VerticalAlign.Center)

            // Course Card 3
            Row() {
              Column() {
                Image($r('app.media.startIcon')).width(32).height(32)
              }.width(100).height('100%').backgroundColor('#E8F5E9').justifyContent(FlexAlign.Center)
              Column() {
                Text('Crypto Trading').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#4E31AA')
                Text('Finance').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1C1B1F').margin({ top: 4 })
                Row({ space: 4 }) {
                  Image($r('app.media.startIcon')).width(16).height(16)
                  Text('4.5').fontSize(12).fontColor('#888888')
                }.margin({ top: 4 })
              }.layoutWeight(1).padding(16)
              Image($r('app.media.startIcon')).width(24).height(24)
            }.width('100%').height(100).backgroundColor('#FFF').borderRadius(20).margin({ top: 16, bottom: 100 }).alignItems(VerticalAlign.Center)
          }.width('100%').padding({ left: 24, right: 24, top: 24 })
        }
      }

      // === Bottom Navigation Bar ===
      // props: {}
      // modifier: { width: '100%', padding: 24, margin: 24, backgroundColor: '#1E1E1E', borderRadius: 32, shadow: { radius: 8, color: '#000000' } }
      // children: 1
      Row() {
        Image($r('app.media.startIcon')).width(24).height(24)
        Blank()
        Image($r('app.media.startIcon')).width(24).height(24)
        Blank()
        Image($r('app.media.startIcon')).width(24).height(24)
        Blank()
        Image($r('app.media.startIcon')).width(24).height(24)
      }.width('100%').padding(24).margin(24).backgroundColor('#1E1E1E').borderRadius(32).shadow({ radius: 8, color: '#000000' })
    }.width('100%').height('100%').backgroundColor('#F5F5F7')
  }
}