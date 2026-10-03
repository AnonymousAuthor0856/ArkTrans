@Entry
@Component
struct Index {
  @State questionCategory: string = 'Citrus crafts'
  @State progressPercent: number = 45
  @State syncProgress: number = 0.45
  @State questionPrompt: string = 'Which zest carrier gives the brightest aroma when infused cold?'
  @State options: string[] = ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip']
  @State hint: string = 'Think surface area'
  @State streaks: StreakData[] = [
    { label: 'Current\nstreak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Top Bar
        Row() {
          Circle().width(48).height(48).fill('#FFE5CC')
          Column() {
            Text('QuizForge').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#311F10')
            Text('Aroma sprint').fontSize(14).fontColor('#795548')
          }.alignItems(HorizontalAlign.Center)
          Circle().width(48).height(48).fill('#FFCCB6')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).padding({ left: 20, right: 20, top: 20, bottom: 10 })

        // Main Content Scrollable Area
        Column({ space: 24 }) {
          // Question Card
          Column() {
            Column({ space: 16 }) {
              // Header Row
              Row() {
                Text(this.questionCategory).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#311F10')
                Blank()
                Text(`${this.progressPercent}%`).fontSize(16).fontColor('#FFC857')
              }.width('100%')

              // Progress Bar
              Row() {
                Row() {
                  Divider().width(`${this.syncProgress * 100}%`).height(6).backgroundColor('#FF8A2A').borderRadius(3)
                }.layoutWeight(1).backgroundColor('#EADDFF').borderRadius(3)
              }.width('100%')

              // Prompt
              Text(this.questionPrompt).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#311F10').lineHeight(32)

              // Options List
              Column({ space: 12 }) {
                ForEach(this.options, (item: string) => {
                  Row() {
                    Text(item)
                      .fontSize(18)
                      .fontColor('#311F10')
                      .textAlign(TextAlign.Start)
                  }
                  .width('100%')
                  .height(56)
                  .backgroundColor('#FFE5CC')
                  .borderRadius(24)
                  .border({ width: 1, color: '#DCA882' })
                  .padding({ left: 20, right: 20 })
                  .alignItems(VerticalAlign.Center)
                }, (item: string) => item)
              }

              // Hint Box
              Text(`Hint: ${this.hint}`)
                .fontSize(14)
                .fontColor('#311F10')
                .width('auto')
                .backgroundColor('#FFF0D4')
                .borderRadius(12)
                .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            }.padding(20)
          }
          .width('100%')
          .backgroundColor('#FFF9F2')
          .borderRadius(24)
          .shadow({ radius: 10, color: '#00000010', offsetY: 4 })

          // Trackers Section
          Column({ space: 16 }) {
            Text('Trackers').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#311F10')
            
            Row({ space: 12 }) {
              ForEach(this.streaks, (streak: StreakData) => {
                Column() {
                  Text(streak.label)
                    .fontSize(14)
                    .fontColor('#795548')
                    .textAlign(TextAlign.Center)
                    .maxLines(2)
                  
                  Text(streak.value)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#311F10')
                }
                .width('33%')
                .height(100)
                .backgroundColor('#FFE5CC')
                .borderRadius(20)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
              }, (streak: StreakData) => streak.label + streak.value)
            }.width('100%')
          }
        }
        .width('100%')
        .padding({ left: 20, right: 20, bottom: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF9F2')
    }
    .width('100%')
    .height('100%')
  }
}

interface StreakData {
  label: string
  value: string
}