@Entry
@Component
struct Index {
  @State primaryBlack: string = '#000000'
  @State tipOfTheDay: string = 'Tip of the day'
  @State fontSize12: number = 12
  @State tipDescription: string = 'Use filtered water for a purer taste profile.'
  @State fontSize16: number = 16
  @State collectionsTitle: string = 'Collections'
  @State fontSize18: number = 18
  @State textGrey: string = '#757575'
  @State teaInitial: string = 'tea.name.take(1)'
  @State fontSize20: number = 20
  @State teaName: string = 'tea.name'
  @State fontSize17: number = 17
  @State teaOrigin: string = 'tea.origin'
  @State badgeLabel: string = 'label'
  @State fontSize11: number = 11
  @State appTitle: string = 'ZenBrew'
  @State fontSize24: number = 24
  @State appSubtitle: string = 'Mindful Steeping Guide'
  @State fontSize14: number = 14
  @State addIconPlaceholder: string = 'Icons.Default.Add'
  @State customBrewText: string = 'Custom Brew'

  build() {
    Stack() {
      // MaterialTheme & Scaffold abstraction
      Stack({ alignContent: Alignment.Top }) {
        // LazyColumn equivalent
        List({ space: 16 }) {
          ListItem() {
            // PromoCard
            Column() {
              Row({ space: 0 }) {
                Column({ space: 0 }) {
                  Text(this.tipOfTheDay)
                    .fontSize(this.fontSize12)
                    .fontColor('#9E9E9E')
                    .fontWeight(FontWeight.Bold)
                    .padding({ bottom: 4 })
                  
                  Text(this.tipDescription)
                    .fontSize(this.fontSize16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.textGrey)
                }.layoutWeight(1)

                Blank().width(16)

                // Surface/Box with Icon
                Column() {
                  Stack({ alignContent: Alignment.Center }) {
                    Image($r('app.media.startIcon'))
                      .width(24)
                      .height(24)
                      .fillColor('#9E9E9E')
                  }
                }
                .width(48)
                .height(48)
                .borderRadius(24)
                .backgroundColor('#FFFFFF')
              }
              .alignItems(VerticalAlign.Center)
              .padding(24)
              .width('100%')
            }
            .width('100%')
            .backgroundColor('#F0F0F0')
            .borderRadius(20)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          }

          ListItem() {
            // Collections Title
            Text(this.collectionsTitle)
              .fontSize(this.fontSize18)
              .fontWeight(FontWeight.Medium)
              .padding({ top: 8, bottom: 8 })
          }

          ListItem() {
            // TeaItemCard
            Column() {
              Row({ space: 0 }) {
                // Box with Initial
                Stack({ alignContent: Alignment.Center }) {
                  Text(this.teaInitial)
                    .fontSize(this.fontSize20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#6750A4') // Assuming tea.colorCode is primary-like
                }
                .width(50)
                .height(50)
                .borderRadius(25)
                .backgroundColor('#FFFFFF')
                .border({ width: 2, color: '#D1C4E9' }) // Approximation of alpha 0.3 on primary

                Blank().width(16)

                Column({ space: 0 }) {
                  Text(this.teaName)
                    .fontSize(this.fontSize17)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000') // titleColor

                  Text(this.teaOrigin)
                    .fontSize(this.fontSize12)
                    .fontColor(this.textGrey) // subtitleColor

                  Blank().height(6)

                  Row({ space: 0 }) {
                    // InfoBadge 1
                    Column() {
                      Text(this.badgeLabel)
                        .fontSize(this.fontSize11)
                        .fontColor('#000000')
                        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    }
                    .backgroundColor('#FFFFFF')
                    .borderRadius(6)
                    .border({ width: 1, color: '#E0E0E0' })

                    Blank().width(8)

                    // InfoBadge 2
                    Column() {
                      Text(this.badgeLabel)
                        .fontSize(this.fontSize11)
                        .fontColor('#000000')
                        .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    }
                    .backgroundColor('#FFFFFF')
                    .borderRadius(6)
                    .border({ width: 1, color: '#E0E0E0' })
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .layoutWeight(1)

                // IconButton (Play)
                Button() {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .fillColor('#000000') // titleColor
                }
                .width(40)
                .height(40)
                .borderRadius(20)
                .backgroundColor('#FFFFFF')
                .border({ width: 1, color: '#E0E0E0' })
                .onClick(() => {
                  // Start Timer
                })
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
              .padding(16)
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#EEEEEE' })
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          }

          ListItem() {
            Column() {
              Blank().height(80)
            }
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })

        // TopAppBar
        Column({ space: 0 }) {
          Row({ space: 0 }) {
            Column({ space: 0 }) {
              Text(this.appTitle)
                .fontSize(this.fontSize24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.primaryBlack)
              
              Text(this.appSubtitle)
                .fontSize(this.fontSize14)
                .fontColor(this.textGrey)
                .fontWeight(FontWeight.Normal)
            }
            
            Blank().layoutWeight(1)

            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor(this.primaryBlack)
            }
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              // Settings
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')

        // FAB (Custom Brew) - Removed from here as it's duplicated below correctly
      }
      .width('100%')
      .height('100%')
      
      // Overlay FAB at bottom right
      Button() {
        Row({ space: 0 }) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#FFFFFF')
          
          Blank().width(8)
          
          Text(this.customBrewText)
            .fontColor('#FFFFFF')
            .fontSize(16)
        }
      }
      .height(56)
      .borderRadius(16)
      .backgroundColor(this.primaryBlack)
      .margin({ right: 20, bottom: 20 })
      .position({ x: 'auto', y: 'auto' })
      .onClick(() => {})
    }
    .width('100%')
    .height('100%')
  }
}