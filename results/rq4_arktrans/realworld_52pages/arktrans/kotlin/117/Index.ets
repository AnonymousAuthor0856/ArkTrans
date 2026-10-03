@Entry
@Component
struct Index {
  @State title: string = 'Easy Notes'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === MaterialTheme (Simulated with Column) ===
      Column() {
        // === CenterAlignedTopAppBar ===
        Row() {
          Text(this.title)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1C1B1F')
            .margin({ left: 16, top: 40, bottom: 16 })
          
          Blank()
          
          // NavigationIcon placeholder (Back arrow usually, but screenshot shows none or hidden)
          Image($r('app.media.startIcon')) 
            .width(24).height(24)
            .visibility(Visibility.None) // Hidden based on screenshot
        }
        .width('100%')
        .height(72)
        .backgroundColor('#F3F4F6')

        // === Box (Padding container) ===
        Column() {
          // === LazyColumn (List) ===
          List({ space: 28 }) {
            
            // === SupportBox ===
            ListItem() {
              Row() {
                Column() {
                  Text('Support')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                  
                  Text('Show your love')
                    .fontSize(16)
                    .fontColor('#E0E0E0')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                
                Blank()
                
                Row() {
                   // Simulating the chevron icon using the available resource since specific icons aren't allowed
                   Image($r('app.media.startIcon'))
                     .width(24)
                     .height(24)
                     .fillColor('#FFFFFF')
                     .rotate({ angle: 90 }) // Rotate to look like a chevron if startIcon is an arrow
                }
                .width(48)
                .height(48)
                .borderRadius(24)
                .backgroundColor('#FFFFFF')
                .justifyContent(FlexAlign.Center)
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 20, bottom: 20 })
              .borderRadius(32)
              .linearGradient({
                direction: GradientDirection.Right,
                colors: [['#5E35B1', 0], ['#7E57C2', 0.5], ['#8D6E63', 1]]
              })
            }

            // === SectionBlock 1 ===
            ListItem() {
              Column() {
                this.SettingItem('Colors & Styles', 'Themes • Size • Font', 'palette')
                Divider().color('#EEEEEE').margin({ top: 16, bottom: 16 })
                this.SettingItem('Behavior', 'Support • Images', 'text')
                Divider().color('#EEEEEE').margin({ top: 16, bottom: 16 })
                this.SettingItem('Language', 'Font • Language', 'globe')
              }
              .width('100%')
              .padding({ left: 16, right: 16 })
              .borderRadius(16)
              .backgroundColor('#FDFBFE') // Very light purple tint
            }

            // === SectionBlock 2 ===
            ListItem() {
              Column() {
                this.SettingItem('Backup', 'NextCloud • Local • Encryption', 'cloud')
                Divider().color('#EEEEEE').margin({ top: 16, bottom: 16 })
                this.SettingItem('Privacy', 'Screen Protection', 'lock')
                Divider().color('#EEEEEE').margin({ top: 16, bottom: 16 })
                this.SettingItem('Tools', '', 'tools')
              }
              .width('100%')
              .padding({ left: 16, right: 16 })
              .borderRadius(16)
              .backgroundColor('#FDFBFE')
            }

             // === SectionBlock 3 ===
             ListItem() {
              Column() {
                this.SettingItem('About', 'Version 1.0.0', 'info')
              }
              .width('100%')
              .padding({ left: 16, right: 16 })
              .borderRadius(16)
              .backgroundColor('#FDFBFE')
            }

          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .backgroundColor('#F3F4F6')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SettingItem(title: string, desc: string, type: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')
        
        Text(desc)
          .fontSize(14)
          .fontColor('#757575')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      // Icon Container
      Row() {
        // Using the single allowed image resource for all icons as per rules
        // We use color and simple shapes to differentiate visually where possible
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .fillColor('#FFFFFF')
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#6750A4') // Primary Purple
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}