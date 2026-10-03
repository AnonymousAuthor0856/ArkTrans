@Entry
@Component
struct Index {
  @State showLanguagePicker: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content ===
      Column() {
        // === LargeTopAppBar ===
        Row() {
          Text('←').fontSize(24).fontColor('#1C1B1F')
          Blank()
          Text('About').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
        }.width('100%').height(80).padding({ left: 16, right: 16 }).alignItems(VerticalAlign.Center)

        // === LazyColumn ===
        List({ space: 16 }) {
          // === GroupedListItem (Grit Plus) ===
          ListItem() {
            Column() {
              // Top Section
              Row() {
                // Icon
                Column() {
                  Text('🛡').fontSize(32)
                }.width(56).height(56).borderRadius(16).backgroundColor('#E8DEF8').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

                // Texts
                Column() {
                  Text('Grit').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
                  Text('1.3.0').fontSize(16).fontColor('#7950F2')
                }.alignItems(HorizontalAlign.Start)

                Blank()

                // Trailing Icons
                Row({ space: 8 }) {
                  Column() {
                    Text('💬').fontSize(20)
                  }.width(40).height(40).borderRadius(20).backgroundColor('#E8DEF8').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
                  
                  Column() {
                    Text('🐙').fontSize(20)
                  }.width(40).height(40).borderRadius(20).backgroundColor('#E8DEF8').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
                }
              }.width('100%').padding(16)

              Divider().color('#E6E1E5')

              // Bottom Section (Developer Info)
              Column({ space: 16 }) {
                Row() {
                  // Icon
                  Column() {
                    Text('👨‍💻').fontSize(32)
                  }.width(56).height(56).borderRadius(16).backgroundColor('#FFD8E4').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

                  // Texts
                  Column() {
                    Text('Shubham Gorai').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
                    Text('Developer').fontSize(16).fontColor('#49454F')
                  }.alignItems(HorizontalAlign.Start)
                }.width('100%').padding({ left: 16, top: 16 })

                // Action Buttons
                Row({ space: 16 }) {
                  Column() {
                    Text('🐙').fontSize(20)
                    Text('GitHub').fontSize(12).margin({ top: 4 })
                  }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

                  Column() {
                    Text('🌍').fontSize(20)
                    Text('Website').fontSize(12).margin({ top: 4 })
                  }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)

                  Column() {
                    Text('✉️').fontSize(20)
                    Text('Email').fontSize(12).margin({ top: 4 })
                  }.justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
                }.padding({ bottom: 16 })
              }
            }.width('100%').borderRadius(28).backgroundColor('#E6E1E5')
          }

          // === Buy Me a Coffee ===
          ListItem() {
            Row() {
              Column() {
                Text('☕').fontSize(24)
              }.width(48).height(48).borderRadius(24).backgroundColor('#E6E1E5').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
              
              Column({ space: 4 }) {
                Text('Buy Me a Coffee').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#1C1B1F')
                Text('Support the developer').fontSize(14).fontColor('#49454F')
              }.alignItems(HorizontalAlign.Start)
              
              Blank()
              Text('↗').fontSize(20).fontColor('#49454F')
            }.width('100%').padding(16).alignItems(VerticalAlign.Center)
          }

          // === Help Translate ===
          ListItem() {
            Row() {
              Column() {
                Text('🌐').fontSize(24)
              }.width(48).height(48).borderRadius(24).backgroundColor('#E6E1E5').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
              
              Column({ space: 4 }) {
                Text('Help Translate').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#1C1B1F')
                Text('Contribute translations on Weblate').fontSize(14).fontColor('#49454F')
              }.alignItems(HorizontalAlign.Start)
              
              Blank()
              Text('↗').fontSize(20).fontColor('#49454F')
            }.width('100%').padding(16).alignItems(VerticalAlign.Center)
          }

          // === License ===
          ListItem() {
            Row() {
              Column() {
                Text('📜').fontSize(24)
              }.width(48).height(48).borderRadius(24).backgroundColor('#E6E1E5').justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
              
              Column({ space: 4 }) {
                Text('License').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#1C1B1F')
                Text('GPL-3.0 License').fontSize(14).fontColor('#49454F')
              }.alignItems(HorizontalAlign.Start)
            }.width('100%').padding(16).alignItems(VerticalAlign.Center)
          }
        }.layoutWeight(1).padding({ left: 16, right: 16 })
      }.width('100%').height('100%').backgroundColor('#FCF2FF')

      // === LanguagePickerSheet (ModalBottomSheet) ===
      if (this.showLanguagePicker) {
        Stack() {
          // Backdrop
          Column().width('100%').height('100%').backgroundColor('#000000').opacity(0.5)
            .onClick(() => { this.showLanguagePicker = false })
          
          // Sheet
          Column() {
            Text('Select Language').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1C1B1F')
              .width('100%').textAlign(TextAlign.Center).padding({ top: 16, bottom: 16 })
            
            Divider().color('#E6E1E5')
            
            List() {
              ForEach(['English', 'Spanish', 'French'], (item: string) => {
                ListItem() {
                  Text(item).fontSize(16).fontColor('#1C1B1F')
                    .width('100%').padding(20)
                    .onClick(() => { this.showLanguagePicker = false })
                }
              })
            }
          }.width('100%').height('50%').backgroundColor('#FFFFFF').borderRadius({ topLeft: 16, topRight: 16 })
            .position({ x: 0, y: '50%' })
        }.width('100%').height('100%')
      }
    }.width('100%').height('100%')
  }
}