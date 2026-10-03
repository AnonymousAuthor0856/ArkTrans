@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: 0 }) {
        // === HeaderSection ===
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('Welcome back,').fontSize(16).fontColor('#888888')
            Text('David Miller').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#000000')
          }
          Blank().layoutWeight(1)
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24).height(24).objectFit(ImageFit.Contain)
          }.width(48).height(48).backgroundColor('#F5F5F5').borderRadius(24)
        }.width('100%').alignItems(VerticalAlign.Center)

        Blank().height(40)

        // === MasterStatusCard ===
        Column({ space: 16 }) {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(36).height(36).objectFit(ImageFit.Contain)
          }
          .width(80).height(80)
          .backgroundColor('#FFFFFF')
          .border({ width: 2, color: '#E0E0E0', radius: 40 })

          Text('SECURE')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor(this.isLocked ? '#000000' : '#4CAF50')

          Text('All perimeter doors are locked.')
            .fontSize(16)
            .fontColor('#888888')
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#F8F8F8')
        .borderRadius(24)

        Blank().height(32)

        // === My Access Points ===
        Text('My Access Points')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Blank().height(16)

        Column({ space: 12 }) {
          // Main Entrance
          Row({ space: 0 }) {
            Row({ space: 16 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(20).height(20)
              }.width(40).height(40).backgroundColor('#FAFAFA').borderRadius(10)
              
              Column({ space: 4 }) {
                Text('Main Entrance').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('2h ago').fontSize(14).fontColor('#CCCCCC')
              }
            }
            Blank().layoutWeight(1)
            Toggle({ type: ToggleType.Switch, isOn: false })
          }
          .width('100%')
          .padding(16)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#EEEEEE', radius: 16 })

          // Garage Door
          Row({ space: 0 }) {
            Row({ space: 16 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(20).height(20)
              }.width(40).height(40).backgroundColor('#FAFAFA').borderRadius(10)
              
              Column({ space: 4 }) {
                Text('Garage Door').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('12m ago').fontSize(14).fontColor('#CCCCCC')
              }
            }
            Blank().layoutWeight(1)
            Toggle({ type: ToggleType.Switch, isOn: true })
          }
          .width('100%')
          .padding(16)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#EEEEEE', radius: 16 })

          // Server Room
          Row({ space: 0 }) {
            Row({ space: 16 }) {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon')).width(20).height(20)
              }.width(40).height(40).backgroundColor('#FAFAFA').borderRadius(10)
              
              Column({ space: 4 }) {
                Text('Server Room').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#000000')
                Text('1d ago').fontSize(14).fontColor('#CCCCCC')
              }
            }
            Blank().layoutWeight(1)
            Toggle({ type: ToggleType.Switch, isOn: false })
          }
          .width('100%')
          .padding(16)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#EEEEEE', radius: 16 })
        }

        Blank().height(32)

        // === Recent Activity ===
        Text('Recent Activity')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')

        Blank().height(16)

        // Activity Log Item 1
        Row({ space: 0 }) {
          Text('10:42 AM').fontSize(14).fontColor('#888888').width(70)
          Divider().vertical(true).height(20).color('#EEEEEE')
          Blank().width(16)
          Column({ space: 4 }) {
            Text('Main Gate unlocked').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
            Text('by You').fontSize(12).fontColor('#888888')
          }
        }.width('100%').alignItems(VerticalAlign.Center).padding({ top: 12, bottom: 12 })

        // Activity Log Item 2
        Row({ space: 0 }) {
          Text('09:15 AM').fontSize(14).fontColor('#888888').width(70)
          Divider().vertical(true).height(20).color('#EEEEEE')
          Blank().width(16)
          Column({ space: 4 }) {
            Text('Guest Entry Denied').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
            Text('by System').fontSize(12).fontColor('#888888')
          }
        }.width('100%').alignItems(VerticalAlign.Center).padding({ top: 12, bottom: 12 })

        // Activity Log Item 3
        Row({ space: 0 }) {
          Text('08:30 AM').fontSize(14).fontColor('#888888').width(70)
          Divider().vertical(true).height(20).color('#EEEEEE')
          Blank().width(16)
          Column({ space: 4 }) {
            Text('Garage Door opened').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
            Text('by Alice').fontSize(12).fontColor('#888888')
          }
        }.width('100%').alignItems(VerticalAlign.Center).padding({ top: 12, bottom: 12 })

      }.width('100%').padding(24)
    }.width('100%').height('100%')
  }
}