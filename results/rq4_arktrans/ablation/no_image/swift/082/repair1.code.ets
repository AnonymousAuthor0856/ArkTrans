@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      // props: {"alignment":".bottom","_positional_raw":[".bottom"]}
      // modifiers: ["edgesIgnoringSafeArea(.bottom)"]
      // children: 2
      Stack({ alignContent: Alignment.Bottom }) {
        // === VStack ===
        // props: {"spacing":"0"}
        // children: 1
        Column({ space: 0 }) {
          // === ScrollView ===
          // props: {"showsIndicators":"false"}
          // children: 1
          Scroll() {
            // === VStack ===
            // props: {"alignment":".leading","spacing":"0"}
            // children: 7
            Column({ space: 0 }) {
              .alignItems(HorizontalAlign.Start)
              // === Spacer ===
              // props: {"height":"24"}
              // modifiers: ["frame(height: 24)"]
              Blank().height(24)

              // === HStack ===
              // props: {"alignment":".center"}
              // children: 3
              Row() {
                .verticalCenter()
                // === VStack ===
                // props: {"alignment":".leading","spacing":"4"}
                // children: 2
                Column({ space: 4 }) {
                  .alignItems(HorizontalAlign.Start)
                  // === Text ===
                  // props: {"text":"Welcome Home,","_text_raw":"\"Welcome Home,\"",".system(size":"16)","_positional_raw":[".gray"]}
                  // modifiers: ["foregroundColor(.gray)","font(.system(size: 16))"]
                  Text('Welcome Home,').fontColor('#999999').fontSize(16)
                  // === Text ===
                  // props: {"text":"Alex Johnson","_text_raw":"\"Alex Johnson\"",".system(size":"28, weight: .bold)","_positional_raw":[".black"]}
                  // modifiers: ["foregroundColor(.black)","font(.system(size: 28, weight: .bold))"]
                  Text('Alex Johnson').fontColor('#000000').fontSize(28).fontWeight(FontWeight.Bold)
                }
                // === Spacer ===
                Blank()
                // === ZStack ===
                // children: 2
                Stack() {
                  // === Circle ===
                  // props: {"_positional_raw":["primaryColor.opacity(0.1)"],"width":"48","height":"48"}
                  // modifiers: ["frame(width: 48, height: 48)","fill(primaryColor.opacity(0.1))"]
                  Circle().width(48).height(48).fill(Color.Blue.withAlpha(0.1))
                  // === Image ===
                  // props: {"systemName":"\"person.circle.fill\"","contentMode":".fit","width":"32","height":"32","_positional_raw":["primaryColor"]}
                  // modifiers: ["foregroundColor(primaryColor)","frame(width: 32, height: 32)","aspectRatio(contentMode: .fit)","resizable()"]
                  Image($r('app.media.startIcon')).colorFilter(Color.Blue).width(32).height(32).objectFit(ImageFit.Contain)
                }
              }
              // === Spacer ===
              // props: {"height":"32"}
              // modifiers: ["frame(height: 32)"]
              Blank().height(32)

              // === HStack ===
              // props: {"spacing":"16"}
              // children: 2
              Row({ space: 16 }) {
                // === EnvironmentCard ===
                // props: {"title":"\"Temperature\"","value":"\"24°C\"","subtitle":"\"Comfortable\"","bgColor":"Color(red: 0.89, green: 0.95, blue: 0.99)","textColor":"Color(red: 0.08, green: 0.40, blue: 0.75)"}
                EnvironmentCard({ props: { title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: new Color([0.89, 0.95, 0.99]), textColor: new Color([0.08, 0.40, 0.75]) } })
                // === EnvironmentCard ===
                // props: {"title":"\"Humidity\"","value":"\"45%\"","subtitle":"\"Normal\"","bgColor":"Color(red: 0.91, green: 0.96, blue: 0.91)","textColor":"Color(red: 0.18, green: 0.49, blue: 0.20)"}
                EnvironmentCard({ props: { title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: new Color([0.91, 0.96, 0.91]), textColor: new Color([0.18, 0.49, 0.20]) } })
              }
              // === Spacer ===
              // props: {"height":"32"}
              // modifiers: ["frame(height: 32)"]
              Blank().height(32)

              // === VStack ===
              // props: {"alignment":".leading","spacing":"16"}
              // children: 2
              Column({ space: 16 }) {
                .alignItems(HorizontalAlign.Start)
                // === Text ===
                // props: {"text":"My Devices","_text_raw":"\"My Devices\"",".system(size":"20, weight: .bold)","_positional_raw":[".black"]}
                // modifiers: ["foregroundColor(.black)","font(.system(size: 20, weight: .bold))"]
                Text('My Devices').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Bold)
                // === LazyVGrid ===
                // props: {"columns":"columns","spacing":"16"}
                // children: 1
                Grid() {
                  // === ForEach ===
                  // props: {"_positional_raw":["devices"]}
                  // children: 1
                  ForEach([1, 2], (item: number) => {
                    // === DeviceCard ===
                    // props: {"device":"device","primaryColor":"primaryColor"}
                    DeviceCard({ props: { device: item, primaryColor: Color.Blue } })
                  })
                }.columnsTemplate('1fr 1fr').columnsGap(16)
              }
              // === Spacer ===
              // props: {"height":"100"}
              // modifiers: ["frame(height: 100)"]
              Blank().height(100)
            }
          }
        }
        // === ZStack ===
        // props: {"alignment":".top","height":"80"}
        // modifiers: ["frame(height: 80)"]
        // children: 1
        Stack({ alignContent: Alignment.Top }) {
          // === HStack ===
          // props: {"_positional_raw":[".top","16"]}
          // modifiers: ["padding(.top, 16)"]
          // children: 7
          Row() {
            // === Spacer ===
            Blank()
            // === NavBarItem ===
            // props: {"icon":"\"house.fill\"","label":"\"Home\"","isSelected":"true","primaryColor":"primaryColor"}
            NavBarItem({ props: { icon: $r('app.media.startIcon'), label: 'Home', isSelected: true, primaryColor: Color.Blue } })
            // === Spacer ===
            Blank()
            // === NavBarItem ===
            // props: {"icon":"\"star.fill\"","label":"\"Scenes\"","isSelected":"false","primaryColor":"primaryColor"}
            NavBarItem({ props: { icon: $r('app.media.startIcon'), label: 'Scenes', isSelected: false, primaryColor: Color.Blue } })
            // === Spacer ===
            Blank()
            // === NavBarItem ===
            // props: {"icon":"\"gearshape.fill\"","label":"\"Settings\"","isSelected":"false","primaryColor":"primaryColor"}
            NavBarItem({ props: { icon: $r('app.media.startIcon'), label: 'Settings', isSelected: false, primaryColor: Color.Blue } })
            // === Spacer ===
            Blank()
          }.padding({ top: 16 })
        }.height(80)
      }
    }.width('100%').height('100%')
  }
}

