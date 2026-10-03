// SmartHomePage.ets
// ArkTS (HarmonyOS Stage model / ArkUI declarative)
// Compose -> ArkTS mapping:
//   Scaffold + bottomBar      -> Column { content(layoutWeight 1), BottomBar }
//   LazyVerticalGrid(2)       -> Grid + ForEach + GridItem, columnsTemplate '1fr 1fr'
//   MaterialTheme colorScheme -> plain color constants
//   Icons.* (ImageVector)     -> SymbolGlyph + $r('sys.symbol.*')
//   remember { mutableStateOf}-> @State
//   Preview                   -> DevEco Studio Previewer

interface DeviceItem {
  name: string;
  status: string;
  icon: Resource;
  active: boolean;
}

const COLOR_PRIMARY: string = '#4A6572';
const COLOR_BACKGROUND: string = '#F5F6F8';
const COLOR_SURFACE: string = '#FFFFFF';
const COLOR_TEXT: string = '#333333';
const COLOR_TEXT_SECONDARY: string = '#9E9E9E';

@Entry
@Component
struct SmartHomePage {
  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: $r('sys.symbol.house'), active: true },
    { name: 'Smart Lock', status: 'Locked', icon: $r('sys.symbol.lock'), active: true },
    { name: 'Bedroom AC', status: '22°C', icon: $r('sys.symbol.star'), active: false },
    { name: 'Router', status: 'Online', icon: $r('sys.symbol.location'), active: true },
    { name: 'Kitchen', status: 'All Off', icon: $r('sys.symbol.info_circle'), active: false },
    { name: 'Corridor', status: 'Motion Detected', icon: $r('sys.symbol.bell'), active: true }
  ];

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(COLOR_TEXT_SECONDARY)
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_TEXT)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        SymbolGlyph($r('sys.symbol.person_fill'))
          .fontSize(28)
          .fontColor([ COLOR_PRIMARY ])
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#1A4A6572')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentSummary() {
    Row({ space: 16 }) {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        cardColor: '#E3F2FD',
        textColor: '#1565C0'
      })
      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        cardColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
    }
    .width('100%')
  }

  @Builder
  DevicesSection() {
    Column() {
      Text('My Devices')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLOR_TEXT)

      Grid() {
        ForEach(this.devices, (item: DeviceItem, index: number) => {
          GridItem() {
            DeviceCard({
              name: item.name,
              status: item.status,
              icon: item.icon,
              initialActive: item.active
            })
          }
        }, (item: DeviceItem, index: number) => item.name + index)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .margin({ top: 16 })
    }
    .layoutWeight(1)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Column() {
        this.HeaderSection()
        this.EnvironmentSummary()
          .margin({ top: 32 })
        this.DevicesSection()
          .margin({ top: 32 })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24, top: 24 })

      SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
    .expandSafeArea([ SafeAreaType.SYSTEM ], [ SafeAreaEdge.BOTTOM ])
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop subtitle: string = '';
  @Prop cardColor: string = COLOR_SURFACE;
  @Prop textColor: string = COLOR_TEXT;

  build() {
    Column() {
      Text(this.title)
        .fontSize(14)
        .fontColor(this.textColor)
        .opacity(0.8)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(this.textColor)
          .opacity(0.7)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(16)
    .backgroundColor(this.cardColor)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop status: string = '';
  @Prop icon: Resource = $r('sys.symbol.house');
  @Prop initialActive: boolean = false;
  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.initialActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          SymbolGlyph(this.icon)
            .fontSize(18)
            .fontColor([ this.isChecked ? COLOR_SURFACE : '#808080' ])
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? '#33FFFFFF' : '#F0F0F0')

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(40)
          .height(24)
          .selectedColor(this.isChecked ? '#66FFFFFF' : '#33000000')
          .switchPointColor(this.isChecked ? COLOR_SURFACE : '#4D4D4D')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? COLOR_SURFACE : '#000000')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(12)
          .fontColor(this.isChecked ? COLOR_SURFACE : '#000000')
          .opacity(0.7)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(20)
    .backgroundColor(this.isChecked ? COLOR_PRIMARY : COLOR_SURFACE)
    .shadow({
      radius: this.isChecked ? 12 : 4,
      color: '#1A000000',
      offsetX: 0,
      offsetY: this.isChecked ? 6 : 2
    })
  }
}

@Component
struct SmartHomeBottomBar {
  @State selectedIndex: number = 0;
  private labels: string[] = [ 'Home', 'Scenes', 'Settings' ];
  private icons: Resource[] = [
    $r('sys.symbol.house'),
    $r('sys.symbol.star'),
    $r('sys.symbol.gearshape')
  ];

  build() {
    Row() {
      ForEach(this.labels, (label: string, index: number) => {
        Column() {
          Stack() {
            SymbolGlyph(this.icons[index])
              .fontSize(24)
              .fontColor([
                this.selectedIndex === index ? COLOR_PRIMARY : '#4D4D4D'
              ])
          }
          .height(28)
          .padding({ left: 16, right: 16 })
          .borderRadius(14)
          .backgroundColor(this.selectedIndex === index ? '#1A4A6572' : Color.Transparent)

          Text(label)
            .fontSize(12)
            .fontColor(this.selectedIndex === index ? COLOR_PRIMARY : '#4D4D4D')
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedIndex = index;
        })
      }, (label: string) => label)
    }
    .width('100%')
    .height(72)
    .padding({ top: 8, bottom: 8 })
    .backgroundColor(COLOR_SURFACE)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 16,
      color: '#14000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}