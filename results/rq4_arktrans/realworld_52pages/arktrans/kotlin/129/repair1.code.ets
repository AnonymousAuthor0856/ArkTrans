@Entry
@Component
struct Index {
  @State balanceVisible: boolean = true
  @State currentCardPage: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List() {
        // === HomeTopBar ===
        ListItem() {
          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .opacity(0.5)
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .backgroundColor('#CCCCCC')

            Blank().layoutWeight(1)

            Button() {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .opacity(0.5)
            }
            .backgroundColor(Color.Transparent)

            Button() {
              Text('QR')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#808080')
            }
            .backgroundColor(Color.Transparent)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .padding({ left: 15, right: 15, top: 12, bottom: 12 })
        }

        // === BalanceSection ===
        ListItem() {
          Column() {
            Text('BALANCE')
              .fontSize(16)
              .fontColor('#808080')
            
            Blank().height(4)

            Row() {
              Text(this.balanceVisible ? "KSH. 2,456" : "KSH. ****")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Blank().width(8)

              Text(this.balanceVisible ? "HIDE" : "SHOW")
                .fontSize(12)
                .fontColor('#00C853')
                .onClick(() => {
                  this.balanceVisible = !this.balanceVisible
                })
            }
            .alignItems(VerticalAlign.Center)
          }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .padding({ left: 15, right: 15 })
        }

        // === QuickActionRow ===
        ListItem() {
          Row() {
            // SEND
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#FFFFFF')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#00C853')

              Blank().height(4)
              Text('SEND').fontSize(11).textAlign(TextAlign.Center).fontColor('#000000')
            }.alignItems(HorizontalAlign.Center)

            // PAY
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#FFFFFF')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#3D5AFE')

              Blank().height(4)
              Text('PAY').fontSize(11).textAlign(TextAlign.Center).fontColor('#000000')
            }.alignItems(HorizontalAlign.Center)

            // WITHDRAW
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Text('W')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#D32F2F')

              Blank().height(4)
              Text('WITHDRAW').fontSize(11).textAlign(TextAlign.Center).fontColor('#000000')
            }.alignItems(HorizontalAlign.Center)

            // AIRTIME
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#FFFFFF')
              }
              .width(40)
              .height(40)
              .borderRadius(20)
              .backgroundColor('#2196F3')

              Blank().height(4)
              Text('AIRTIME').fontSize(11).textAlign(TextAlign.Center).fontColor('#000000')
            }.alignItems(HorizontalAlign.Center)
          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')
          .padding({ left: 15, right: 15, top: 16, bottom: 16 })
        }

        // === SpendingCardsPager ===
        ListItem() {
          Column() {
            // Card Content
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Column() {
                  Text('TOTAL SPENT THIS WEEK')
                    .fontSize(10)
                    .fontColor('#CAC8C8')
                  
                  Blank().height(4)
                  
                  Text('KSH. 1,500.00')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                  
                  Blank().layoutWeight(1)
                  
                  Text('DAILY AVERAGE')
                    .fontSize(14)
                    .fontColor('#E6E5E5')
                  
                  Text('KSH.845.87')
                    .fontSize(14)
                    .fontColor('#FFFFFF')
                }
                .width('100%')
                .height('100%')
                .padding(12)

                // MY SPEND Badge
                Column() {
                  Text('MY SPEND')
                    .fontSize(11)
                    .fontColor('#FFFFFF')
                }
                .position({ x: 'auto', y: 0 })
                .alignSelf(ItemAlign.End)
                .margin({ right: 12, top: 12 })
                .padding({ left: 16, right: 16, top: 6, bottom: 6 })
                .borderRadius(50)
                .backgroundColor('rgba(0,0,0,0.2)')

                // MPESA Label
                Text('MPESA')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('rgba(255,255,255,0.7)')
                  .position({ x: 'auto', y: 'auto' })
                  .alignSelf(ItemAlign.End)
                  .margin({ right: 12, bottom: 12 })
              }
              .width('100%')
              .height(200)
              .linearGradient({
                angle: 180,
                colors: [['#FF4081', 0], ['#FF5722', 0.5], ['#3F51B5', 1]]
              })
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }

            // Dots Indicator
            Row() {
              ForEach([0, 1, 2], (index: number) => {
                Stack({ alignContent: Alignment.Center }) {
                }
                .width(index === this.currentCardPage ? 8 : 6)
                .height(index === this.currentCardPage ? 8 : 6)
                .borderRadius(3)
                .backgroundColor(index === this.currentCardPage ? '#FF5722' : '#808080')
                .margin({ right: 6 })
              })
            }
            .justifyContent(FlexAlign.Center)
            .width('100%')
            .padding({ top: 12, bottom: 12 })
          }
        }

        // === M-PESA STATEMENTS Header ===
        ListItem() {
          Row() {
            Text('M-PESA STATEMENTS')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            
            Blank().layoutWeight(1)
            
            Text('SEE ALL')
              .fontSize(12)
              .fontColor('#00C853')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding({ left: 15, right: 15, top: 12, bottom: 12 })
        }

        // === StatementRow ===
        ListItem() {
          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Text('KS')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#BBDEFB')
            }
            .width(50)
            .height(50)
            .borderRadius(25)
            .backgroundColor('#F1F8E9')
            .border({ width: 1, color: '#FFFFFF' })

            Column() {
              Text('GROCERY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Text('122229393')
                .fontSize(11)
                .fontColor('#808080')
            }
            .layoutWeight(1)
            .margin({ left: 16 })

            Column() {
              Text('Ksh. 2,455.0')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .textAlign(TextAlign.End)
              
              Text('12/01/2022')
                .fontSize(11)
                .fontColor('#808080')
                .textAlign(TextAlign.End)
            }
            .alignItems(HorizontalAlign.End)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding({ left: 15, right: 15, top: 7, bottom: 7 })
        }

        // Bottom Spacer for NavBar
        ListItem() {
          Column() {
            Blank().height(60)
          }
        }
      }

      // === BottomNavBar ===
      Row() {
        // Home
        Column() {
          Stack({ alignContent: Alignment.Center }) {
             Image($r('app.media.startIcon'))
               .width(24)
               .height(24)
               .objectFit(ImageFit.Contain)
               .fillColor('#000000')
          }
          .width(48)
          .height(32)
          .borderRadius(16)
          .backgroundColor('#E1BEE7')
          
          Text('Home')
            .fontSize(11)
            .fontColor('#000000')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // Transact
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .opacity(0.5)
          
          Text('Transact')
            .fontSize(11)
            .fontColor('#808080')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // Discover
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .opacity(0.5)
          
          Text('Discover')
            .fontSize(11)
            .fontColor('#808080')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // Growth
        Column() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .opacity(0.5)
          
          Text('Growth')
            .fontSize(11)
            .fontColor('#808080')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .position({ x: 0, y: 'auto' })
      .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}