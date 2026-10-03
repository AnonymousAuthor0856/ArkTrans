@Entry
@Component
struct Index {
  @State selectedNavItem: string = "Home"

  // Mock data structures to replace 'any' and undefined collections
  private controlActions: Array<{ label: string }> = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Top Up' }
  ]

  private navItems: Array<{ label: string }> = [
    { label: 'Home' },
    { label: 'Activity' },
    { label: 'Settings' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 24 }) {
        ListItem() {
          Column() {
            Column({ space: 0 }) {
              Text('Total Balance')
                .fontColor('#FFFFFF')
                .fontSize(14)
              
              Blank().height(8)
              
              Text('$ 1,145.14')
                .fontColor('#FFFFFF')
                .fontSize(36)
                .fontWeight(FontWeight.Bold)
              
              Blank().height(4)
              
              Row({ space: 0 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle(10).fill('#4ADE80')
                }.width(10).height(10)
                
                Blank().width(8)
                
                Text('+$234.10 today')
                  .fontColor('#4ADE80')
                  .fontSize(14)
              }.alignItems(VerticalAlign.Center)
            }.padding(24)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .width('100%')
        }

        ListItem() {
          Row({ space: 0 }) {
            ForEach(this.controlActions, (item: { label: string }) => {
              Column({ space: 8 }) {
                Button() {
                  Stack({ alignContent: Alignment.Center }) {
                    // Using a simple circle as placeholder for icon since only startIcon is allowed
                    // and we don't know the specific icon for actions. 
                    // If an icon was required, it would be Image($r('app.media.startIcon'))
                    Circle(24).fill('#020617')
                  }
                }
                .type(ButtonType.Normal)
                .backgroundColor('#F8FAFC')
                .borderRadius(32)
                .width(64)
                .height(64)
                .onClick(() => {})

                Text(item.label)
                  .fontSize(12)
                  .fontColor('#0F172A')
              }.alignItems(HorizontalAlign.Center)
            })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceAround)
          .width('100%')
        }

        ListItem() {
          Row({ space: 0 }) {
            Text('Recent Activity')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            
            Blank()
            
            Button() {
              Text('View All')
                .fontColor('#64748B')
                .fontSize(12)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }

        ListItem() {
          Column() {
            Row({ space: 16 }) {
              Stack({ alignContent: Alignment.Center }) {
                // Placeholder for avatar/icon
                Circle(24).fill('#CBD5E1')
              }
              .width(48)
              .height(48)
              .backgroundColor('#F1F5F9')
              .borderRadius(8)

              Column({ space: 0 }) {
                Text('transaction.name')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                
                Text('transaction.detail')
                  .fontSize(12)
                  .fontColor('#64748B')
              }
              .layoutWeight(1)

              Text('transaction.amount')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.End)
                .fontColor('#0F172A')
            }
            .alignItems(VerticalAlign.Center)
            .padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .width('100%')
        }
      }
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .width('100%')
      .height('100%')

      // Top App Bar Simulation
      Row() {
        Blank()
        Text('My Wallet')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Blank()
        
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Circle(14).fill('#94A3B8')
          }
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(28)
        .height(28)
        .onClick(() => {})

        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Circle(14).fill('#94A3B8')
          }
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(28)
        .height(28)
        .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .position({ x: 0, y: 0 })

      // Navigation Bar Simulation
      Row() {
        ForEach(this.navItems, (item: { label: string }) => {
          Column({ space: 4 }) {
            Stack({ alignContent: Alignment.Center }) {
              if (this.selectedNavItem === item.label) {
                Circle(6).fill('#0F172A')
              } else {
                Circle(6).fill('#94A3B8')
              }
            }
            .width(24)
            .height(24)
            
            Text(item.label)
              .fontSize(12)
              .fontColor(this.selectedNavItem === item.label ? '#0F172A' : '#94A3B8')
          }
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNavItem = item.label
          })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .position({ x: 0, y: -60 })
      .shadow({ radius: 4, color: '#1A000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}