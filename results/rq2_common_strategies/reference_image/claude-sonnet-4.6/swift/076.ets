import { window } from '@kit.ArkUI';

// ---------- Palette ----------
const COLOR_BG: string = '#F4F6F8';
const COLOR_PRIMARY: string = '#5E60CE';
const COLOR_DARK: string = '#212121';
const COLOR_WHITE: string = '#FFFFFF';
const COLOR_BLACK: string = '#000000';
const COLOR_TEXT_GRAY: string = '#8C8C8C';
const COLOR_INACTIVE_BG: string = '#F0F0F0';

interface DeviceItem {
  name: string;
  icon: Resource;
  isActive: boolean;
  accent: string;
  accentBg: string;
}

@Entry
@Component
struct SmartHomeDashboard {
  private leftDevices: DeviceItem[] = [
    {
      name: 'Smart Lamp',
      icon: $r('sys.symbol.star_fill'),
      isActive: true,
      accent: '#FFC107',
      accentBg: '#1AFFC107'
    },
    {
      name: 'Thermostat',
      icon: $r('sys.symbol.thermometer'),
      isActive: true,
      accent: '#FF7043',
      accentBg: '#1AFF7043'
    }
  ];

  private rightDevices: DeviceItem[] = [
    {
      name: 'Main Lock',
      icon: $r('sys.symbol.lock_fill'),
      isActive: false,
      accent: '#4CAF50',
      accentBg: '#1A4CAF50'
    },
    {
      name: 'Wi-Fi Router',
      icon: $r('sys.symbol.gearshape_fill'),
      isActive: true,
      accent: '#2196F3',
      accentBg: '#1A2196F3'
    }
  ];

  aboutToAppear(): void {
    try {
      window.getLastWindow(getContext(this)).then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        const bars: Array<'status' | 'navigation'> = [];
        win.setWindowSystemBarEnable(bars);
      }).catch((err: Error) => {
        console.error('window setup failed: ' + err.message);
      });
    } catch (err) {
      console.error('window setup failed');
    }
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_BG)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      Scroll() {
        Column() {
          // ---------- Header ----------
          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(COLOR_TEXT_GRAY)
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLOR_BLACK)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Blank()

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(48)
                .height(48)
                .fill(COLOR_WHITE)
              SymbolGlyph($r('sys.symbol.person_fill'))
                .fontSize(24)
                .fontColor([COLOR_BLACK])
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Center)

          // ---------- Energy Usage Card ----------
          Row() {
            Column() {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('#CCFFFFFF')
              Text('28.5 kWh')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLOR_WHITE)
              Text('Today')
                .fontSize(12)
                .fontColor('#99FFFFFF')
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Blank()

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(56)
                .height(56)
                .fill('#33FFFFFF')
              SymbolGlyph($r('sys.symbol.bell_fill'))
                .fontSize(24)
                .fontColor([COLOR_WHITE])
            }
            .width(56)
            .height(56)
          }
          .width('100%')
          .padding(24)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
          .margin({ left: 24, right: 24, top: 32 })

          // ---------- Scenes ----------
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_BLACK)
            .padding({ left: 24, right: 24 })
            .margin({ top: 32 })

          Scroll() {
            Row({ space: 12 }) {
              SceneButton({
                text: 'Home',
                icon: $r('sys.symbol.house_fill'),
                isSelected: true
              })
              SceneButton({
                text: 'Away',
                icon: $r('sys.symbol.lock_fill'),
                isSelected: false
              })
              SceneButton({
                text: 'Sleep',
                icon: $r('sys.symbol.star_fill'),
                isSelected: false
              })
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
          .width('100%')
          .margin({ top: 16 })

          // ---------- Devices ----------
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_BLACK)
            .padding({ left: 24, right: 24 })
            .margin({ top: 32 })

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              ForEach(this.leftDevices, (item: DeviceItem) => {
                DeviceCard({
                  name: item.name,
                  icon: item.icon,
                  accent: item.accent,
                  accentBg: item.accentBg,
                  isActive: item.isActive
                })
              }, (item: DeviceItem) => item.name + item.isActive.toString())
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Column({ space: 16 }) {
              ForEach(this.rightDevices, (item: DeviceItem) => {
                DeviceCard({
                  name: item.name,
                  icon: item.icon,
                  accent: item.accent,
                  accentBg: item.accentBg,
                  isActive: item.isActive
                })
              }, (item: DeviceItem) => item.name + item.isActive.toString())
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .padding({ left: 24, right: 24 })
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ top: 16, bottom: 24 })
      }
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BG)
  }
}

@Component
struct SceneButton {
  text: string = '';
  icon: Resource = $r('sys.symbol.house_fill');
  isSelected: boolean = false;

  build() {
    Row({ space: 8 }) {
      SymbolGlyph(this.icon)
        .fontSize(18)
        .fontColor([this.isSelected ? COLOR_WHITE : COLOR_BLACK])

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? COLOR_WHITE : COLOR_BLACK)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? COLOR_DARK : COLOR_WHITE)
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  name: string = '';
  icon: Resource = $r('sys.symbol.star_fill');
  accent: string = '#FFC107';
  accentBg: string = '#1AFFC107';
  @Prop isActive: boolean = false;
  @State switchState: boolean = false;

  aboutToAppear(): void {
    this.switchState = this.isActive;
  }

  build() {
    Column() {
      // Icon badge
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(40)
            .height(40)
            .fill(this.switchState ? this.accentBg : COLOR_INACTIVE_BG)
          SymbolGlyph(this.icon)
            .fontSize(24)
            .fontColor([this.switchState ? this.accent : COLOR_TEXT_GRAY])
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()

      // Title + state
      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_BLACK)

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accent : COLOR_TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank()

      // Switch
      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accent)
          .switchPointColor(COLOR_WHITE)
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor(COLOR_WHITE)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }
}