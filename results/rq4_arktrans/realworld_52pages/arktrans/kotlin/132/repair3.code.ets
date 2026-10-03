@Entry
@Component
struct Index {
  @State title: string = 'Buy groceries'
  @State description: string = 'Milk, eggs, bread, and vegetables for the week'

  build() {
    Column() {
      // === TopAppBar ===
      Row() {
        // Back Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .margin({ right: 16 })

        // Title
        Text('Update ToDo')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .layoutWeight(1)

        // Save Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .margin({ right: 16 })

        // Delete Icon
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#6750A4')
      .alignItems(VerticalAlign.Center)

      // === Form Content ===
      Column() {
        // Title Input Field
        TextInput({ placeholder: '' })
          .placeholder('Title')
          .text(this.title)
          .type(InputType.Normal)
          .width('100%')
          .height(80)
          .borderRadius(6)
          .borderWidth(1.5)
          .borderColor('#757575')
          .backgroundColor('#FFFFFF')
          .margin({ top: 24, bottom: 16 })
          .padding({ left: 16, top: 24 })
          .fontSize(20)
          .fontColor('#191D19')

        // Priority Dropdown (Simulated as Button)
        Button('High Priority')
          .width('100%')
          .height(60)
          .backgroundColor('#FFFFFF')
          .borderRadius(6)
          .borderWidth(1.5)
          .borderColor('#757575')
          .margin({ bottom: 16 })
          .fontColor('#191D19')
          .fontSize(20)
          .fontWeight(FontWeight.Normal)
          .textAlign(TextAlign.Start)
          .padding({ left: 16 })

        // Description Input Field
        TextInput({ placeholder: '' })
          .placeholder('Description')
          .text(this.description)
          .type(InputType.Normal)
          .width('100%')
          .height(300)
          .borderRadius(6)
          .borderWidth(1.5)
          .borderColor('#757575')
          .backgroundColor('#FFFFFF')
          .margin({ bottom: 24 })
          .padding({ left: 16, top: 24 })
          .fontSize(20)
          .fontColor('#191D19')
          .multiline(true)
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
      .layoutWeight(1)
      .backgroundColor('#FDFBFE')
    }
    .width('100%')
    .height('100%')
  }
}