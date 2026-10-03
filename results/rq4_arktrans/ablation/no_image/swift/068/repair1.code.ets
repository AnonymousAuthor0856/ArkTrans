@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Column() {
          // Header Section
          Stack({ alignContent: Alignment.Center }) {
            Row({ space: 12 }) {
              Circle()
                .width(24)
                .height(24)
                .fill('#1A0F2C')

              Blank()

              Column() {
                Text('MacroTrainer')
                  .fontColor('#F8F4FF')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                
                Text('Neon workout stack')
                  .fontColor('#F8F4FF')
                  .opacity(0.7)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
              }

              Blank()

              Circle()
                .width(24)
                .height(24)
                .fill('#1A0F2C')
            }
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .onTapGesture({})
          }.height(60)

          // Scrollable Content
          Scroll() {
            Column() {
              TimerSection()
              SetsListSection()
            }
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .alignItems(HorizontalAlign.Start)
          }
          .layoutWeight(1)

          // Footer Section
          Stack({ alignContent: Alignment.Center }) {
            Row({ space: 12 }) {
              Column() {
                Text('Next macro')
                  .fontColor('#F8F4FF')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                
                Text('Bulking')
                  .fontColor('#F8F4FF')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
              }

              Blank()

              Button('Prime')
                .borderRadius(18)
                .fontColor('#05030A')
                .backgroundColor('#08D6FF')
                .padding({ left: 16, right: 16, top: 2, bottom: 2 })
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          }.height(80)
        }
      }
    }.width('100%').height('100%')
  }
}

// Placeholder components to ensure compilation as per "Implement every child" rule
@Component
struct TimerSection {
  build() {
    Column() {
      Text('Timer Section')
        .fontColor('#F8F4FF')
        .margin({ top: 16, bottom: 16 })
    }
  }
}

@Component
struct SetsListSection {
  build() {
    Column() {
      Text('Sets List Section')
        .fontColor('#F8F4FF')
        .margin({ top: 16, bottom: 16 })
    }
  }
}