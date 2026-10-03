@Entry
@Component
struct Index {
  @State welcomeBack: string = 'Welcome back,'
  @State davidMiller: string = 'David Miller'
  @State statusText: string = 'System Locked'
  @State subText: string = 'Master lock is engaged'
  @State myAccessPoints: string = 'My Access Points'
  @State point: string = ''
  @State itemName: string = ''
  @State itemLastAccessed: string = ''
  @State checked: boolean = false
  @State isOn: boolean = false
  @State recentActivity: string = 'Recent Activity'
  @State time: string = ''
  @State event: string = ''
  @State user: number = 0

  // Define interface for access points to satisfy ArkTS strict typing rules
  private accessPoints: Array<AccessPointItem> = [
    { name: 'Main Gate', lastAccessed: '2 mins ago' },
    { name: 'Garage Door', lastAccessed: '1 hour ago' }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // HeaderSection
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text(this.welcomeBack).fontColor('#757575').fontSize(14)
            Text(this.davidMiller).fontWeight(FontWeight.Bold).fontSize(24)
          }
          
          // Avatar Box
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0' })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')

        Blank().height(40)

        // MasterStatusCard
        Column() {
          Column({ space: 0 }) {
            // Status Icon Box
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(36)
                .height(36)
                .objectFit(ImageFit.Contain)
            }
            .width(80)
            .height(80)
            .backgroundColor('#FFFFFF')
            .borderRadius(40)
            .border({ width: 2, color: '#EEEEEE' })

            Blank().height(16)

            Text(this.statusText)
              .fontWeight(FontWeight.Bold)
              .fontSize(20)
              .letterSpacing(2)
              .fontColor('#333333')

            Blank().height(8)

            Text(this.subText)
              .fontColor('#757575')
              .fontSize(14)
          }
          .alignItems(HorizontalAlign.Center)
          .padding(24)
          .width('100%')
        }
        .width('100%')
        .backgroundColor('#F8F8F8')
        .borderRadius(24)
        .border({ width: 1, color: '#EFEFEF' })
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

        Blank().height(32)

        // My Access Points Title
        Text(this.myAccessPoints)
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
          .fontColor('#424242')

        Blank().height(16)

        // AccessPointList
        Column({ space: 12 }) {
          ForEach(this.accessPoints, (item: AccessPointItem) => {
            Row({ space: 0 }) {
              Row({ space: 0 }) {
                // Icon Box
                Stack({ alignContent: Alignment.Center }) {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .objectFit(ImageFit.Contain)
                }
                .width(40)
                .height(40)
                .backgroundColor('#FAFAFA')
                .borderRadius(10)

                Blank().width(16)

                Column({ space: 0 }) {
                  Text(item.name)
                    .fontWeight(FontWeight.Medium)
                    .fontSize(16)
                  Text(item.lastAccessed)
                    .fontColor('#BDBDBD')
                    .fontSize(12)
                }
              }
              .alignItems(VerticalAlign.Center)

              Toggle({ type: ToggleType.Switch, isOn: this.checked })
                .onChange((isOn: boolean) => {
                  this.checked = isOn
                })
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#EEEEEE' })
            .padding(16)
          })
        }

        Blank().height(32)

        // Recent Activity Title
        Text(this.recentActivity)
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
          .fontColor('#424242')

        Blank().height(16)

        // Activity Log Items
        // Item 1
        Row({ space: 0 }) {
          Text('10:42 AM')
            .fontColor('#757575')
            .fontSize(14)
            .width(70)
          
          Divider()
            .vertical(true)
            .height(20)
            .color('#EEEEEE')

          Blank().width(16)

          Column({ space: 0 }) {
            Text('Main Gate unlocked')
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
            Text('by You')
              .fontColor('#757575')
              .fontSize(12)
          }
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

        // Item 2
        Row({ space: 0 }) {
          Text('09:15 AM')
            .fontColor('#757575')
            .fontSize(14)
            .width(70)
          
          Divider()
            .vertical(true)
            .height(20)
            .color('#EEEEEE')

          Blank().width(16)

          Column({ space: 0 }) {
            Text('Guest Entry Denied')
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
            Text('by System')
              .fontColor('#757575')
              .fontSize(12)
          }
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

        // Item 3
        Row({ space: 0 }) {
          Text('08:30 AM')
            .fontColor('#757575')
            .fontSize(14)
            .width(70)
          
          Divider()
            .vertical(true)
            .height(20)
            .color('#EEEEEE')

          Blank().width(16)

          Column({ space: 0 }) {
            Text('Garage Door opened')
              .fontWeight(FontWeight.Medium)
              .fontSize(14)
            Text('by Alice')
              .fontColor('#757575')
              .fontSize(12)
          }
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      }
      .width('100%')
      .height('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
  }
}

// Explicitly declared interface for Access Point items
interface AccessPointItem {
  name: string;
  lastAccessed: string;
}