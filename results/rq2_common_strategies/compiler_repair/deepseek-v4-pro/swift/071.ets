@Entry
@Component
struct QuizForgeApp {
  private options: string[] = ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFCF9')

      // Main column
      Column({ space: 0 }) {
        // Header
        Row({ space: 0 }) {
          Column()
            .width(48)
            .height(48)
            .backgroundColor('#FCE4D1')
            .borderRadius(24)
          Blank()
          Column({ space: 2 }) {
            Text('QuizForge')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
            Text('Aroma sprint')
              .fontSize(14)
              .foregroundColor('#6E6661')
          }
          .alignItems(HorizontalAlign.Center)
          Blank()
          Column()
            .width(48)
            .height(48)
            .backgroundColor('#FCE4D1')
            .borderRadius(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 10, bottom: 10 })

        // Scrollable content using List
        List({ space: 30 }) {
          // Quiz Card Section
          ListItem() {
            Column({ space: 0 }) {
              // Card Header: Title + Progress
              Row({ space: 0 }) {
                Text('Citrus crafts')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#291E17')
                Blank()
                Text('45%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .foregroundColor('#FCD462')
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })

              // Progress bar
              Row({ space: 4 }) {
                // Filled portion (45%)
                Column()
                  .width('45%')
                  .height(5)
                  .backgroundColor('#FF9642')
                  .borderRadius(3)
                // Remaining portion
                Column()
                  .width('55%')
                  .height(5)
                  .backgroundColor('#EBE6F5')
                  .borderRadius(3)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 10, bottom: 12 })

              // Question
              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#291E17')
                .width('100%')
                .padding({ left: 24, right: 24, bottom: 24 })

              // Options
              Column({ space: 12 }) {
                ForEach(this.options, (opt: string) => {
                  this.buildOptionButton(opt)
                })
              }
              .width('100%')
              .padding({ left: 24, right: 24, bottom: 24 })

              // Hint tag
              Text('Hint: Think surface area')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#291E17')
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .backgroundColor('#FCECCF')
                .borderRadius(12)
                .margin({ left: 24, right: 24, bottom: 24 })
            }
            .width('100%')
            .backgroundColor('#FFF3E8')
            .borderRadius(36)
          }

          // Trackers Section
          ListItem() {
            Column({ space: 16 }) {
              Text('Trackers')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#291E17')
                .width('100%')
                .margin({ left: 4 })

              Row({ space: 12 }) {
                this.buildTrackerCard('Current\nstreak', '5 days')
                this.buildTrackerCard('Accuracy', '84%')
                this.buildTrackerCard('Rank', 'Top 12%')
              }
              .width('100%')
            }
            .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildOptionButton(text: string) {
    Row({ space: 0 }) {
      Text(text)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#291E17')
      Blank()
    }
    .width('100%')
    .padding({ left: 18, right: 18, top: 14, bottom: 14 })
    .backgroundColor('#FFE4CC')
    .borderRadius(16)
    .border({ width: 1, color: '#DFAA80', radius: 16 })
  }

  @Builder
  buildTrackerCard(label: string, value: string) {
    Column({ space: 8 }) {
      Text(label)
        .fontSize(13)
        .foregroundColor('#6E6661')
      Blank()
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .foregroundColor('#291E17')
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .padding({ left: 16, right: 16, top: 20, bottom: 20 })
    .height(100)
    .backgroundColor('#FFE4CE')
    .borderRadius(24)
  }
}