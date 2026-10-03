@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', padding: { left: 16, right: 16, top: 12, bottom: 12 }, backgroundColor: '#F5F5F5' }
      // children: 3
      Column({ space: 12 }) {
        // === Text ===
        // props: { text: 'Course Catalog' }
        // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#111111', textAlign: TextAlign.Start }
        Text('Course Catalog').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#111111').textAlign(TextAlign.Start)

        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', backgroundColor: '#FFF', borderRadius: 6 }
        // children: 3
        Row({ space: 0 }) {
          // === Button (Tab 0) ===
          // modifier: { layoutWeight: 1 }
          // children: 1
          Button() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'All' }
              // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111', padding: { top: 12, bottom: 12 }, textAlign: TextAlign.Center }
              Text('All').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111').padding({ top: 12, bottom: 12 }).textAlign(TextAlign.Center)
              // === Rectangle ===
              // modifier: { width: '100%', height: 2, backgroundColor: '#111111' }
              Rect().width('100%').height(2).fill('#111111')
            }.width('100%')
          }.layoutWeight(1)

          // === Button (Tab 1) ===
          // modifier: { layoutWeight: 1 }
          // children: 1
          Button() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Enrolled' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444', padding: { top: 12, bottom: 12 }, textAlign: TextAlign.Center }
              Text('Enrolled').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444').padding({ top: 12, bottom: 12 }).textAlign(TextAlign.Center)
              // === Rectangle ===
              // modifier: { width: '100%', height: 2, backgroundColor: 'transparent' }
              Rect().width('100%').height(2).fill('transparent')
            }.width('100%')
          }.layoutWeight(1)

          // === Button (Tab 2) ===
          // modifier: { layoutWeight: 1 }
          // children: 1
          Button() {
            // === Column ===
            // props: { space: 0 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'Completed' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444', padding: { top: 12, bottom: 12 }, textAlign: TextAlign.Center }
              Text('Completed').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444').padding({ top: 12, bottom: 12 }).textAlign(TextAlign.Center)
              // === Rectangle ===
              // modifier: { width: '100%', height: 2, backgroundColor: 'transparent' }
              Rect().width('100%').height(2).fill('transparent')
            }.width('100%')
          }.layoutWeight(1)
        }.width('100%').backgroundColor('#FFF').borderRadius(6)

        // === Scroll ===
        // props: { scrollable: ScrollDirection.Vertical, barWidth: 0 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll({ scroller: new Scroller() }) {
          .scrollBar(BarState.Off)
          // === Column ===
          // props: { space: 12 }
          // modifier: { width: '100%' }
          // children: 7
          Column({ space: 12 }) {
            // === Text ===
            // props: { text: 'All Courses' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#444444', textAlign: TextAlign.Start }
            Text('All Courses').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#444444').textAlign(TextAlign.Start)

            // === CourseCard 1 ===
            // modifier: { width: '100%' }
            // children: 1
            Column() {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: 12, alignItems: ItemVerticalCenter }
              // children: 2
              Row({ space: 12 }) {
                // === Column ===
                // props: { space: 8 }
                // modifier: { layoutWeight: 1, alignItems: ItemAlignStart }
                // children: 2
                Column({ space: 8 }) {
                  // === Text ===
                  // props: { text: 'Course 1' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111' }
                  Text('Course 1').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')
                  // === Text ===
                  // props: { text: 'Duration: 5 hrs' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444' }
                  Text('Duration: 5 hrs').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444')
                }.layoutWeight(1).alignItems(HorizontalAlign.Start)

                // === Button ===
                // modifier: { height: 24, padding: { left: 12, right: 12 }, backgroundColor: '#111111', borderRadius: 12 }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'View' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFF' }
                  Text('View').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFF')
                }.height(24).padding({ left: 12, right: 12 }).backgroundColor('#111111').borderRadius(12)
              }.width('100%').padding(12).alignItems(VerticalAlign.Center)
            }.width('100%').backgroundColor('#FFF').borderRadius(10).shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

            // === CourseCard 2 ===
            // modifier: { width: '100%' }
            // children: 1
            Column() {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: 12, alignItems: ItemVerticalCenter }
              // children: 2
              Row({ space: 12 }) {
                // === Column ===
                // props: { space: 8 }
                // modifier: { layoutWeight: 1, alignItems: ItemAlignStart }
                // children: 2
                Column({ space: 8 }) {
                  // === Text ===
                  // props: { text: 'Course 2' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111' }
                  Text('Course 2').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')
                  // === Text ===
                  // props: { text: 'Duration: 6 hrs' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444' }
                  Text('Duration: 6 hrs').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444')
                }.layoutWeight(1).alignItems(HorizontalAlign.Start)

                // === Button ===
                // modifier: { height: 24, padding: { left: 12, right: 12 }, backgroundColor: '#111111', borderRadius: 12 }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'View' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFF' }
                  Text('View').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFF')
                }.height(24).padding({ left: 12, right: 12 }).backgroundColor('#111111').borderRadius(12)
              }.width('100%').padding(12).alignItems(VerticalAlign.Center)
            }.width('100%').backgroundColor('#FFF').borderRadius(10).shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

            // === CourseCard 3 ===
            // modifier: { width: '100%' }
            // children: 1
            Column() {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: 12, alignItems: ItemVerticalCenter }
              // children: 2
              Row({ space: 12 }) {
                // === Column ===
                // props: { space: 8 }
                // modifier: { layoutWeight: 1, alignItems: ItemAlignStart }
                // children: 2
                Column({ space: 8 }) {
                  // === Text ===
                  // props: { text: 'Course 3' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111' }
                  Text('Course 3').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')
                  // === Text ===
                  // props: { text: 'Duration: 7 hrs' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444' }
                  Text('Duration: 7 hrs').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444')
                }.layoutWeight(1).alignItems(HorizontalAlign.Start)

                // === Button ===
                // modifier: { height: 24, padding: { left: 12, right: 12 }, backgroundColor: '#111111', borderRadius: 12 }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'View' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFF' }
                  Text('View').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFF')
                }.height(24).padding({ left: 12, right: 12 }).backgroundColor('#111111').borderRadius(12)
              }.width('100%').padding(12).alignItems(VerticalAlign.Center)
            }.width('100%').backgroundColor('#FFF').borderRadius(10).shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

            // === CourseCard 4 ===
            // modifier: { width: '100%' }
            // children: 1
            Column() {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: 12, alignItems: ItemVerticalCenter }
              // children: 2
              Row({ space: 12 }) {
                // === Column ===
                // props: { space: 8 }
                // modifier: { layoutWeight: 1, alignItems: ItemAlignStart }
                // children: 2
                Column({ space: 8 }) {
                  // === Text ===
                  // props: { text: 'Course 4' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111' }
                  Text('Course 4').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')
                  // === Text ===
                  // props: { text: 'Duration: 8 hrs' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444' }
                  Text('Duration: 8 hrs').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444')
                }.layoutWeight(1).alignItems(HorizontalAlign.Start)

                // === Button ===
                // modifier: { height: 24, padding: { left: 12, right: 12 }, backgroundColor: '#111111', borderRadius: 12 }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'View' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFF' }
                  Text('View').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFF')
                }.height(24).padding({ left: 12, right: 12 }).backgroundColor('#111111').borderRadius(12)
              }.width('100%').padding(12).alignItems(VerticalAlign.Center)
            }.width('100%').backgroundColor('#FFF').borderRadius(10).shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

            // === CourseCard 5 ===
            // modifier: { width: '100%' }
            // children: 1
            Column() {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: 12, alignItems: ItemVerticalCenter }
              // children: 2
              Row({ space: 12 }) {
                // === Column ===
                // props: { space: 8 }
                // modifier: { layoutWeight: 1, alignItems: ItemAlignStart }
                // children: 2
                Column({ space: 8 }) {
                  // === Text ===
                  // props: { text: 'Course 5' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111' }
                  Text('Course 5').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')
                  // === Text ===
                  // props: { text: 'Duration: 9 hrs' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444' }
                  Text('Duration: 9 hrs').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444')
                }.layoutWeight(1).alignItems(HorizontalAlign.Start)

                // === Button ===
                // modifier: { height: 24, padding: { left: 12, right: 12 }, backgroundColor: '#111111', borderRadius: 12 }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'View' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFF' }
                  Text('View').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFF')
                }.height(24).padding({ left: 12, right: 12 }).backgroundColor('#111111').borderRadius(12)
              }.width('100%').padding(12).alignItems(VerticalAlign.Center)
            }.width('100%').backgroundColor('#FFF').borderRadius(10).shadow({ radius: 4, color: '#1A000000', offsetY: 2 })

            // === CourseCard 6 ===
            // modifier: { width: '100%' }
            // children: 1
            Column() {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%', padding: 12, alignItems: ItemVerticalCenter }
              // children: 2
              Row({ space: 12 }) {
                // === Column ===
                // props: { space: 8 }
                // modifier: { layoutWeight: 1, alignItems: ItemAlignStart }
                // children: 2
                Column({ space: 8 }) {
                  // === Text ===
                  // props: { text: 'Course 6' }
                  // modifier: { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: '#111111' }
                  Text('Course 6').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#111111')
                  // === Text ===
                  // props: { text: 'Duration: 10 hrs' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#444444' }
                  Text('Duration: 10 hrs').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#444444')
                }.layoutWeight(1).alignItems(HorizontalAlign.Start)

                // === Button ===
                // modifier: { height: 24, padding: { left: 12, right: 12 }, backgroundColor: '#111111', borderRadius: 12 }
                // children: 1
                Button() {
                  // === Text ===
                  // props: { text: 'View' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFF' }
                  Text('View').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFF')
                }.height(24).padding({ left: 12, right: 12 }).backgroundColor('#111111').borderRadius(12)
              }.width('100%').padding(12).alignItems(VerticalAlign.Center)
            }.width('100%').backgroundColor('#FFF').borderRadius(10).shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          }.width('100%')
        }.width('100%').layoutWeight(1)
      }.width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 }).backgroundColor('#F5F5F5')
    }.width('100%').height('100%')
  }
}