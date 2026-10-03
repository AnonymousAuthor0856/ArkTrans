@Entry
@Component
struct ForumPost {
  @State voteState: number = 1

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column (Main Content) ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column() {
        // === Row (Header) ===
        // props: { space: 16 }
        // modifier: { width: '100%', height: 56, padding: 16, backgroundColor: '#1C1C3A' }
        // children: 2
        Row() {
          // === Image (Back Icon) ===
          // modifier: { width: 24, height: 24 }
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#00E5FF')

          // === Text (Title) ===
          // props: { text: 'r/jetpackcompose' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#E0E0FF', textAlign: TextAlign.Center, layoutWeight: 1 }
          Text('r/jetpackcompose')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E0E0FF')
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }.width('100%').height(56).padding(16).backgroundColor('#1C1C3A')

        // === List (Scrollable Content) ===
        // props: { space: 0 }
        // modifier: { width: '100%', layoutWeight: 1, backgroundColor: '#101024' }
        // children: 3
        List() {
          ListItem() {
            // === Post Card ===
            // modifier: { width: '100%', backgroundColor: '#1C1C3A', padding: 16 }
            // children: 1
            Row() {
              // === Column (Vote Controls) ===
              // props: { space: 8, horizontalAlignment: HorizontalAlign.Center }
              // modifier: { width: 48 }
              // children: 3
              Column({ space: 8 })
                .alignItems(HorizontalAlign.Center) {
                // === Up Vote Button ===
                // modifier: { width: 24, height: 24 }
                // children: 1
                Stack() {
                  // Simulated Diamond Shape using Polygon or Image placeholder if needed, 
                  // but standard ArkTS doesn't have easy polygon. Using a rotated square for visual approximation or simple image.
                  // Since we must use $r('app.media.startIcon'), let's assume it can be styled or just use a generic shape logic.
                  // To strictly follow "Implement every child", I will use a Stack with a rotated rectangle to mimic the diamond.
                  Rect()
                    .width(16)
                    .height(16)
                    .fill(this.voteState === 1 ? '#FF00AA' : '#44446A')
                    .borderRadius(2)
                    .rotate({ angle: 45 })
                }.onClick(() => { this.voteState = this.voteState === 1 ? 0 : 1 }).width(24).height(24)

                // === Vote Count Text ===
                // props: { text: '1337' }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Bold, color: '#FF00AA' }
                Text((1337 + this.voteState - 1).toString())
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.voteState !== 0 ? '#FF00AA' : '#E0E0FF')

                // === Down Vote Button ===
                // modifier: { width: 24, height: 24 }
                Stack() {
                  Rect()
                    .width(16)
                    .height(16)
                    .fill(this.voteState === -1 ? '#00E5FF' : '#44446A')
                    .borderRadius(2)
                    .rotate({ angle: 45 })
                }.onClick(() => { this.voteState = this.voteState === -1 ? 0 : -1 }).width(24).height(24)
              }.width(48)

              // === Column (Post Content) ===
              // props: { space: 8 }
              // modifier: { layoutWeight: 1 }
              // children: 4
              Column({ space: 8 }) {
                // === Author Info Row ===
                // props: { space: 8, verticalAlignment: VerticalAlign.Center }
                // children: 3
                Row({ space: 8 })
                  .alignItems(VerticalAlign.Center) {
                  // Avatar
                  Stack() {
                    Circle().width(24).height(24).fill('#76FF03')
                    Circle().width(8).height(8).fill('#000000').opacity(0.2)
                  }
                  // Name
                  Text('user/compose_master').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#76FF03')
                  // Time
                  Text('8 hours ago').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#44446A')
                }

                // === Title ===
                // props: { text: 'The power of Jetpack Compose for single-file UIs' }
                // modifier: { fontSize: 22, fontWeight: FontWeight.SemiBold, color: '#E0E0FF' }
                Text('The power of Jetpack Compose for single-file UIs')
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#E0E0FF')

                // === Body ===
                // props: { text: 'Creating fully functional...' }
                // modifier: { fontSize: 16, lineHeight: 24, color: '#BDBDE0' }
                Text('Creating fully functional, beautiful UIs in a single Kotlin file is not just possible, it\'s becoming a new standard for prototypes and minimalist apps. What are your thoughts on this approach?')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#BDBDE0')

                // === Action Chips Row ===
                // props: { space: 24 }
                // children: 2
                Row({ space: 24 }) {
                  Text('42 Comments').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#44446A')
                  Text('Share').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#44446A')
                }
              }.layoutWeight(1)
            }.width('100%').backgroundColor('#1C1C3A').padding(16)
          }

          ListItem() {
            // === Section Header ===
            // props: { text: 'TOP COMMENTS' }
            // modifier: { width: '100%', padding: 16, fontSize: 14, fontWeight: FontWeight.Medium, color: '#44446A' }
            Text('TOP COMMENTS')
              .width('100%')
              .padding(16)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#44446A')
          }

          ListItem() {
            // === Reply Card ===
            // modifier: { width: '100%', padding: 16 }
            // children: 1
            Row() {
              // === Left Border Line ===
              // modifier: { width: 2, height: '100%', backgroundColor: '#FF00AA', opacity: 0.5, borderRadius: 2 }
              Rect()
                .width(2)
                .height('100%')
                .fill('#FF00AA')
                .opacity(0.5)
                .borderRadius(2)
              
              // === Reply Content ===
              // props: { space: 4 }
              // modifier: { layoutWeight: 1, padding: { left: 12 } }
              // children: 3
              Column({ space: 4 }) {
                // === Author Info Row ===
                // props: { space: 8, verticalAlignment: VerticalAlign.Center }
                // children: 3
                Row({ space: 8 })
                  .alignItems(VerticalAlign.Center) {
                  // Avatar
                  Stack() {
                    Circle().width(24).height(24).fill('#FF00AA')
                    Circle().width(8).height(8).fill('#000000').opacity(0.2)
                  }
                  // Name
                  Text('dev/android_fan').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FF00AA')
                  // Time
                  Text('7h ago').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#44446A')
                }

                // === Reply Text ===
                // props: { text: 'Absolutely agree!...' }
                // modifier: { fontSize: 16, lineHeight: 24, color: '#D9D9F2' }
                Text('Absolutely agree! It simplifies dependency management and makes sharing snippets a breeze.')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#D9D9F2')

                // === Action Chips Row ===
                // props: { space: 12 }
                // children: 2
                Row({ space: 12 }) {
                  Text('25 votes').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#44446A')
                  Text('Reply').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#44446A')
                }
              }.layoutWeight(1).padding({ left: 12 })
            }.width('100%').padding(16)
          }
        }.width('100%').layoutWeight(1).backgroundColor('#101024')
      }.width('100%').height('100%')

      // === Bottom Bar ===
      // modifier: { width: '100%', height: 80, backgroundColor: '#1C1C3A', padding: 16, position: { bottom: 0, left: 0, right: 0 } }
      // children: 1
      Row({ space: 12 })
        .alignItems(VerticalAlign.Center) {
        // === Input Field Placeholder ===
        // modifier: { width: '100%', height: 48, backgroundColor: '#282850', borderRadius: 16, padding: 16 }
        // children: 1
        TextInput({ placeholder: 'Add a comment...' })
          .width('100%')
          .height(48)
          .backgroundColor('#282850')
          .borderRadius(16)
          .padding(16)
          .fontColor('#44446A')
          .placeholderColor('#44446A')
          .type(InputType.Normal)
          .layoutWeight(1)

        // === Post Button ===
        // modifier: { height: 48, backgroundColor: '#00E5FF', borderRadius: 16, padding: { left: 24, right: 24 } }
        // children: 1
        Button('POST')
          .height(48)
          .backgroundColor('#00E5FF')
          .borderRadius(16)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
          .padding({ left: 24, right: 24 })
      }.width('100%').height(80).backgroundColor('#1C1C3A').padding(16).position({ bottom: 0, left: 0, right: 0 })
    }.width('100%').height('100%')
  }
}