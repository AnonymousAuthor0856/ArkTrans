@Entry
@Component
struct Index {
  @State agreeText: string = 'Agree'
  @State termsTitle: string = 'Terms of service'

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Header Title
        Text(this.termsTitle)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 24, top: 60, bottom: 24 })

        // Scrollable Content Area
        Scroll() {
          Column({ space: 32 }) {
            // Section 1
            Column({ space: 12 }) {
              Text('1. Acceptance of Terms')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')
              
              Text('By pressing Agree and using Easy Notes, you accept these Terms of Service. If you do not agree, do not use the application.')
                .fontSize(16)
                .lineHeight(24)
                .fontColor('#49454F')
            }

            // Section 2
            Column({ space: 12 }) {
              Text('2. License')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')

              Text('Easy Notes is distributed under the GNU General Public License (GPL) version 3. This means:')
                .fontSize(16)
                .lineHeight(24)
                .fontColor('#49454F')
                .fontWeight(FontWeight.Normal)
                .margin({ bottom: 8 })

              Column({ space: 12 }) {
                Text('• You are free to use, modify, and share the application.')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#49454F')
                
                Text('• If you distribute the application or any modified versions, you must also distribute the source code and retain the GPL license.')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#49454F')
              }
            }

            // Section 3
            Column({ space: 12 }) {
              Text('3. Use of the Application')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')

              Text('You agree to use Easy Notes only for lawful purposes and in accordance with these Terms. You must not:')
                .fontSize(16)
                .lineHeight(24)
                .fontColor('#49454F')
                .margin({ bottom: 8 })

              Column({ space: 12 }) {
                Text('• _Use the app for any unlawful purpose_')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#49454F')
                
                Text('• _Violate the rights of others_')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#49454F')

                Text('• _Disrupt the functionality or security..._')
                  .fontSize(16)
                  .lineHeight(24)
                  .fontColor('#49454F')
              }
            }
            
            // Spacer for scrolling past the button
            Blank().height(100)
          }
        }.layoutWeight(1).width('100%')
        
        // Background Container for text area
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7F2FA') // Light purple background matching screenshot
      .clip(true)

      // Floating Action Button
      Row({ space: 12 }) {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#36015F') // Dark purple icon color
        
        Text(this.agreeText)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#36015F')
      }
      .width(160)
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .borderRadius(32)
      .backgroundColor('#EADDFF') // Light purple button bg
      .shadow({ radius: 24, color: '#26000000', offsetY: 8 })
      .margin({ right: 24, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F2FA')
  }
}