interface EnvironmentCardProps {
  title: string;
  value: string;
  subtitle: string;
  bgColor: Color;
  textColor: Color;
}

@Component
struct EnvironmentCard {
  @Prop props: EnvironmentCardProps = {
    title: '',
    value: '',
    subtitle: '',
    bgColor: Color.White,
    textColor: Color.Black
  }

  build() {
    Column() {
      Text(this.props.title).fontColor(this.props.textColor).fontSize(14)
      Text(this.props.value).fontColor(this.props.textColor).fontSize(24).fontWeight(FontWeight.Bold)
      Text(this.props.subtitle).fontColor(this.props.textColor).fontSize(12)
    }.backgroundColor(this.props.bgColor).padding(16).borderRadius(12).width('45%')
  }
}

interface DeviceCardProps {
  device: number;
  primaryColor: Color;
}

@Component
struct DeviceCard {
  @Prop props: DeviceCardProps = {
    device: 0,
    primaryColor: Color.Blue
  }

  build() {
    Column() {
      Image($r('app.media.startIcon')).width(40).height(40).objectFit(ImageFit.Contain)
      Text(`Device ${this.props.device}`).fontColor(this.props.primaryColor).fontSize(12)
    }.backgroundColor(Color.White).padding(16).borderRadius(12).alignItems(HorizontalAlign.Center)
  }
}

interface NavBarItemProps {
  icon: Resource;
  label: string;
  isSelected: boolean;
  primaryColor: Color;
}

@Component
struct NavBarItem {
  @Prop props: NavBarItemProps = {
    icon: $r('app.media.startIcon'),
    label: '',
    isSelected: false,
    primaryColor: Color.Blue
  }

  build() {
    Column() {
      Image(this.props.icon).width(24).height(24).objectFit(ImageFit.Contain).colorFilter(this.props.isSelected ? this.props.primaryColor : Color.Gray)
      Text(this.props.label).fontColor(this.props.isSelected ? this.props.primaryColor : Color.Gray).fontSize(12)
    }.alignItems(HorizontalAlign.Center)
  }
}