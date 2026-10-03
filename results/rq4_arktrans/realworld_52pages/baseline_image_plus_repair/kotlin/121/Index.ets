@Entry
@Component
struct OverallAnalyticsPage {
  // Mock Data matching the Kotlin source and Screenshot
  private consistency: number = 0.72;
  private topHabits: TopHabit[] = [
    { name: 'Morning Run', percentage: 0.70 },
    { name: 'Read 30 Minutes', percentage: 0.69 },
    { name: 'Meditate', percentage: 0.63 }
  ];

  build() {
    Column() {
      // Header Section
      Row() {
        Button('←')
          .type(ButtonType.Circle)
          .backgroundColor('#E8DEF8') // Light purple background for button
          .fontColor('#4C1D95') // Dark purple text
          .width(44)
          .height(44)
          .borderRadius(22)
          .margin({ right: 16 })

        Text('Overall Analytics')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1F2937')
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })

      Scroll() {
        Column() {
          // Main Analytics Card
          Row() {
            // Left Side: Circular Progress
            Column() {
              Stack() {
                // Background Track (Simulated with a full circle stroke)
                Circle()
                  .width(160)
                  .height(160)
                  .fill('transparent')
                  .stroke('#E9D5FF') // Very light purple track
                  .strokeWidth(24)

                // Foreground Progress
                // Note: ArkTS Progress component draws clockwise from top by default.
                // To match the screenshot (starts ~8 o'clock), we rotate it -135 degrees.
                Progress({ value: this.consistency * 100, total: 100, type: ProgressType.Ring })
                  .width(160)
                  .height(160)
                  .color('#6B46C1') // Primary Purple
                  .strokeWidth(24)
                  .rotate({ angle: -135 })

                // Center Text
                Column() {
                  Text(`${Math.round(this.consistency * 100)}%`)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#6B46C1')
                  
                  Text('Consistency')
                    .fontSize(14)
                    .fontColor('#4B5563')
                    .margin({ top: 4 })
                }
              }
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)

            // Right Side: Top Habits List
            Column() {
              Text('Top Habits')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F2937')
                .margin({ bottom: 16 })

              ForEach(this.topHabits, (habit: TopHabit, index: number) => {
                Row() {
                  Text(`${index + 1}.`)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#6B46C1')
                    .width(24)
                  
                  Column() {
                    Text(habit.name)
                      .fontSize(16)
                      .fontColor('#1F2937')
                    
                    Text(`${Math.round(habit.percentage * 100)}%`)
                      .fontSize(14)
                      .fontColor('#6B7280')
                      .margin({ top: 2 })
                  }
                }
                .width('100%')
                .margin({ bottom: 16 })
              })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#00000010', offsetY: 4 })
          .margin({ left: 20, right: 20, bottom: 24 })

          // Heatmap Overview Card
          Column() {
            Text('Heatmap Overview')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1F2937')
              .margin({ bottom: 16 })

            // Grid of squares simulating the heatmap
            // The screenshot shows 7 rows (days of week) x 20 columns
            ForEach(Array.from({ length: 7 }), () => {
              Row() {
                ForEach(Array.from({ length: 20 }), (_, colIndex: number) => {
                  // Logic to replicate the specific pattern in the screenshot
                  // Columns 5, 9, 14 have darker blocks
                  let fillColor: string = '#F3F4F6'; // Default light gray
                  if (colIndex === 5 || colIndex === 9 || colIndex === 14) {
                     // Vary intensity slightly or keep consistent based on row
                     // In screenshot, these columns are consistently filled
                     fillColor = '#A78BFA'; // Medium purple
                  } else if (colIndex % 3 === 0 && colIndex !== 0) {
                     // Some lighter scattered blocks
                     fillColor = '#DDD6FE'; // Light purple
                  }

                  Rect()
                    .width(14)
                    .height(14)
                    .borderRadius(3)
                    .fill(fillColor)
                    .margin({ right: 2 })
                })
              }
              .margin({ bottom: 2 })
            })
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 8, color: '#00000010', offsetY: 4 })
          .margin({ left: 20, right: 20, bottom: 40 })
        }
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FCF9FD') // Very faint purple/white background
  }
}

interface TopHabit {
  name: string;
  percentage: number;
}