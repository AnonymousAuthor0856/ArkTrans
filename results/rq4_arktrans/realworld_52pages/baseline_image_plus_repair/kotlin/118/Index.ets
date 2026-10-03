@Entry
@Component
struct TermsScreen {
  @State termsContent: string = `1. Acceptance of Terms

By pressing Agree and using Easy Notes, you accept these Terms of Service. If you do not agree, do not use the application.

2. License

Easy Notes is distributed under the GNU General Public License (GPL) version 3. This means:

• You are free to use, modify, and share the application.
• If you distribute the application or any modified versions, you must also distribute the source code and retain the GPL license.

3. Use of the Application

You agree to use Easy Notes only for lawful purposes and in accordance with these Terms. You must not:

• _Use the app for any unlawful purpose_
• _Violate the rights of others_
• _Disrupt the functionality or security of the app_`

  build() {
    Column() {
      Text("Terms of service")
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16, bottom: 16 })

      Scroll() {
        Column() {
          Text(this.termsContent)
            .fontSize(14)
            .lineHeight(20)
            .padding(16)
            .backgroundColor('#F5F0FA')
            .borderRadius(32)
        }
      }
      .layoutWeight(1)

      Button("Agree", { type: ButtonType.Capsule })
        .width('80%')
        .height(56)
        .backgroundColor('#E9D5FF')
        .fontColor('#4C1D95')
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 24 })
        .onClick(() => {
          // Handle agreement action
        })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }
}