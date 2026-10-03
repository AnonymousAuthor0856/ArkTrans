// entry/src/main/ets/pages/Index.ets
// ArkUI (ArkTS) port of the Compose "Smart Home Dashboard".
// Requires API 11+ for SymbolGlyph / Toggle.

const ACCENT_LAMP: string = '#FFC107';
const ACCENT_THERMOSTAT: string = '#FF7043';
const ACCENT_LOCK: string = '#4CAF50';
const ACCENT_WIFI: string = '#2196F3';

// Builds an #AARRGGBB color from a 6-digit hex + alpha, so accents can be
// reused at 10%-20% opacity (Compose's Color.copy(alpha = ...)).
function tint(hex: string, alpha: number): string {
  const raw: string = hex.startsWith('#') ? hex.substring(1) : hex;
  const six: string = raw.length === 8 ? raw.substring(2) : raw;
  let aHex: string = Math.round(alpha * 255).toString(16).toUpperCase();
  if (aHex.length < 2) {
    aHex = '0' + aHex;
  }
  return '#' + aHex + six;
}

@Component
struct DeviceCard {
  @Prop name: string;
  @Prop icon: Resource;
  @Prop accentColor: string;
  @Prop initialActive: boolean;
  @State isActive: boolean = false;

  aboutToAppear(): void {
    this.isActive = this.initialActive;
  }

  build() {
    Column() {
      // Icon bubble
      Stack() {
        SymbolGlyph(this.icon)
          .fontSize(22)
          .fontColor([this.isActive ? this.accentColor : '#9E9E9E'])
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.isActive ? tint(this.accentColor, 0.12) : '#F0F0F0')

      // Name + state
      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.isActive ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? this.accentColor : '#9E9E9E')
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      // Switch
      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor(this.accentColor)
          .switchPointColor(Color.White)
          .width(46)
          .height(28)
          .onChange((isOn: boolean) => {
            this.isActive = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)               // width / height, same as Compose
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(20)
    .backgroundColor(Color.White)
    .shadow({ radius: 6, color: '#14000000', offsetX: 0, offsetY: 2 })
  }
}

@Entry
@Component
struct SmartHomeDashboard {
  build() {
    Scroll() {
      Column() {
        // ---------- Header ----------
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#9E9E9E')
            Text('Alex Johnson')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Stack() {
            SymbolGlyph($r('sys.symbol.person'))
              .fontSize(24)
              .fontColor([Color.Black])
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(Color.White)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        // ---------- Energy card ----------
        Row() {
          Column() {
            Text('Energy Usage')
              .fontSize(14)
              .fontColor('#CCFFFFFF')
            Text('28.5 kWh')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('Today')
              .fontSize(12)
              .fontColor('#99FFFFFF')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Stack() {
            SymbolGlyph($r('sys.symbol.bell'))
              .fontSize(26)
              .fontColor([Color.White])
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#33FFFFFF')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding(24)
        .borderRadius(24)
        .backgroundColor('#5E60CE')
        .shadow({ radius: 10, color: '#33000000', offsetX: 0, offsetY: 6 })
        .margin({ top: 32 })

        // ---------- Scenes ----------
        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 32 })

        Row({ space: 12 }) {
          // Home (selected)
          Row({ space: 8 }) {
            SymbolGlyph($r('sys.symbol.house'))
              .fontSize(18)
              .fontColor([Color.White])
            Text('Home')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .maxLines(1)
          }
          .padding({ left: 20, right: 20, top: 12, bottom: 12 })
          .borderRadius(30)
          .backgroundColor('#212121')

          // Away
          Row({ space: 8 }) {
            SymbolGlyph($r('sys.symbol.lock'))
              .fontSize(18)
              .fontColor(['#212121'])
            Text('Away')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#212121')
              .maxLines(1)
          }
          .padding({ left: 20, right: 20, top: 12, bottom: 12 })
          .borderRadius(30)
          .backgroundColor(Color.White)

          // Sleep — grows into the remaining width, exactly like the row
          // in the Compose original, so on a narrow screen it squeezes down.
          Row({ space: 8 }) {
            SymbolGlyph($r('sys.symbol.star'))
              .fontSize(18)
              .fontColor(['#212121'])
            Text('Sleep')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#212121')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .padding({ left: 20, right: 20, top: 12, bottom: 12 })
          .borderRadius(30)
          .backgroundColor(Color.White)
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .margin({ top: 16 })

        // ---------- Devices ----------
        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 32 })

        Row({ space: 16 }) {
          Column() {
            DeviceCard({
              name: 'Smart Lamp',
              icon: $r('sys.symbol.star'),
              accentColor: ACCENT_LAMP,
              initialActive: true
            })
            DeviceCard({
              name: 'Thermostat',
              icon: $r('sys.symbol.line_3_horizontal'),
              accentColor: ACCENT_THERMOSTAT,
              initialActive: true
            })
            .margin({ top: 16 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Column() {
            DeviceCard({
              name: 'Main Lock',
              icon: $r('sys.symbol.lock'),
              accentColor: ACCENT_LOCK,
              initialActive: false
            })
            DeviceCard({
              name: 'Wi-Fi Router',
              icon: $r('sys.symbol.gearshape'),
              accentColor: ACCENT_WIFI,
              initialActive: true
            })
            .margin({ top: 16 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .margin({ top: 16 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(24)
      .constraintSize({ minHeight: '100%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }
}