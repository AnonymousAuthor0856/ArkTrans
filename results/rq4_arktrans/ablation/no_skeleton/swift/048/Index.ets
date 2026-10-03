@Entry
@Component
struct RootScreen {
  @State liveList: LiveItem[] = [
    { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
    { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
    { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
    { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" }
  ]

  build() {
    // === Stack (ZStack) ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#F5F8FF' }
    // children: 3
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column (VStack - Content) ===
      // props: { space: 10, alignItems: ItemAlign.Start }
      // modifier: { width: '100%', height: '100%', padding: 16 }
      // children: 2
      Column({ space: 10, alignItems: ItemAlign.Start }) {
        // === Text ===
        // props: { text: 'Live Shop Events' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, color: '#1E3A8A' }
        Text('Live Shop Events').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#1E3A8A')

        // === List (ScrollView + LazyVStack) ===
        // props: { space: 10 }
        // modifier: { width: '100%', layoutWeight: 1, marginBottom: 96 }
        // children: 4
        List({ space: 10 }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              // === Column (Card Container) ===
              // props: { space: 6, alignItems: ItemAlign.Start }
              // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 16, shadow: { radius: 4, color: '#1F000000', offsetY: 2 } }
              // children: 4
              Column({ space: 6, alignItems: ItemAlign.Start }) {
                // === Image (Placeholder Rectangle) ===
                // modifier: { width: '100%', height: 160, backgroundColor: '#3B82F6', borderRadius: 10 }
                Image('').width('100%').height(160).backgroundColor('#3B82F6').borderRadius(10)

                // === Text (Title) ===
                // props: { text: item.title }
                // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#0B1220' }
                Text(item.title).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0B1220')

                // === Text (Viewers) ===
                // props: { text: `${item.viewers} viewers` }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#60A5FA' }
                Text(`${item.viewers} viewers`).fontSize(14).fontWeight(FontWeight.Normal).fontColor('#60A5FA')

                // === Row (Price & Button) ===
                // props: { space: 10, justifyContent: FlexSpace.SpaceBetween }
                // modifier: { width: '100%' }
                // children: 2
                Row({ space: 10, justifyContent: FlexSpace.SpaceBetween }) {
                  // === Text (Price) ===
                  // props: { text: item.price }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#1E3A8A' }
                  Text(item.price).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1E3A8A')

                  // === Button (Join Live) ===
                  // modifier: { backgroundColor: '#1E3A8A', borderRadius: 10, padding: { left: 16, right: 16, top: 8, bottom: 8 } }
                  // children: 1
                  Button() {
                    // === Text ===
                    // props: { text: 'Join Live' }
                    // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#FFF' }
                    Text('Join Live').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#FFF')
                  }.backgroundColor('#1E3A8A').borderRadius(10).padding({ left: 16, right: 16, top: 8, bottom: 8 })
                }.width('100%')
              }.width('100%').padding(16).backgroundColor('#FFF').borderRadius(16).shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
            }
          })
        }.width('100%').layoutWeight(1).margin({ bottom: 96 })
      }.width('100%').height('100%').padding(16)

      // === Stack (FAB Positioning) ===
      // props: { alignContent: Alignment.BottomEnd }
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Stack({ alignContent: Alignment.BottomEnd }) {
        // === Button (FAB) ===
        // modifier: { width: 56, height: 56, backgroundColor: '#3B82F6', borderRadius: 28, margin: { bottom: 96, right: 16 } }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: '+' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, color: '#FFF' }
          Text('+').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#FFF')
        }.width(56).height(56).backgroundColor('#3B82F6').borderRadius(28).margin({ bottom: 96, right: 16 })
      }.width('100%').height('100%')

      // === Stack (Bottom Bar Positioning) ===
      // props: { alignContent: Alignment.Bottom }
      // modifier: { width: '100%', height: '100%' }
      // children: 1
      Stack({ alignContent: Alignment.Bottom }) {
        // === Row (BottomNavBar) ===
        // props: { space: 0, justifyContent: FlexSpace.SpaceEvenly }
        // modifier: { width: '100%', height: 80, backgroundColor: '#FFF', shadow: { radius: 0.5, color: '#1A000000', offsetY: -1 } }
        // children: 4
        Row({ space: 0, justifyContent: FlexSpace.SpaceEvenly }) {
          // === Text ===
          // props: { text: 'Home' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#1E3A8A' }
          Text('Home').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#1E3A8A')
          
          // === Text ===
          // props: { text: 'Live' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#0B1220' }
          Text('Live').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#0B1220')
          
          // === Text ===
          // props: { text: 'Cart' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#0B1220' }
          Text('Cart').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#0B1220')
          
          // === Text ===
          // props: { text: 'Profile' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, color: '#0B1220' }
          Text('Profile').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#0B1220')
        }.width('100%').height(80).backgroundColor('#FFF').shadow({ radius: 0.5, color: '#1A000000', offsetY: -1 })
      }.width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#F5F8FF')
  }
}

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}