@Entry
@Component
struct QuizForgeApp {
  build() {
    // === ZStack ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Color (Background) ===
      // modifier: { width: '100%', height: '100%', backgroundColor: '#FFFCF9' }
      Column() {
        Blank()
      }.width('100%').height('100%').backgroundColor('#FFFCF9')

      // === Column (Main Content) ===
      // props: { space: 0 }
      // modifier: { width: '100%', layoutWeight: 1, padding: { top: 10, bottom: 10 } }
      // children: 2
      Column() {
        // === HeaderView ===
        // children: 3
        Row() {
          // === Circle (Left) ===
          // modifier: { width: 48, height: 48, backgroundColor: '#FCE4D1' }
          Circle().width(48).height(48).backgroundColor('#FCE4D1')

          // === Spacer ===
          Blank()

          // === Column (Center Text) ===
          // props: { space: 2 }
          // children: 2
          Column({ space: 2 }) {
            // === Text ===
            // props: { text: 'QuizForge' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, fontColor: '#000000' }
            Text('QuizForge').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000')
            
            // === Text ===
            // props: { text: 'Aroma sprint' }
            // modifier: { fontSize: 14, fontWeight: FontWeight.Normal, fontColor: '#6E6661' }
            Text('Aroma sprint').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#6E6661')
          }

          // === Spacer ===
          Blank()

          // === Circle (Right) ===
          // modifier: { width: 48, height: 48, backgroundColor: '#FCE4D1' }
          Circle().width(48).height(48).backgroundColor('#FCE4D1')
        }.padding({ left: 24, right: 24 })

        // === ScrollView ===
        // props: { barState: BarState.Off }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column (Scroll Content) ===
          // props: { space: 30 }
          // modifier: { width: '100%', padding: { left: 16, right: 16, bottom: 40 } }
          // children: 2
          Column({ space: 30 }) {
            // === Quiz Card Section ===
            // props: { space: 0 }
            // modifier: { width: '100%', backgroundColor: '#FFF3E8', borderRadius: 36 }
            // children: 5
            Column() {
              // === Row (Header) ===
              // props: { space: 0 }
              // modifier: { width: '100%', padding: { left: 24, right: 24, top: 24 } }
              // children: 3
              Row() {
                // === Text ===
                // props: { text: 'Citrus crafts' }
                // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, fontColor: '#291E17' }
                Text('Citrus crafts').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#291E17')
                
                // === Blank ===
                Blank()
                
                // === Text ===
                // props: { text: '45%' }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Bold, fontColor: '#FCD462' }
                Text('45%').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FCD462')
              }.width('100%').padding({ left: 24, right: 24, top: 24 })

              // === Progress Bar ===
              // props: { space: 4 }
              // modifier: { width: '100%', padding: { left: 24, right: 24, top: 10, bottom: 12 } }
              // children: 2
              Row({ space: 4 }) {
                // === Capsule (Orange) ===
                // modifier: { width: 100, height: 5, backgroundColor: '#FF9642' }
                Capsule().width(100).height(5).backgroundColor('#FF9642')
                
                // === Capsule (Track) ===
                // modifier: { layoutWeight: 1, height: 5, backgroundColor: '#EBE6F5' }
                // children: 1
                Capsule() {
                  // === Stack (Dot Overlay) ===
                  // props: { alignContent: Alignment.End }
                  // children: 1
                  Stack({ alignContent: Alignment.End }) {
                    // === Circle (Dot) ===
                    // modifier: { width: 4, height: 4, backgroundColor: '#FF9642', margin: { right: -2 } }
                    Circle().width(4).height(4).backgroundColor('#FF9642').margin({ right: -2 })
                  }
                }.layoutWeight(1).height(5).backgroundColor('#EBE6F5')
              }.width('100%').padding({ left: 24, right: 24, top: 10, bottom: 12 })

              // === Question Text ===
              // props: { text: 'Which zest carrier gives the brightest aroma when infused cold?' }
              // modifier: { width: '100%', fontSize: 23, fontWeight: FontWeight.Bold, fontColor: '#291E17', lineHeight: 31, padding: { left: 24, right: 24, bottom: 24 } }
              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .fontColor('#291E17')
                .lineHeight(31)
                .width('100%')
                .padding({ left: 24, right: 24, bottom: 24 })

              // === Options List ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: { left: 24, right: 24, bottom: 24 } }
              // children: 4
              Column({ space: 12 }) {
                // === OptionButton ===
                // children: 1
                Row() {
                  // === Text ===
                  // props: { text: 'Dried peel sachet' }
                  // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#291E17' }
                  Text('Dried peel sachet').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#291E17')
                  Blank()
                }.width('100%').padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFE4CC').borderRadius(16).border({ width: 1, color: '#DFAA80', radius: 16 })

                // === OptionButton ===
                // children: 1
                Row() {
                  // === Text ===
                  // props: { text: 'Twist garnish' }
                  // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#291E17' }
                  Text('Twist garnish').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#291E17')
                  Blank()
                }.width('100%').padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFE4CC').borderRadius(16).border({ width: 1, color: '#DFAA80', radius: 16 })

                // === OptionButton ===
                // children: 1
                Row() {
                  // === Text ===
                  // props: { text: 'Zester microplane' }
                  // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#291E17' }
                  Text('Zester microplane').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#291E17')
                  Blank()
                }.width('100%').padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFE4CC').borderRadius(16).border({ width: 1, color: '#DFAA80', radius: 16 })

                // === OptionButton ===
                // children: 1
                Row() {
                  // === Text ===
                  // props: { text: 'Candied strip' }
                  // modifier: { fontSize: 10, fontWeight: FontWeight.Medium, fontColor: '#291E17' }
                  Text('Candied strip').fontSize(10).fontWeight(FontWeight.Medium).fontColor('#291E17')
                  Blank()
                }.width('100%').padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFE4CC').borderRadius(16).border({ width: 1, color: '#DFAA80', radius: 16 })
              }.width('100%').padding({ left: 24, right: 24, bottom: 24 })

              // === Hint Tag ===
              // props: { text: 'Hint: Think surface area' }
              // modifier: { width: 'auto', fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#291E17', padding: { top: 10, bottom: 10, left: 16, right: 16 }, backgroundColor: '#FCECCF', borderRadius: 12, margin: { left: 24, right: 24, bottom: 24 } }
              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#291E17')
                .padding({ top: 10, bottom: 10, left: 16, right: 16 })
                .backgroundColor('#FCECCF')
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
            }.width('100%').backgroundColor('#FFF3E8').borderRadius(36)

            // === Trackers Section ===
            // props: { space: 16 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 16 }) {
              // === Text ===
              // props: { text: 'Trackers' }
              // modifier: { fontSize: 24, fontWeight: FontWeight.Bold, fontColor: '#291E17', margin: { left: 4 } }
              Text('Trackers').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#291E17').margin({ left: 4 })

              // === HStack (Cards) ===
              // props: { space: 12 }
              // modifier: { width: '100%' }
              // children: 3
              Row({ space: 12 }) {
                // === TrackerCard 1 ===
                // modifier: { layoutWeight: 1, minHeight: 100, backgroundColor: '#FFE4CE', borderRadius: 24, padding: { top: 20, bottom: 20, left: 16, right: 16 } }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Current streak' }
                  // modifier: { fontSize: 13, fontWeight: FontWeight.Normal, fontColor: '#6E6661' }
                  Text('Current\nstreak').fontSize(13).fontWeight(FontWeight.Normal).fontColor('#6E6661')
                  Blank()
                  // === Text ===
                  // props: { text: '5 days' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Bold, fontColor: '#291E17' }
                  Text('5 days').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#291E17')
                }.layoutWeight(1).height(100).backgroundColor('#FFE4CE').borderRadius(24).padding({ top: 20, bottom: 20, left: 16, right: 16 })

                // === TrackerCard 2 ===
                // modifier: { layoutWeight: 1, minHeight: 100, backgroundColor: '#FFE4CE', borderRadius: 24, padding: { top: 20, bottom: 20, left: 16, right: 16 } }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Accuracy' }
                  // modifier: { fontSize: 13, fontWeight: FontWeight.Normal, fontColor: '#6E6661' }
                  Text('Accuracy').fontSize(13).fontWeight(FontWeight.Normal).fontColor('#6E6661')
                  Blank()
                  // === Text ===
                  // props: { text: '84%' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Bold, fontColor: '#291E17' }
                  Text('84%').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#291E17')
                }.layoutWeight(1).height(100).backgroundColor('#FFE4CE').borderRadius(24).padding({ top: 20, bottom: 20, left: 16, right: 16 })

                // === TrackerCard 3 ===
                // modifier: { layoutWeight: 1, minHeight: 100, backgroundColor: '#FFE4CE', borderRadius: 24, padding: { top: 20, bottom: 20, left: 16, right: 16 } }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Rank' }
                  // modifier: { fontSize: 13, fontWeight: FontWeight.Normal, fontColor: '#6E6661' }
                  Text('Rank').fontSize(13).fontWeight(FontWeight.Normal).fontColor('#6E6661')
                  Blank()
                  // === Text ===
                  // props: { text: 'Top 12%' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Bold, fontColor: '#291E17' }
                  Text('Top 12%').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#291E17')
                }.layoutWeight(1).height(100).backgroundColor('#FFE4CE').borderRadius(24).padding({ top: 20, bottom: 20, left: 16, right: 16 })
              }.width('100%')
            }.width('100%')
          }.width('100%').padding({ left: 16, right: 16, bottom: 40 })
        }.width('100%').layoutWeight(1)
      }.width('100%').layoutWeight(1).padding({ top: 10, bottom: 10 })
    }.width('100%').height('100%')
  }
}