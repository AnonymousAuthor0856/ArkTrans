import { AlertDialog, CustomDialogController } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State Next: string = '0'
  @State Cancel: string = '0'
  @State SetTime: string = '0'
  @State Set: string = '0'

  build() {
    Stack() {
      Stack({ alignContent: Alignment.Center }) {
        // === AlertDialog ===
        // Using CustomDialogController to properly display the dialog with custom content
        Button('Show Dialog')
          .onClick(() => {
            let dialogController = new CustomDialogController({
              builder: MyAlertDialog(),
              alignment: DialogAlignment.Center,
              offset: { dx: 0, dy: 0 },
              autoCancel: true
            })
            dialogController.open()
          })
      }
    }.width('100%').height('100%')
  }
}

@Component
struct MyAlertDialog {
  build() {
    Column() {
      Text('Set time')
        .fontColor('#191D19')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 10 })
      
      TimePicker({ start: new Date(2024, 0, 1), end: new Date(2030, 11, 31) })
        .margin({ bottom: 20 })

      Row() {
        Button('Cancel')
          .backgroundColor(Color.Gray)
          .margin({ right: 10 })
          .onClick(() => {
            // Close dialog logic would go here if we had access to controller context
            // For simplicity in this component structure, we rely on autoCancel or external control
          })
        
        Button('Set')
          .backgroundColor(Color.Blue)
          .onClick(() => {
            // Set action
          })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .margin({ top: 10 })
    }
    .width('80%')
    .padding(20)
    .borderRadius(10)
    .backgroundColor(Color.White)
  }
}