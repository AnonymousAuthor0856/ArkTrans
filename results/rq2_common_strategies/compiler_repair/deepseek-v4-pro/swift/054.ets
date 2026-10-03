@Entry
@Component
struct SingleFileUIApp {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]
  @State private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Text('Homework Submit')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#1E293B')
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding({ top: 14, bottom: 14 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        // Main content area using List
        List({ space: 14 }) {
          ListItem() {
            Column({ space: 14 }) {
              Text('Assignments')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#1E293B')
                .width('100%')

              // Grid of assignment cards
              Grid() {
                ForEach(this.works, (hw: Homework, index: number) => {
                  GridItem() {
                    this.buildAssignmentCard(hw)
                  }
                })
              }
              .columnsTemplate('1fr 1fr')
              .columnsGap(10)
              .rowsGap(10)
              .width('100%')
            }
          }

          ListItem() {
            Column({ space: 10 }) {
              Text('Progress Chart')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#1E293B')
                .width('100%')

              ForEach(this.charts, (chart: ChartData) => {
                Column({ space: 2 }) {
                  // Progress bar
                  Progress({ value: chart.progress, total: 1, type: ProgressType.Linear })
                    .width('100%')
                    .height(24)
                    .color('#0EA5E9')
                    .backgroundColor('#E2E8F0')
                    .borderRadius(6)
                  // Label
                  Text(chart.label + ': ' + (chart.progress * 100).toFixed(0) + '%')
                    .fontSize(12)
                    .foregroundColor('#1E293B')
                }
              })
            }
          }

          // Submit button
          ListItem() {
            Button() {
              Text('Submit New HW')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FFFFFF')
                .textAlign(TextAlign.Center)
                .width('100%')
                .height(40)
            }
            .width('60%')
            .height(40)
            .backgroundColor('#6366F1')
            .borderRadius(14)
            .margin({ left: '20%', top: 14 })
            .onClick(() => {
              console.log('Submit New HW Tapped')
            })
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding(14)
        .backgroundColor('#F1F5F9')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildAssignmentCard(hw: Homework) {
    Column({ space: 6 }) {
      // Colored square (tertiary)
      Column()
        .width(40)
        .height(40)
        .backgroundColor('#06B6D4')
        .borderRadius(6)
        .alignSelf(ItemAlign.Center)
      // Title
      Text(hw.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1E293B')
        .textAlign(TextAlign.Center)
        .width('100%')
      // Status
      Text(hw.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#1E293B')
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .padding(10)
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .border({ width: 1, color: '#D1D5DB', radius: 10 })
    .width('100%')
  }
}

// Interfaces
interface Homework {
  id: number
  title: string
  status: string
}

interface ChartData {
  id: number
  label: string
  progress: number
}