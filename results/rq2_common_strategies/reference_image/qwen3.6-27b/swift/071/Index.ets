// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct Index {
  @State progress: number = 45

  build() {
    Column() {
      // Header
      Row() {
        Circle().width(48).height(48).fill('#FCE4D1')
        Column() {
          Text('QuizForge').font-size(20).font-weight(FontWeight.Bold).font-color('#291E17')
          Text('Aroma sprint').font-size(14).font-color('#6E6661')
        }
        Circle().width(48).height(48).fill('#FCE4D1')
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 10, bottom: 10 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Quiz Card
          Column({ space: 0 }) {
            // Card Header
            Row() {
              Text('Citrus crafts').font-size(18).font-weight(FontWeight.SemiBold).font-color('#291E17')
              Blank()
              Text('45%').font-size(16).font-weight(FontWeight.Bold).font-color('#FCD462')
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 24 })

            // Progress Bar
            Row() {
              // Orange part (45%)
              Capsule()
                .width(`${this.progress}%`)
                .height(5)
                .fill('#FF9642')
              
              // Track part (remaining)
              Stack({ alignContent: Alignment.End }) {
                Capsule()
                  .width(`${100 - this.progress}%`)
                  .height(5)
                  .fill('#EBE6F5')
                
                // Small dot at the end of the track
                Circle()
                  .width(4)
                  .height(4)
                  .fill('#FF9642')
                  .margin({ right: 2 })
              }
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 10, bottom: 12 })

            // Question
            Text('Which zest carrier gives the brightest aroma when infused cold?')
              .font-size(23)
              .font-weight(FontWeight.Bold)
              .font-color('#291E17')
              .line-height(32) // Approximate line spacing
              .padding({ left: 24, right: 24, bottom: 24 })

            // Options
            Column({ space: 12 }) {
              OptionButton(text: 'Dried peel sachet')
              OptionButton(text: 'Twist garnish')
              OptionButton(text: 'Zester microplane')
              OptionButton(text: 'Candied strip')
            }
            .padding({ left: 24, right: 24, bottom: 24 })

            // Hint Tag
            Text('Hint: Think surface area')
              .font-size(14)
              .font-weight(FontWeight.Medium)
              .font-color('#291E17')
              .padding({ left: 16, right: 16, top: 10, bottom: 10 })
              .backgroundColor('#FCECCF')
              .borderRadius(12)
              .alignSelf(ItemAlign.Start)
              .margin({ left: 24, bottom: 24 })

          }
          .width('100%')
          .backgroundColor('#FFF5F0')
          .borderRadius(36)
          .margin({ bottom: 30 })

          // Trackers Section
          Column({ space: 16 }) {
            Text('Trackers')
              .font-size(24)
              .font-weight(FontWeight.Bold)
              .font-color('#291E17')
              .alignSelf(ItemAlign.Start)
              .margin({ left: 4 })

            Row({ space: 12 }) {
              TrackerCard(label: 'Current\nstreak', value: '5 days')
              TrackerCard(label: 'Accuracy', value: '84%')
              TrackerCard(label: 'Rank', value: 'Top 12%')
            }
            .width('100%')
          }
        }
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF9')
    .statusBar({ state: StatusBarState.Hide })
  }
}

@Component
struct OptionButton {
  @Prop text: string

  build() {
    Row() {
      Text(this.text)
        .font-size(10)
        .font-weight(FontWeight.Medium)
        .font-color('#291E17')
      Blank()
    }
    .width('100%')
    .padding({ left: 18, right: 18, top: 14, bottom: 14 })
    .backgroundColor('#FDECD9')
    .borderRadius(16)
    .border({ width: 1, color: '#EBCBA6', radius: 16 })
  }
}

@Component
struct TrackerCard {
  @Prop label: string
  @Prop value: string

  build() {
    Column({ space: 8 }) {
      Text(this.label)
        .font-size(13)
        .font-color('#6E6661')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      Blank()

      Text(this.value)
        .font-size(18)
        .font-weight(FontWeight.Bold)
        .font-color('#291E17')
    }
    .width('100%')
    .height(100)
    .padding({ left: 16, right: 16, top: 20, bottom: 20 })
    .backgroundColor('#FFE4CE')
    .borderRadius(24)
  }
}