@Entry
@Component
struct Index {
  @State title: string = 'Easy Notes'

  build() {
    Column() {
      // Header
      Text(this.title)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1B1F')
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 20, top: 50, bottom: 20 })

      // Search Bar
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#5F6368')
        
        Text('Search')
          .fontSize(16)
          .fontColor('#5F6368')
          .margin({ left: 12 })
        
        Blank()
        
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#5F6368')
      }
      .width('90%')
      .height(48)
      .backgroundColor('#F3E5F5')
      .borderRadius(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 10, bottom: 20 })

      // Scrollable Content
      Scroll() {
        Column() {
          
          // Card 1: Shopping List
          Column() {
            Text('Shopping List')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            
            Column() {
              Text('• Milk').fontSize(18).margin({ top: 12 })
              Text('• Eggs').fontSize(18).margin({ top: 8 })
              Text('• Bread').fontSize(18).margin({ top: 8 })
              Text('• Butter').fontSize(18).margin({ top: 8 })
            }
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#F3E5F5')
          .borderRadius(20)
          .margin({ bottom: 16 })

          // Card 2: Meeting Notes
          Column() {
            Text('Meeting Notes')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            
            Text('Discussed Q3 roadmap and budget.')
              .fontSize(18)
              .fontColor('#000000')
              .margin({ top: 12 })
              .lineHeight(26)
            
            Column() {
              Text('1. Draft proposal').fontSize(18).margin({ top: 16 })
              Text('2. Review with team').fontSize(18).margin({ top: 8 })
            }
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#F3E5F5')
          .borderRadius(20)
          .margin({ bottom: 16 })

          // Card 3: Ideas
          Column() {
            Text('Ideas')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            
            Text('The best way to predict the future is to invent it.')
              .fontSize(18)
              .fontColor('#000000')
              .margin({ top: 12 })
              .lineHeight(26)
              .padding({ left: 16 })
              .border({ width: 4, color: '#E0E0E0', style: BorderStyle.Solid })
            
            Text('— Alan Kay')
              .fontSize(18)
              .fontColor('#000000')
              .margin({ top: 16 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#F3E5F5')
          .borderRadius(20)
          .margin({ bottom: 40 })
        }
        .width('90%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .padding({ left: 20, right: 20 })
  }
}