// entry/src/main/ets/pages/Index.ets

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

@Entry
@Component
struct HomeworkSubmitPage {
  // State data
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
      // Top Bar
      Row() {
        Text("Homework Submit")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(60)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)

      // Main Content Area with Gradient Background
      Column() {
        // Assignments Section
        Text("Assignments")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ top: 14, bottom: 10 })
          .alignSelf(ItemAlign.Start)

        GridContainer() {
          ForEach(this.works, (item: Homework) => {
            HomeworkCard({ item: item })
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(10)
        .columnsGap(10)
        .width('100%')
        .margin({ bottom: 14 })

        // Progress Chart Section
        Text("Progress Chart")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .margin({ bottom: 10 })
          .alignSelf(ItemAlign.Start)

        Column() {
          ForEach(this.charts, (item: ChartData) => {
            ProgressBarChart({ item: item })
          })
        }
        .width('100%')
        .margin({ bottom: 20 })

        // Submit Button
        Button("Submit New HW")
          .type(ButtonType.Capsule)
          .backgroundColor('#6366F1')
          .fontColor(Color.White)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .width('60%')
          .height(40)
          .margin({ bottom: 20 })

      }
      .width('100%')
      .layoutWeight(1)
      .padding(14)
      .linearGradient({
        angle: 90,
        colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}

// Homework Card Component
@Component
struct HomeworkCard {
  private item: Homework = { id: 0, title: "", status: "" };

  aboutToAppear(): void {
    // Initialization if needed
  }

  build() {
    Column() {
      // Icon placeholder
      Rect()
        .width(40)
        .height(40)
        .fill('#06B6D4')
        .borderRadius(6)
        .margin({ bottom: 6 })

      Text(this.item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 2 })

      Text(this.item.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(10)
    .backgroundColor(Color.White)
    .borderRadius(10)
    .border({ width: 1, color: '#D1D5DB' })
  }
}

// Progress Bar Chart Component
@Component
struct ProgressBarChart {
  private item: ChartData = { id: 0, label: "", progress: 0 };

  aboutToAppear(): void {
    // Initialization if needed
  }

  build() {
    Column() {
      // Progress Bar Background
      Row() {
        // Progress Fill
        Row()
          .width(`${this.item.progress * 100}%`)
          .height(24)
          .backgroundColor('#0EA5E9')
          .borderRadius({ topLeft: 6, bottomLeft: 6 })
      }
      .width('100%')
      .height(24)
      .backgroundColor('#E2E8F0')
      .borderRadius(6)

      // Label
      Text(`${this.item.label}: ${Math.round(this.item.progress * 100)}%`)
        .fontSize(12)
        .fontColor('#1E293B')
        .margin({ top: 4 })
        .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .margin({ bottom: 6 })
  }
}