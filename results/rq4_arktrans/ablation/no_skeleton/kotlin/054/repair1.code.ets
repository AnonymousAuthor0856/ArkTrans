@Entry
@Component
struct HomeworkSubmit {
  @State works: WorkItem[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]

  @State charts: ChartItem[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    // === Column (Root) ===
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Column() {
      // === Text (Header) ===
      // props: { text: 'Homework Submit' }
      // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, color: '#1E293B', padding: 14, backgroundColor: '#FFF' }
      Text('Homework Submit')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .padding(14)
        .backgroundColor('#FFF')

      // === Column (Content) ===
      // props: { space: 14 }
      // modifier: { width: '100%', layoutWeight: 1, padding: 14, linearGradient: { angle: 180, colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]] } }
      // children: 3
      Column({ space: 14 }) {
        // === Text (Assignments Title) ===
        // props: { text: 'Assignments' }
        // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#1E293B' }
        Text('Assignments')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')

        // === Grid (Works) ===
        // props: { columnsTemplate: '1fr 1fr', columnsGap: 10, rowsGap: 10 }
        // modifier: { width: '100%' }
        // children: 4
        Grid() {
          ForEach(this.works, (item: WorkItem) => {
            GridItem() {
              // === Column (Card) ===
              // props: { space: 6, alignItems: ItemAlign.Center }
              // modifier: { width: '100%', aspectRatio: 1, backgroundColor: '#FFF', borderRadius: 10, borderColor: '#D1D5DB', borderWidth: 1, padding: 10 }
              // children: 3
              Column({ space: 6 }) {
                // === Image (Icon Placeholder) ===
                // modifier: { width: 40, height: 40, borderRadius: 6, objectFit: ImageFit.Cover }
                Image($r('app.media.startIcon'))
                  .width(40)
                  .height(40)
                  .borderRadius(6)
                  .objectFit(ImageFit.Cover)

                // === Text (Title) ===
                // props: { text: item.title }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#1E293B' }
                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')

                // === Text (Status) ===
                // props: { text: item.status }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#1E293B' }
                Text(item.status)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
              }
              .alignItems(HorizontalAlign.Center)
              .width('100%')
              .aspectRatio(1)
              .backgroundColor('#FFF')
              .borderRadius(10)
              .border({ width: 1, color: '#D1D5DB' })
              .padding(10)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')

        // === Column (Progress Chart Section) ===
        // props: { space: 6 }
        // modifier: { width: '100%' }
        // children: 5
        Column({ space: 6 }) {
          // === Text (Chart Title) ===
          // props: { text: 'Progress Chart' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#1E293B' }
          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          ForEach(this.charts, (item: ChartItem) => {
            // === Row (Bar Container) ===
            // modifier: { width: '100%', height: 24, backgroundColor: '#E2E8F0', borderRadius: 6 }
            // children: 1
            Row() {
              // === Row (Bar Fill) ===
              // modifier: { width: `${item.progress * 100}%`, height: '100%', backgroundColor: '#0EA5E9', borderRadius: 6 }
              Row() {}
                .width(`${item.progress * 100}%`)
                .height('100%')
                .backgroundColor('#0EA5E9')
                .borderRadius(6)
            }
            .width('100%')
            .height(24)
            .backgroundColor('#E2E8F0')
            .borderRadius(6)

            // === Text (Label) ===
            // props: { text: `${item.label}: ${Math.round(item.progress * 100)}%` }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Normal, color: '#1E293B' }
            Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Normal)
              .fontColor('#1E293B')
          })
        }
        .width('100%')

        // === Blank ===
        Blank()

        // === Button (Submit) ===
        // modifier: { width: '60%', height: 40, backgroundColor: '#6366F1', borderRadius: 14, fontColor: '#FFF' }
        // children: 1
        Button() {
          // === Text ===
          // props: { text: 'Submit New HW' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#FFF' }
          Text('Submit New HW')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFF')
        }
        .width('60%')
        .height(40)
        .backgroundColor('#6366F1')
        .borderRadius(14)
        .fontColor('#FFF')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .linearGradient({
        angle: 180,
        colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]]
      })
    }
    .width('100%')
    .height('100%')
  }
}

interface WorkItem {
  id: number;
  title: string;
  status: string;
}

interface ChartItem {
  id: number;
  label: string;
  progress: number;
}