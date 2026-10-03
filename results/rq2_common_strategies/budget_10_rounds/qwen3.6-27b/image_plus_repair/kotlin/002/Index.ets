@Entry
@Component
struct BasicFormExample {
  @State username: string = ''
  @State password: string = ''

  build() {
    Column() {
      Text('Generic Login Form')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 20 })

      TextInput({ placeholder: 'Enter username' })
        .type(InputType.TEXT)
        .width('90%')
        .onChange((value: string) => {
          this.username = value
        })
        .margin({ bottom: 10 })

      TextInput({ placeholder: 'Enter password' })
        .type(InputType.PASSWORD)
        .width('90%')
        .onChange((value: string) => {
          this.password = value
        })
        .margin({ bottom: 20 })

      Button('Submit')
        .width('50%')
        .onClick(() => {
          // Handle submission logic here securely
          console.info('Username: ' + this.username)
          console.info('Password: ' + this.password)
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}