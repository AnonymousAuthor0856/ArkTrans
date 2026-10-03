@Entry
@Component
struct Index {
  @State currentMonthIndex: number = 0

  // Data structures to represent the heatmap grid
  private months: string[] = ['DEC', 'NOV', 'OCT', 'SEP']
  
  // Colors based on screenshot analysis (Purple palette)
  private readonly COLOR_DARK_PURPLE = '#6750A4'
  private readonly COLOR_MED_PURPLE = '#9C88D6'
  private readonly COLOR_LIGHT_PURPLE = '#EADDFF'
  private readonly COLOR_WHITE = '#FFFFFF'

  // Mock data for the heatmap cells (1=dark, 2=med, 3=light, 0=white/empty)
  // Structure: [Month][Week][Day]
  private heatmapData: number[][][] = [
    // DEC
    [
      [1, 0, 0, 1, 0, 0, 1],
      [0, 3, 0, 0, 3, 0, 3],
      [1, 0, 3, 1, 0, 3, 1],
      [0, 3, 0, 1, 0, 1, 0],
      [3, 0, 1, 0, 0, 0, 0]
    ],
    // NOV
    [
      [0, 0, 0, 0, 0, 1, 0],
      [1, 0, 3, 0, 3, 0, 3],
      [0, 1, 0, 3, 0, 1, 0],
      [1, 0, 3, 0, 1, 0, 1],
      [0, 3, 0, 1, 0, 3, 0]
    ],
    // OCT
    [
      [0, 0, 0, 1, 0, 3, 0],
      [3, 0, 3, 0, 1, 0, 3],
      [0, 3, 0, 3, 0, 3, 0],
      [3, 0, 1, 0, 1, 0, 3],
      [0, 3, 0, 3, 0, 0, 0]
    ],
    // SEP
    [
      [0, 1, 0, 3, 0, 3, 0],
      [3, 0, 1, 0, 3, 0, 1],
      [0, 3, 0, 3, 0, 1, 0],
      [3, 0, 1, 0, 3, 0, 3],
      [0, 1, 0, 0, 0, 0, 0]
    ]
  ]

  build() {
    Column() {
      // Header Section
      Row() {
        // Back Button Circle
        Stack() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .margin({ right: 4 }) // Adjust icon position slightly
        }
        .width(48)
        .height(48)
        .backgroundColor('#EADDFF')
        .borderRadius(24)

        Text('Heatmap')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 16, top: 40, bottom: 20 })

      // Year Label
      Text('2025')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#49454F')
        .alignSelf(ItemAlign.Start)
        .margin({ left: 16, bottom: 16 })

      // Scrollable Heatmap Content
      Scroll() {
        Column() {
          ForEach(this.months, (monthName: string, index: number) => {
            this.MonthBlock(monthName, this.heatmapData[index])
          })
        }
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FE') // Very light purple background
  }

  @Builder
  MonthBlock(name: string, weeks: number[][]) {
    Column() {
      Text(name)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#49454F')
        .alignSelf(ItemAlign.Start)
        .margin({ left: 16, bottom: 8 })

      // The Grid of Days
      Column() {
        ForEach(weeks, (weekDays: number[], weekIndex: number) => {
          Row() {
            ForEach(weekDays, (dayValue: number, dayIndex: number) => {
              this.DayCell(dayValue)
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .margin({ left: 16 })
          
          // Add spacing between weeks if it's not the last one
          if (weekIndex < weeks.length - 1) {
            Blank().height(4)
          }
        })
      }
      
      // Spacing between months
      Blank().height(24)
    }
  }

  @Builder
  DayCell(value: number) {
    Stack() {
      // Empty content, just color
    }
    .width(24)
    .height(24)
    .borderRadius(6)
    .margin({ right: 4 })
    .backgroundColor(this.getColorForValue(value))
  }

  getColorForValue(value: number): string {
    switch (value) {
      case 1: return this.COLOR_DARK_PURPLE
      case 2: return this.COLOR_MED_PURPLE
      case 3: return this.COLOR_LIGHT_PURPLE
      default: return this.COLOR_WHITE
    }
  }
}