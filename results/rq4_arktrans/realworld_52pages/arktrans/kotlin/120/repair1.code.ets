@Entry
@Component
struct Index {
  @State currentDate: Date = new Date()

  build() {
    Column() {
      // Header Row
      Row() {
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#E6D9F8')
        .width(48)
        .height(48)
        .margin({ right: 16 })

        Text('Morning Run')
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
      }
      .width('100%')
      .padding({ top: 40, left: 24, bottom: 24 })

      // Stats Grid
      Grid() {
        GridItem() {
          Column() {
            Text('Consistency')
              .fontSize(16)
              .fontColor('#49454F')
              .margin({ bottom: 4 })
            Text('71%')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7E57C2')
          }
          .alignItems(HorizontalAlign.Start)
        }
        GridItem() {
          Column() {
            Text('Current Streak')
              .fontSize(16)
              .fontColor('#49454F')
              .margin({ bottom: 4 })
            Text('27 days')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7E57C2')
          }
          .alignItems(HorizontalAlign.Start)
        }
        GridItem() {
          Column() {
            Text('Best Streak')
              .fontSize(16)
              .fontColor('#49454F')
              .margin({ bottom: 4 })
            Text('29 days')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7E57C2')
          }
          .alignItems(HorizontalAlign.Start)
        }
        GridItem() {
          Column() {
            Text('Started')
              .fontSize(16)
              .fontColor('#49454F')
              .margin({ bottom: 4 })
            Text('204 days ago')
              .fontSize(40)
              .fontWeight(FontWeight.Bold)
              .fontColor('#7E57C2')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .alignItems(HorizontalAlign.Start)
        }
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto auto')
      .columnsGap(24)
      .rowsGap(24)
      .width('100%')
      .padding({ left: 24, right: 24 })

      // Heatmap Section
      Column() {
        Text('Completion Heatmap')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
          .margin({ bottom: 16 })

        // Simulated Heatmap Grid (7 rows x 14 cols)
        ForEach(this.getHeatmapData(), (item: HeatmapCell) => {
          Row() {
            ForEach(Array.from({ length: 14 }), (_, index: number) => {
              // Deterministic pseudo-random coloring based on position to match screenshot pattern
              const isFilled = (index === 0 && item.row !== 0 && item.row !== 5 && item.row !== 6) ||
                               (index === 1 && item.row !== 6) ||
                               (index === 2 && item.row !== 3 && item.row !== 6) ||
                               (index === 3 && item.row !== 3 && item.row !== 6) ||
                               (index === 4 && item.row !== 3) ||
                               (index === 5 && item.row !== 2 && item.row !== 4 && item.row !== 6) ||
                               (index === 6 && item.row !== 1 && item.row !== 5) ||
                               (index === 7 && item.row !== 1 && item.row !== 2 && item.row !== 4 && item.row !== 6) ||
                               (index === 8 && item.row !== 2 && item.row !== 5) ||
                               (index === 9 && item.row !== 1 && item.row !== 2 && item.row !== 4 && item.row !== 6) ||
                               (index === 10 && item.row !== 0 && item.row !== 2 && item.row !== 4 && item.row !== 5) ||
                               (index === 11 && item.row !== 0 && item.row !== 1 && item.row !== 3 && item.row !== 4 && item.row !== 5) ||
                               (index === 12 && item.row !== 0 && item.row !== 1 && item.row !== 2 && item.row !== 3 && item.row !== 4 && item.row !== 5 && item.row !== 6);

              Rect()
                .width(20)
                .height(20)
                .borderRadius(4)
                .backgroundColor(isFilled ? '#7E57C2' : '#E0E0E0')
                .margin({ right: 4 })
            })
          }.width('100%').margin({ bottom: 4 })
        }, (item: HeatmapCell) => `${item.row}-${item.col}`)

      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24 })

      // Calendar View Link
      Row() {
        Text('Calendar View')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
        Blank()
        Text('→')
          .fontSize(24)
          .fontColor('#1C1B1F')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 16 })

      // Weekly Activity Header
      Text('Weekly Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1C1B1F')
        .margin({ left: 24 })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FCF2FF')
  }

  getHeatmapData(): Array<HeatmapCell> {
    const data: Array<HeatmapCell> = [];
    for (let r = 0; r < 7; r++) {
      for (let c = 0; c < 14; c++) {
        data.push({ row: r, col: c });
      }
    }
    return data;
  }
}

interface HeatmapCell {
  row: number;
  col: number;
}