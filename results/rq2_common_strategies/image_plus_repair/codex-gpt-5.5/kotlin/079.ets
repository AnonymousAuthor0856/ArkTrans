@Entry
@Component
struct Index {
  @State activeDevices: boolean[] = [true, true, false, true, false, true]
  @State selectedTab: number = 0

  private deviceNames: string[] = [
    'Living Room',
    'Smart Lock',
    'Bedroom AC',
    'Router',
    'Kitchen',
    'Corridor'
  ]

  private deviceIcons: string[] = ['⌂', '▣', '★', '●', 'i', '◉']

  build() {
    Column() {
      Scroll() {
        Column({ space: 0 }) {
          Row() {
            Column({ space: 0 }) {
              Text('Welcome Home,')
                .fontSize(16)
                .fontColor('#888B8D')
              Text('Alex Johnson')
                .fontSize(30)
                .fontWeight(FontWeight.Bold)
                .fontColor('#202024')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(48)
                .height(48)
                .fill('#E5E8EA')
              Text('●')
                .fontSize(30)
                .fontColor('#45616D')
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Column({ space: 2 }) {
            Text('Temperature')
              .fontSize(12)
              .fontColor('#347CD0')
            Text('24°C')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1565C0')
              .margin({ top: 5 })
            Text('Comfortable')
              .fontSize(12)
              .fontColor('#4B8DD8')
          }
          .width('100%')
          .height(100)
          .padding({ left: 16, right: 16, top: 14, bottom: 12 })
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#E3F2FD')
          .borderRadius(16)
          .margin({ top: 32 })

          Text('My Devices')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#202024')
            .width('100%')
            .margin({ top: 32, bottom: 16 })

          Grid() {
            ForEach(this.deviceNames, (name: string, index: number) => {
              GridItem() {
                Column() {
                  Row() {
                    Stack({ alignContent: Alignment.Center }) {
                      Circle()
                        .width(36)
                        .height(36)
                        .fill(this.activeDevices[index] ? '#68828D' : '#F0F0F0')
                      Text(this.deviceIcons[index])
                        .fontSize(20)
                        .fontColor(this.activeDevices[index] ? '#FFFFFF' : '#888888')
                    }
                    Toggle({ type: ToggleType.Switch, isOn: this.activeDevices[index] })
                      .selectedColor('#91A5AB')
                      .switchPointColor('#FFFFFF')
                      .width(52)
                      .height(32)
                      .onChange((value: boolean) => {
                        let updated = this.activeDevices.slice()
                        updated[index] = value
                        this.activeDevices = updated
                      })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)

                  Column({ space: 4 }) {
                    Text(name)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.activeDevices[index] ? '#FFFFFF' : '#111111')
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    Text(this.activeDevices[index] ? 'On' : 'Off')
                      .fontSize(12)
                      .fontColor(this.activeDevices[index] ? '#C7D3D7' : '#777777')
                  }
                  .width('100%')
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .height(140)
                .padding(16)
                .justifyContent(FlexAlign.SpaceBetween)
                .backgroundColor(this.activeDevices[index] ? '#45616D' : '#FFFFFF')
                .borderRadius(20)
                .shadow({
                  radius: this.activeDevices[index] ? 12 : 3,
                  color: '#26000000',
                  offsetX: 0,
                  offsetY: 6
                })
              }
            }, (name: string) => name)
          }
          .width('100%')
          .columnsTemplate('1fr 1fr')
          .columnsGap(16)
          .rowsGap(16)
          .margin({ bottom: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        this.NavigationItem('⌂', 'Home', 0)
        this.NavigationItem('★', 'Scenes', 1)
        this.NavigationItem('⚙', 'Settings', 2)
      }
      .width('100%')
      .height(80)
      .padding({ left: 20, right: 20, top: 8, bottom: 8 })
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 10, color: '#18000000', offsetX: 0, offsetY: -3 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }

  @Builder
  NavigationItem(icon: string, label: string, index: number) {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        if (this.selectedTab === index) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor('#E4E8EA')
            .borderRadius(20)
        }
        Text(icon)
          .fontSize(24)
          .fontColor(this.selectedTab === index ? '#45616D' : '#47474F')
      }
      .width(64)
      .height(32)

      Text(label)
        .fontSize(12)
        .fontColor(this.selectedTab === index ? '#45616D' : '#47474F')
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedTab = index
    })
  }
}
