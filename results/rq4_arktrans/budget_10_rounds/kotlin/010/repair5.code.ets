@Entry
@Component
struct Index {
  @State syncProgress: number = 0.3
  @State opacityValue: number = 1.0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 16 }) {
        // === Card (Preview) ===
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text('Your Story Preview')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height('100%')
        }
        .backgroundColor('#757575')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')
        .layoutWeight(1)
        .padding(16)

        // === Upload Status Section ===
        Column({ space: 8 }) {
          Text('Upload Status')
            .fontSize(14)
            .fontColor('#607D8B')
          
          Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color('#4CAF50')
            .trackColor('#CFD8DC')
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        // === LazyRow (Layer Selection) ===
        List({ space: 12 }) {
          ListItem() {
            Column({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Placeholder for icon/image
              }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#CFD8DC')
              
              Text('BG')
                .fontSize(14)
                .fontColor('#9E9E9E')
              
              Text('Gradient')
                .fontSize(16)
                .fontColor('#212121')
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .width(100)
            .height(100)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#CFD8DC' })
          .shadow({ radius: 4, color: '#1A000000' })

          ListItem() {
            Column({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Placeholder for icon/image
              }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#CFD8DC')
              
              Text('IMG')
                .fontSize(14)
                .fontColor('#9E9E9E')
              
              Text('User Photo')
                .fontSize(16)
                .fontColor('#212121')
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .width(100)
            .height(100)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#CFD8DC' })
          .shadow({ radius: 4, color: '#1A000000' })
          
          // Simulating the selected state card based on screenshot visual
          ListItem() {
             Column({ space: 8 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Placeholder for icon/image
              }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#E3F2FD') // Light blue tint for selected
              
              Text('TXT')
                .fontSize(14)
                .fontColor('#FFFFFF')
              
              Text('Hello')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .width(100)
            .height(100)
          }
          .backgroundColor('#1976D2') // Primary Blue
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })

        }
        .listDirection(Axis.Horizontal)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
      .padding({ top: 16, bottom: 16 }) // General padding for content area

      // === Top App Bar ===
      Row() {
        Button() {
          Text('Exit')
            .fontColor('#263238')
            .fontSize(16)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .margin({ right: 'auto' })
        .padding({ left: 8, right: 8 })

        Text('Story Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button() {
          Text('Post')
            .fontColor('#FFFFFF')
            .fontSize(16)
        }
        .type(ButtonType.Capsule)
        .backgroundColor('#1976D2')
        .margin({ left: 'auto' })
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .borderRadius(8)
      }
      .width('100%')
      .height(56)
      .backgroundColor('#ECEFF1')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16 })

      // === Bottom Sheet / Surface ===
      Column() {
        Column({ space: 0 }) {
          Text('Layer Properties')
            .fontSize(14)
            .fontColor('#607D8B')
          
          Blank().height(12)
          
          Row({ space: 0 }) {
            Text('Opacity')
              .fontSize(16)
              .fontColor('#212121')
              .width(80)
            
            Slider({ value: this.opacityValue, min: 0, max: 1, step: 0.01 })
              .width('100%')
              .layoutWeight(1)
              .selectedColor('#1976D2')
              .trackColor('#CFD8DC')
          }
          .alignItems(VerticalAlign.Center)
        }
        .padding(16)
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .width('100%')
      
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ECEFF1')
  }
}