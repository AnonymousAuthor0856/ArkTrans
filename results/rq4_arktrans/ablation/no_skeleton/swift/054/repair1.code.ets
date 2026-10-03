@Entry
@Component
struct RootScreen {
  @State works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]

  @State charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column({ space: 0 }) {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: { top: 14, bottom: 14 }, backgroundColor: '#FFF' }
        // children: 1
        Row() {
          // === Text ===
          // props: { text: 'Homework Submit' }
          // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, fontColor: '#1E293B' }
          Text('Homework Submit').fontSize(26).fontWeight(FontWeight.Bold).fontColor('#1E293B')
        }.width('100%').padding({ top: 14, bottom: 14 }).backgroundColor('#FFF')

        // === Scroll ===
        // props: { scrollable: ScrollDirection.Vertical, barWidth: 0 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 14 }
          // modifier: { width: '100%', padding: 14, alignment: HorizontalAlign.Start }
          // children: 4
          Column({ space: 14 }) {
            // === Text ===
            // props: { text: 'Assignments' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#1E293B' }
            Text('Assignments').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1E293B')

            // === Grid ===
            // props: { columnsTemplate: '1fr 1fr', columnsGap: 10, rowsGap: 10 }
            // modifier: { width: '100%' }
            // children: 4
            Grid() {
              ForEach(this.works, (w: Homework) => {
                // === GridItem ===
                // children: 1
                GridItem() {
                  // === Column ===
                  // props: { space: 6 }
                  // modifier: { width: '100%', height: '100%', padding: 10, backgroundColor: '#FFF', borderRadius: 10, border: { width: 1, color: '#D1D5DB' }, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }
                  // children: 3
                  Column({ space: 6 }) {
                    // === Image ===
                    // modifier: { width: 40, height: 40, borderRadius: 6, objectFit: ImageFit.Cover }
                    Image($r('app.media.startIcon')).width(40).height(40).borderRadius(6).objectFit(ImageFit.Cover)

                    // === Blank ===
                    Blank()

                    // === Column ===
                    // props: { space: 2 }
                    // modifier: { width: '100%', alignItems: ItemAlign.Center }
                    // children: 2
                    Column({ space: 2 }) {
                      // === Text ===
                      // props: { text: w.title }
                      // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#1E293B', textAlign: TextAlign.Center }
                      Text(w.title).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#1E293B').textAlign(TextAlign.Center)
                      // === Text ===
                      // props: { text: w.status }
                      // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#1E293B', textAlign: TextAlign.Center }
                      Text(w.status).fontSize(11).fontWeight(FontWeight.Medium).fontColor('#1E293B').textAlign(TextAlign.Center)
                    }
                  }
                }
              })
            }.columnsTemplate('1fr 1fr').columnsGap(10).rowsGap(10).width('100%')

            // === Text ===
            // props: { text: 'Progress Chart' }
            // modifier: { fontSize: 18, fontWeight: FontWeight.Semibold, fontColor: '#1E293B' }
            Text('Progress Chart').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#1E293B')

            // === Column ===
            // props: { space: 6 }
            // modifier: { width: '100%' }
            // children: 4
            Column({ space: 6 }) {
              ForEach(this.charts, (c: ChartData) => {
                // === Column ===
                // props: { space: 0 }
                // modifier: { width: '100%' }
                // children: 2
                Column({ space: 0 }) {
                  // === Row ===
                  // props: { space: 0 }
                  // modifier: { width: '100%', height: 24, backgroundColor: '#E2E8F0', borderRadius: 6 }
                  // children: 1
                  Row() {
                    // === Row ===
                    // props: { space: 0 }
                    // modifier: { width: `${c.progress * 100}%`, height: '100%', backgroundColor: '#0EA5E9', borderRadius: 6 }
                    // children: 0
                    Row().width(`${c.progress * 100}%`).height('100%').backgroundColor('#0EA5E9').borderRadius(6)
                  }.width('100%').height(24).backgroundColor('#E2E8F0').borderRadius(6)

                  // === Text ===
                  // props: { text: `${c.label}: ${Math.round(c.progress * 100)}%` }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Regular, fontColor: '#1E293B' }
                  Text(`${c.label}: ${Math.round(c.progress * 100)}%`).fontSize(12).fontWeight(FontWeight.Normal).fontColor('#1E293B')
                }
              })
            }

            // === Button ===
            // modifier: { width: '60%', height: 40, backgroundColor: '#6366F1', borderRadius: 14, margin: { top: 14 }, horizontalAlignment: HorizontalAlign.Center }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'Submit New HW' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, fontColor: '#FFF' }
              Text('Submit New HW').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFF')
            }.width('60%').height(40).backgroundColor('#6366F1').borderRadius(14).margin({ top: 14 }).type(ButtonType.Normal).horizontalAlignment(HorizontalAlign.Center)
          }.width('100%').padding(14).alignItems(HorizontalAlign.Start)
        }.width('100%').layoutWeight(1).scrollBar(BarState.Off)
      }.width('100%').height('100%')

      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%', linearGradient: { angle: 180, colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]] } }
      // children: 0
      Column().width('100%').height('100%').linearGradient({ angle: 180, colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]] })
    }.width('100%').height('100%')
  }
}

interface Homework {
  id: number;
  title: string;
  status: string;
}

interface ChartData {
  id: number;
  label: string;
  progress: number;
}