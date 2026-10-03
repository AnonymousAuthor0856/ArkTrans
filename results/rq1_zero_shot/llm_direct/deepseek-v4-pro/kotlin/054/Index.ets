import { ComponentContent, UIContext } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  @State works: Homework[] = [
    { id: 1, title: "Linear Algebra HW1", status: "Submitted" },
    { id: 2, title: "Data Structures HW2", status: "Pending" },
    { id: 3, title: "Algorithm HW3", status: "Graded" },
    { id: 4, title: "Probability HW4", status: "Pending" }
  ];
  @State charts: ChartData[] = [
    { id: 1, label: "Week 1", progress: 0.7 },
    { id: 2, label: "Week 2", progress: 0.9 },
    { id: 3, label: "Week 3", progress: 0.5 },
    { id: 4, label: "Week 4", progress: 0.8 }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#F1F5F9')

      // Main content with gradient background
      Column() {
        // Assignments section
        Text('Assignments')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ bottom: 10 })

        Grid() {
          ForEach(this.works, (item: Homework) => {
            GridItem() {
              Column() {
                Row() {
                  Column()
                    .width(40)
                    .height(40)
                    .backgroundColor('#06B6D4')
                    .borderRadius(6)
                }
                .width('100%')
                .justifyContent(FlexAlign.Center)

                Text(item.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
                  .margin({ top: 6 })

                Text(item.status)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E293B')
                  .margin({ top: 2 })
              }
              .width('100%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .padding(10)
              .backgroundColor('#FFFFFF')
              .borderRadius(10)
              .border({ width: 1, color: '#D1D5DB' })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .width('100%')
        .margin({ bottom: 14 })

        // Progress Chart section
        Text('Progress Chart')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ bottom: 10 })

        ForEach(this.charts, (item: ChartData) => {
          Column() {
            Row() {
              Row()
                .width(`${item.progress * 100}%`)
                .height(24)
                .backgroundColor('#0EA5E9')
                .borderRadius(6)
            }
            .width('100%')
            .height(24)
            .backgroundColor('#E2E8F0')
            .borderRadius(6)

            Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
              .fontSize(12)
              .fontColor('#1E293B')
              .margin({ top: 4 })
          }
          .width('100%')
          .margin({ bottom: 6 })
        })

        // Submit button
        Button('Submit New HW')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#6366F1')
          .borderRadius(14)
          .height(40)
          .width('60%')
          .margin({ top: 14 })
          .alignSelf(ItemAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(14)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
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