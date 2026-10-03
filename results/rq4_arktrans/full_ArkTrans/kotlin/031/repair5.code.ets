@Entry
@Component
struct Index {
  @State selectedNavItem: string = "Home"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List({ space: 24 }) {
        ListItem() {
          // === Card (Balance) ===
          Column() {
            Column({ space: 0 }) {
              Text('Total Balance')
                .fontColor('#94A3B8')
                .fontSize(16)
              
              Blank().height(8)
              
              Text('$ 1,145.14')
                .fontColor('#FFFFFF')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-1)
              
              Blank().height(4)
              
              Row({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle({ width: 10, height: 10 }).fill('#4ADE80')
                }
                Text('+$234.10 today')
                  .fontColor('#4ADE80')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }.padding({ left: 24, right: 24, top: 24, bottom: 24 })
          }
          .backgroundColor('#020617')
          .borderRadius(24)
          .width('100%')
          .shadow({ radius: 12, color: '#1A000000', offsetY: 4 })
        }

        ListItem() {
          // === Action Buttons Row ===
          Row({ space: 0 }) {
            // Send
            Column({ space: 8 }) {
              Button() {
                Stack({ alignContent: Alignment.Center }) {
                  // Placeholder for icon
                  Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#020617')
                }
              }
              .width(64).height(64)
              .backgroundColor('#FFFFFF')
              .borderRadius(32)
              .shadow({ radius: 4, color: '#1A000000' })
              
              Text('Send').fontColor('#0F172A').fontSize(14).fontWeight(FontWeight.Medium)
            }.alignItems(HorizontalAlign.Center)

            // Receive
            Column({ space: 8 }) {
              Button() {
                Stack({ alignContent: Alignment.Center }) {
                   Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#020617')
                }
              }
              .width(64).height(64)
              .backgroundColor('#FFFFFF')
              .borderRadius(32)
              .shadow({ radius: 4, color: '#1A000000' })
              
              Text('Receive').fontColor('#0F172A').fontSize(14).fontWeight(FontWeight.Medium)
            }.alignItems(HorizontalAlign.Center)

            // Add
            Column({ space: 8 }) {
              Button() {
                Stack({ alignContent: Alignment.Center }) {
                   Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#020617')
                }
              }
              .width(64).height(64)
              .backgroundColor('#FFFFFF')
              .borderRadius(32)
              .shadow({ radius: 4, color: '#1A000000' })
              
              Text('Add').fontColor('#0F172A').fontSize(14).fontWeight(FontWeight.Medium)
            }.alignItems(HorizontalAlign.Center)

            // More
            Column({ space: 8 }) {
              Button() {
                Stack({ alignContent: Alignment.Center }) {
                   Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#020617')
                }
              }
              .width(64).height(64)
              .backgroundColor('#FFFFFF')
              .borderRadius(32)
              .shadow({ radius: 4, color: '#1A000000' })
              
              Text('More').fontColor('#0F172A').fontSize(14).fontWeight(FontWeight.Medium)
            }.alignItems(HorizontalAlign.Center)
          }
          .justifyContent(FlexAlign.SpaceAround)
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }

        ListItem() {
          // === Recent Activity Header ===
          Row({ space: 0 }) {
            Text('Recent Activity')
              .fontColor('#0F172A')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
            
            Flex({ justifyContent: FlexAlign.End }) {
               Button() {
                Text('View All')
                  .fontColor('#64748B')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
              }
            }.layoutWeight(1)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }

        ListItem() {
          // === Transaction Card ===
          Column() {
            Row({ space: 16 }) {
              // Icon Box
              Stack({ alignContent: Alignment.Center }) {
                 Image($r('app.media.startIcon'))
                    .width(24).height(24)
                    .objectFit(ImageFit.Contain)
                    .fillColor('#94A3B8')
              }
              .width(48).height(48)
              .backgroundColor('#F1F5F9')
              .borderRadius(12)

              // Details
              Column({ space: 4 }) {
                Text('Spotify')
                  .fontColor('#0F172A')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                
                Text('Subscription')
                  .fontColor('#64748B')
                  .fontSize(14)
              }
              .layoutWeight(1)

              // Amount
              Text('-$9.99')
                .fontColor('#0F172A')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.End)
            }
            .alignItems(VerticalAlign.Center)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .width('100%')
          .border({ width: 1, color: '#E2E8F0' })
        }
        
        // Extra padding at bottom for nav bar
        ListItem() {
          Column() {
            Blank().height(80)
          }
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16 })
      .backgroundColor('#F8FAFC')

      // === Top App Bar ===
      Row({ space: 0 }) {
        Button() {
           Stack({ alignContent: Alignment.Center }) {
             // Placeholder for back/menu icon
             Image($r('app.media.startIcon'))
               .width(20).height(20)
               .objectFit(ImageFit.Contain)
               .fillColor('#64748B')
           }
        }
        .width(40).height(40)
        .backgroundColor('transparent')
        
        Blank()
        
        Text('My Wallet')
          .fontColor('#0F172A')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          
        Blank()
        
        Button() {
           Stack({ alignContent: Alignment.Center }) {
             // Placeholder for settings icon
             Image($r('app.media.startIcon'))
               .width(20).height(20)
               .objectFit(ImageFit.Contain)
               .fillColor('#64748B')
           }
        }
        .width(40).height(40)
        .backgroundColor('transparent')
      }
      .width('100%')
      .height(56)
      .position({ x: 0, y: 0 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({ left: 16, right: 16 })

      // === Navigation Bar ===
      Row({ space: 0 }) {
        // Home
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
             Image($r('app.media.startIcon'))
               .width(24).height(24)
               .objectFit(ImageFit.Contain)
               .fillColor(this.selectedNavItem === 'Home' ? '#020617' : '#94A3B8')
          }
          .width(40).height(40)
          .backgroundColor(this.selectedNavItem === 'Home' ? '#F1F5F9' : 'transparent')
          .borderRadius(20)
          
          Text('Home')
            .fontColor(this.selectedNavItem === 'Home' ? '#020617' : '#64748B')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .onClick(() => { this.selectedNavItem = 'Home' })

        // Cards
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
             Image($r('app.media.startIcon'))
               .width(24).height(24)
               .objectFit(ImageFit.Contain)
               .fillColor(this.selectedNavItem === 'Cards' ? '#020617' : '#94A3B8')
          }
          .width(40).height(40)
          .backgroundColor(this.selectedNavItem === 'Cards' ? '#F1F5F9' : 'transparent')
          .borderRadius(20)
          
          Text('Cards')
            .fontColor(this.selectedNavItem === 'Cards' ? '#020617' : '#64748B')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .onClick(() => { this.selectedNavItem = 'Cards' })

        // Activity
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
             Image($r('app.media.startIcon'))
               .width(24).height(24)
               .objectFit(ImageFit.Contain)
               .fillColor(this.selectedNavItem === 'Activity' ? '#020617' : '#94A3B8')
          }
          .width(40).height(40)
          .backgroundColor(this.selectedNavItem === 'Activity' ? '#F1F5F9' : 'transparent')
          .borderRadius(20)
          
          Text('Activity')
            .fontColor(this.selectedNavItem === 'Activity' ? '#020617' : '#64748B')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .onClick(() => { this.selectedNavItem = 'Activity' })

        // Profile
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
             Image($r('app.media.startIcon'))
               .width(24).height(24)
               .objectFit(ImageFit.Contain)
               .fillColor(this.selectedNavItem === 'Profile' ? '#020617' : '#94A3B8')
          }
          .width(40).height(40)
          .backgroundColor(this.selectedNavItem === 'Profile' ? '#F1F5F9' : 'transparent')
          .borderRadius(20)
          
          Text('Profile')
            .fontColor(this.selectedNavItem === 'Profile' ? '#020617' : '#64748B')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
        .onClick(() => { this.selectedNavItem = 'Profile' })
      }
      .width('100%')
      .height(70)
      .position({ x: 0, y: -1 }) // Adjust to sit at bottom
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F8FAFC')
      .shadow({ radius: 10, color: '#1A000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
  }
}