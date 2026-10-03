@Entry
@Component
struct AboutPage {
  @State versionName: string = '1.3.0'

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('', { type: ButtonType.Circle })
          .width(48)
          .height(48)
          .backgroundColor('#EADDFF')
          .margin({ right: 16 })
          .onClick(() => {
            // Back action
          })
          .borderRadius(24)
        
        Text('About')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1C1B1F')
          .layoutWeight(1)
          .alignSelf(ItemAlign.Center)
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })

      Scroll() {
        Column() {
          // App Info Card
          Column() {
            // Grit Section
            Row() {
              // Icon
              Column() {
                Text('🛡️')
                  .fontSize(32)
              }
              .width(72)
              .height(72)
              .backgroundColor('#EADDFF')
              .borderRadius(16)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)

              Blank().width(16)

              // Text Info
              Column() {
                Text('Grit')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#1C1B1F')
                
                Text(this.versionName)
                  .fontSize(20)
                  .fontColor('#6750A4')
                  .margin({ top: 4 })
              }
              .layoutWeight(1)

              // Action Buttons
              Row() {
                Button('', { type: ButtonType.Circle })
                  .width(48)
                  .height(48)
                  .backgroundColor('#EADDFF')
                  .margin({ right: 8 })
                  .borderRadius(24)
                  .onClick(() => {})
                
                Button('', { type: ButtonType.Circle })
                  .width(48)
                  .height(48)
                  .backgroundColor('#EADDFF')
                  .borderRadius(24)
                  .onClick(() => {})
              }
            }
            .width('100%')
            .padding(16)

            Divider()
              .color('#E6E1E5')
              .margin({ left: 16, right: 16 })

            // Developer Section
            Column() {
              Row() {
                // Icon
                Column() {
                  Text('👨‍💻')
                    .fontSize(32)
                }
                .width(72)
                .height(72)
                .backgroundColor('#FFD8E4')
                .borderRadius(16)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)

                Blank().width(16)

                // Text Info
                Column() {
                  Text('Shubham Gorai')
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#1C1B1F')
                  
                  Text('Developer')
                    .fontSize(16)
                    .fontColor('#904B59')
                    .margin({ top: 4 })
                }
                .layoutWeight(1)
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 16 })

              // Social Links
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
                this.SocialButton('🐙', 'GitHub')
                this.SocialButton('🌍', 'Website')
                this.SocialButton('✉️', 'Email')
              }
              .padding({ left: 16, right: 16, bottom: 16 })
            }
          }
          .backgroundColor('#F3EDF7')
          .borderRadius(28)
          .margin({ top: 16, bottom: 16 })

          // List Items
          this.ListItem('☕', 'Buy Me a Coffee', 'Support the developer')
          this.ListItem('🌐', 'Help Translate', 'Contribute translations on Weblate')
          
          // Spacing before last item
          Blank().height(16)
          
          this.ListItem('📜', 'License', 'GPL-3.0 License')
        }
        .padding({ left: 16, right: 16, bottom: 40 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FEF7FF')
  }

  @Builder
  ListItem(icon: string, title: string, subtitle: string) {
    Row() {
      // Icon Container
      Column() {
        Text(icon)
          .fontSize(24)
      }
      .width(56)
      .height(56)
      .backgroundColor('#E6E1E5')
      .borderRadius(28)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      Blank().width(16)

      // Text Content
      Column() {
        Text(title)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
        
        Text(subtitle)
          .fontSize(16)
          .fontColor('#49454F')
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      // Arrow Icon
      Text('↗')
        .fontSize(20)
        .fontColor('#49454F')
    }
    .width('100%')
    .padding(8)
    .onClick(() => {})
  }

  @Builder
  SocialButton(icon: string, label: string) {
    Column() {
      Text(icon)
        .fontSize(20)
      
      Text(label)
        .fontSize(12)
        .fontColor('#1C1B1F')
        .margin({ top: 4 })
    }
    .width(80)
    .height(80)
    .backgroundColor('#EADDFF')
    .borderRadius(40)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .margin({ right: 8, bottom: 8 })
    .onClick(() => {})
  }
}