@Entry
@Component
struct Index {
  @State selectedIndex: number = 0

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          .alignItems(VerticalAlign.Center)
          Column({ space: 4 }) {
            .alignItems(HorizontalAlign.Start)
            Text('Tea Master')
              .fontColor('#000000')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
            Text('Perfect brew, every time')
              .fontColor('#999999')
              .fontSize(12)
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon'))
              .width(32)
              .height(32)
              .fillColor('#000000')
          }
        }.width('100%').padding({ left: 24, right: 24, top: 60 })

        Blank().height(32)

        Stack() {
          Circle()
            .fill('#F5F5F5')
            .width(220)
            .height(220)

          Column({ space: 8 }) {
            // Using startIcon as a placeholder for the heart icon based on rules
            Image($r('app.media.startIcon'))
              .width(48)
              .height(48)
              .objectFit(ImageFit.Contain)
              .fillColor('#8C7067')
            
            Text('Sencha')
              .fontColor('#000000')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
          }
        }.width(220).height(220)

        Blank().height(40)

        Row() {
          Column({ space: 4 }) {
            .alignItems(HorizontalAlign.Center)
            Text('TEMP')
              .fontColor('#999999')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Text('70°C')
              .fontColor('#000000')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
          }
          Divider().vertical(true).color('#E0E0E0').margin({ left: 16, right: 16 }).height(40)
          
          Column({ space: 4 }) {
            .alignItems(HorizontalAlign.Center)
            Text('TIME')
              .fontColor('#999999')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Text('1-2 min')
              .fontColor('#000000')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
          }
          Divider().vertical(true).color('#E0E0E0').margin({ left: 16, right: 16 }).height(40)

          Column({ space: 4 }) {
            .alignItems(HorizontalAlign.Center)
            Text('AMOUNT')
              .fontColor('#999999')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Text('250ml')
              .fontColor('#000000')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
          }
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(40)

        Column({ space: 12 }) {
          .alignItems(HorizontalAlign.Start)
          Text('Select Variety')
            .fontColor('#000000')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .padding({ left: 4 })

          Scroll() {
            Row({ space: 12 }) {
              ForEach(['Sencha', 'Earl Grey', 'Oolong'], (item: string, index: number) => {
                Button(item)
                  .backgroundColor(index === this.selectedIndex ? '#000000' : '#FFFFFF')
                  .fontColor(index === this.selectedIndex ? '#FFFFFF' : '#000000')
                  .borderWidth(index === this.selectedIndex ? 0 : 1)
                  .borderColor('#E0E0E0')
                  .borderRadius(24)
                  .height(48)
                  .padding({ left: 24, right: 24 })
                  .onClick(() => {
                    this.selectedIndex = index
                  })
              })
            }.padding({ left: 4, right: 4 })
          }.scrollable(ScrollDirection.Horizontal).width('100%')
        }.padding({ left: 24, right: 24 })

        Blank()

        Button() {
          Row({ space: 8 }) {
            // Using startIcon as a placeholder for play icon based on rules
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor('#FFFFFF')
            Text('START TIMER')
              .fontColor('#FFFFFF')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
          }
        }
        .backgroundColor('#000000')
        .borderRadius(16)
        .height(56)
        .width('100%')
        .margin({ left: 24, right: 24, bottom: 40 })
        
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}