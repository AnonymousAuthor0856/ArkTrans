@Entry
@Component
struct Index {
  @State categoryName: string = ''
  @State showingAlert: boolean = false

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header Row
        Row() {
          Text('Change Note Category')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .layoutWeight(1)
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.White)
          }
          .backgroundColor('#999999')
          .borderRadius(20)
          .width(40)
          .height(40)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 60, bottom: 20 })

        // List Item "General"
        Row() {
          Text('General')
            .fontSize(20)
            .fontColor('#000000')
            .layoutWeight(1)
          
          Circle()
            .width(24)
            .height(24)
            .borderWidth(2)
            .borderColor('#8D7B68')
            .margin({ right: 10 })
        }
        .width('85%')
        .height(60)
        .backgroundColor('#EAE0D5')
        .borderRadius(20)
        .padding({ left: 20, right: 10 })
        .alignItems(VerticalAlign.Center)
        .shadow({ radius: 10, color: '#1A000000', offsetY: 4 })
        .margin({ top: 10, left: 24 })

        Blank()

        // Bottom Action Button
        Button() {
          Text('Create and assign new category')
            .fontSize(18)
            .fontColor('#000000')
        }
        .width('85%')
        .height(56)
        .backgroundColor('#F2F2F2')
        .borderRadius(28)
        .shadow({ radius: 12, color: '#33000000', offsetY: 4 })
        .margin({ bottom: 40 })
        .onClick(() => {
          this.showingAlert = true
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      
      // Alert Dialog Simulation
      if (this.showingAlert) {
        Column() {
          Column() {
            Text('Create a new category')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .textAlign(TextAlign.Center)
              .width('100%')
              .margin({ bottom: 12 })

            Text('Your category will be created and assigned to your note.\nYou can further personalize it by tapping the Category Selection button in your Dock.')
              .fontSize(14)
              .fontColor('#666666')
              .textAlign(TextAlign.Center)
              .width('100%')
              .margin({ bottom: 20 })

            TextInput({ placeholder: 'Enter your category name' })
              .type(InputType.Normal)
              .width('100%')
              .height(44)
              .backgroundColor('#F5F5F5')
              .borderRadius(8)
              .margin({ bottom: 20 })

            Row() {
              Button('Cancel')
                .fontSize(16)
                .fontColor('#FF3B30')
                .backgroundColor(Color.Transparent)
                .layoutWeight(1)
                .onClick(() => {
                  this.showingAlert = false
                })

              Divider().vertical(true).color('#E0E0E0').height(30)

              Button('Save and Assign')
                .fontSize(16)
                .fontColor('#007AFF')
                .backgroundColor(Color.Transparent)
                .layoutWeight(1)
                .onClick(() => {
                  this.showingAlert = false
                })
            }
            .width('100%')
          }
          .width('85%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 20, color: '#4D000000' })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#80000000')
        .onClick(() => {
           // Close on background tap logic would go here
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}