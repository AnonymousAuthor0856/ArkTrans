@Entry
@Component
struct Index {
  @State selectedTab: number = 0

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Blank().height(24)

            Row() {
              Column({ space: 4 }) {
                Text('Welcome Home,').fontColor('#9CA3AF').fontSize(16)
                Text('Alex Johnson').fontColor('#000000').fontSize(28).fontWeight(FontWeight.Bold)
              }
              Blank()
              Stack() {
                Circle().width(48).height(48).fill('#EADDFF')
                Image($r('app.media.startIcon')).width(32).height(32).objectFit(ImageFit.Contain)
              }
            }.padding({ left: 16, right: 16 })

            Blank().height(32)

            Row({ space: 16 }) {
              EnvironmentCard({ props: { title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: '#E3F2FD', textColor: '#1565C0' } })
              EnvironmentCard({ props: { title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: '#E8F5E9', textColor: '#2E7D32' } })
            }.padding({ left: 16, right: 16 })

            Blank().height(32)

            Column({ space: 16 }) {
              Text('My Devices').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Bold).alignSelf(ItemAlign.Start)
              
              Grid() {
                ForEach([1, 2, 3, 4], (device: number) => {
                  DeviceCard({ props: { device: device, primaryColor: '#6750A4' } })
                })
              }.columnsTemplate('1fr 1fr').columnsGap(16).rowsGap(16).padding({ left: 16, right: 16 })
            }

            Blank().height(100)
          }.width('100%')
        }
      }.width('100%').height('100%')

      Stack({ alignContent: Alignment.Top }) {
        Row() {
          Blank()
          NavBarItem({ props: { icon: $r('app.media.startIcon'), label: 'Home', isSelected: true, primaryColor: '#6750A4' } })
          Blank()
          NavBarItem({ props: { icon: $r('app.media.startIcon'), label: 'Scenes', isSelected: false, primaryColor: '#6750A4' } })
          Blank()
          NavBarItem({ props: { icon: $r('app.media.startIcon'), label: 'Settings', isSelected: false, primaryColor: '#6750A4' } })
          Blank()
        }.padding({ top: 16 }).width('100%')
      }.width('100%').height(80)
    }.width('100%').height('100%')
  }
}

interface EnvCardProps {
  title: string
  value: string
  subtitle: string
  bgColor: string
  textColor: string
}

@Component
struct EnvironmentCard {
  props: EnvCardProps = {} as EnvCardProps

  build() {
    Column({ space: 4 }) {
      Text(this.props.title).fontColor(this.props.textColor).fontSize(14)
      Text(this.props.value).fontColor(this.props.textColor).fontSize(24).fontWeight(FontWeight.Bold)
      Text(this.props.subtitle).fontColor(this.props.textColor).opacity(0.7).fontSize(12)
    }.width('100%').height(120).backgroundColor(this.props.bgColor).borderRadius(16).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
  }
}

interface DeviceCardProps {
  device: number
  primaryColor: string
}

@Component
struct DeviceCard {
  props: DeviceCardProps = {} as DeviceCardProps

  build() {
    Column({ space: 8 }) {
      Circle().width(40).height(40).fill(this.props.primaryColor).opacity(0.1)
      Text(`Device ${this.props.device}`).fontColor('#000000').fontSize(14).textAlign(TextAlign.Center)
    }.width('100%').height(100).backgroundColor('#F5F5F5').borderRadius(16).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center)
  }
}

interface NavBarProps {
  icon: Resource
  label: string
  isSelected: boolean
  primaryColor: string
}

@Component
struct NavBarItem {
  props: NavBarProps = {} as NavBarProps

  build() {
    Column({ space: 4 }) {
      Image(this.props.icon).width(24).height(24).objectFit(ImageFit.Contain)
      Text(this.props.label).fontColor(this.props.isSelected ? this.props.primaryColor : '#9CA3AF').fontSize(12)
    }
  }
}