@Entry
@Component
struct TaskDashboard {

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Header
        Row() {
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }
            .type(ButtonType.Normal)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .width(48)
            .height(48)
            .margin({ top: 48, left: 24 })

          Blank()

          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }
            .type(ButtonType.Normal)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .width(48)
            .height(48)
            .margin({ right: 24 })
        }.width('100%')

        // Welcome Section
        Column() {
          Text('Hello, Alex')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          
          Text('You have 5 incomplete tasks today.')
            .fontSize(16)
            .fontColor('#9E9E9E')
            .margin({ top: 8 })
        }
        .margin({ top: 16, bottom: 32 })

        // Category Selector
        Row({ space: 12 }) {
          Button('All')
            .backgroundColor('#212121')
            .fontColor('#FFFFFF')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .fontWeight(FontWeight.Medium)
        
          Button('Work')
            .backgroundColor('#F5F5F5')
            .fontColor('#000000')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .fontWeight(FontWeight.Medium)

          Button('Personal')
            .backgroundColor('#F5F5F5')
            .fontColor('#000000')
            .borderRadius(50)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .fontWeight(FontWeight.Medium)
        }
        .margin({ bottom: 24 })

        // Recent Tasks List
        Column() {
          Text('Recent Tasks')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#121212')
            .margin({ bottom: 16 })

          Column({ space: 16 }) {
            // Item 1: Team Meeting (Checked)
            Column() {
              Row() {
                // Icon Box
                Column() {
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                }
                .width(48)
                .height(48)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor('#FFFFFF')
                .borderRadius(14)

                Column({ space: 4 }) {
                  Text('Team Meeting')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#9E9E9E') // Gray because checked
                
                  Row({ space: 8 }) {
                    Text('10:00 AM - 11:30 AM')
                      .fontSize(12)
                      .fontColor('#9E9E9E')
                    
                    Text('Work')
                      .fontSize(10)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#1565C0')
                      .backgroundColor('#E3F2FD')
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      .borderRadius(4)
                  }
                }
                .layoutWeight(1)
                .margin({ left: 16 })

                // Checkbox (Checked)
                Column() {
                  Image($r('app.media.startIcon')) // Using placeholder for checkmark
                    .width(16)
                    .height(16)
                }
                .width(24)
                .height(24)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor('#212121')
                .borderRadius(4)
              }
              .width('100%')
              .padding(20)
            }
            .width('100%')
            .backgroundColor('#FAFAFA')
            .borderRadius(20)

            // Item 2: Design Review (Unchecked)
            Column() {
              Row() {
                // Icon Box
                Column() {
                  Image($r('app.media.startIcon'))
                    .width(24)
                    .height(24)
                }
                .width(48)
                .height(48)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor('#FFFFFF')
                .borderRadius(14)

                Column({ space: 4 }) {
                  Text('Design Review')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                
                  Row({ space: 8 }) {
                    Text('02:00 PM - 03:00 PM')
                      .fontSize(12)
                      .fontColor('#9E9E9E')
                    
                    Text('Design')
                      .fontSize(10)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#7B1FA2')
                      .backgroundColor('#F3E5F5')
                      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                      .borderRadius(4)
                  }
                }
                .layoutWeight(1)
                .margin({ left: 16 })

                // Checkbox (Unchecked)
                Column() {
                  // Empty box for unchecked state
                }
                .width(24)
                .height(24)
                .borderWidth(2)
                .borderColor('#9E9E9E')
                .borderRadius(4)
              }
              .width('100%')
              .padding(20)
            }
            .width('100%')
            .backgroundColor('#FAFAFA')
            .borderRadius(20)
            
            // Spacer to push content up slightly if needed or just end of list
            Blank().height(80)
          }
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // Floating Action Button
      Button() {
        Image($r('app.media.startIcon')) // Placeholder for Add icon
          .width(24)
          .height(24)
      }
      .type(ButtonType.Normal)
      .backgroundColor('#212121')
      .borderRadius(28)
      .width(56)
      .height(56)
      .margin(24)
      .shadow({ radius: 6, color: '#3F000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}