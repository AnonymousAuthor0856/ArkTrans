// Translated from SwiftUI (074.swift) to ArkTS / ArkUI

// MARK: - AppTokens (Colors)
const T_PRIMARY = '#D95F02';
const T_SECONDARY = '#1B9AAA';
const T_TERTIARY = '#FEC601';
const T_BACKGROUND = '#F9F4EB';
const T_SURFACE = '#FFFFFF';
const T_SURFACE_VARIANT = '#F0E3D1';
const T_OUTLINE = '#E1CDB2';
const T_SUCCESS = '#56C271';
const T_WARNING = '#F4A259';
const T_ERROR = '#D7263D';
const T_ON_PRIMARY = '#1B1B1B';
const T_ON_SECONDARY = '#041012';
const T_ON_TERTIARY = '#1E1200';
const T_ON_BACKGROUND = '#2C2A29';
const T_ON_SURFACE = '#2E2924';

// MARK: - Data Models
class Zone {
  id: string;
  name: string;
  humidity: number;
  temp: string;

  constructor(id: string, name: string, humidity: number, temp: string) {
    this.id = id;
    this.name = name;
    this.humidity = humidity;
    this.temp = temp;
  }
}

// MARK: - Reusable Components
@Component
struct StatusRow {
  @Prop label: string = ''
  @Prop value: number = 0
  @Prop accent: string = ''

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .fontColor(T_ON_SURFACE)
        Blank()
        Text(Math.round(this.value * 100).toString() + '%')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      Progress({ value: this.value, total: 1, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(T_SURFACE)
        .height(4)
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ZoneRow {
  zone: Zone = new Zone('', '', 0, '')

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(T_ON_SURFACE)
        Blank()
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(T_PRIMARY)
      }
      Progress({ value: this.zone.humidity, total: 1, type: ProgressType.Linear })
        .color(T_SECONDARY)
        .backgroundColor(T_SURFACE)
        .height(4)
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor('#80F0E3D1') // surfaceVariant.opacity(0.5)
    .borderRadius(12)
  }
}

// MARK: - Main Screen
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  zones: Zone[] = [
    new Zone('1', 'Atrium', 0.45, '72°F'),
    new Zone('2', 'Lab East', 0.62, '68°F'),
    new Zone('3', 'Hab Deck', 0.30, '70°F')
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Button() {
            Text('Dock')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(T_ON_SURFACE)
          }
          .onClick(() => {})
          Blank()
          Text('Smart Orbit Panel')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(T_ON_SURFACE)
          Blank()
          Button() {
            Text('Alerts')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(T_SECONDARY)
          }
          .onClick(() => {})
        }
        .padding({ left: 16, right: 16 })
        .height(56)
        .backgroundColor(T_SURFACE)

        // Scrollable Content
        Scroll() {
          Column({ space: 12 }) {
            // Mode filter chips
            Row({ space: 8 }) {
              ForEach(this.modes, (mode: string) => {
                Button() {
                  Text(mode)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(T_ON_SURFACE)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                    .backgroundColor(this.activeMode === mode ? '#26D95F02' : T_SURFACE)
                    .borderRadius(12)
                    .border({ width: 1, color: T_OUTLINE })
                }
                .onClick(() => { this.activeMode = mode })
              }, (mode: string) => mode)
            }

            // Solar Wash card
            Column({ space: 8 }) {
              Text('Solar wash')
                .fontSize(20)
                .fontWeight(FontWeight.Semibold)
                .fontColor(T_ON_SURFACE)
              Text('Adjust orbital window glow')
                .fontSize(13)
                .fontWeight(FontWeight.Regular)
                .fontColor(T_ON_SURFACE)
                .opacity(0.7)

              Slider({ value: this.solarLevel, min: 0, max: 1 })
                .selectedColor(T_PRIMARY)
                .onChange((value: number) => { this.solarLevel = value })

              Row() {
                Text('0%')
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(T_ON_SURFACE)
                Blank()
                Text(Math.round(this.solarLevel * 100).toString() + '%')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(T_PRIMARY)
              }

              Text('Ambient glow')
                .fontSize(20)
                .fontWeight(FontWeight.Semibold)
                .fontColor(T_ON_SURFACE)

              Slider({ value: this.ambientGlow, min: 0, max: 1 })
                .selectedColor(T_SECONDARY)
                .onChange((value: number) => { this.ambientGlow = value })

              Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
                .color(T_SECONDARY)
                .backgroundColor(T_SURFACE_VARIANT)
                .height(4)
                .borderRadius(2)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(16)
            .backgroundColor(T_SURFACE)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

            // Orbit Health card
            Column({ space: 8 }) {
              Text('Orbit health')
                .fontSize(20)
                .fontWeight(FontWeight.Semibold)
                .fontColor(T_ON_SURFACE)
              StatusRow({ label: 'Atmos mix', value: 0.74, accent: T_SECONDARY })
              StatusRow({ label: 'Hull temp', value: 0.42, accent: T_PRIMARY })
              StatusRow({ label: 'Shield sync', value: 0.88, accent: T_TERTIARY })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(16)
            .backgroundColor(T_SURFACE_VARIANT)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })

            // Deck Zones card
            Column({ space: 8 }) {
              Text('Deck zones')
                .fontSize(20)
                .fontWeight(FontWeight.Semibold)
                .fontColor(T_ON_SURFACE)
              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zone: zone })
              }, (zone: Zone) => zone.id)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(16)
            .backgroundColor(T_SURFACE)
            .borderRadius(20)
            .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
          }
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        }
        .scrollBar(BarState.Off)

        // Bottom Bar
        Row() {
          Column({ space: 4 }) {
            Text('Grid draw')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(T_ON_SURFACE)
            Text('18.4 kWh')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(T_PRIMARY)
          }
          .alignItems(HorizontalAlign.Start)
          Blank()
          Button() {
            Text('Engage eco hold')
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor(T_PRIMARY)
              .fontColor(T_ON_PRIMARY)
              .borderRadius(16)
          }
          .onClick(() => {})
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor(T_SURFACE)
        .shadow({ radius: 8, color: '#29000000', offsetY: 4 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(T_BACKGROUND)
  }
}

// MARK: - App Entry Point
@Entry
@Component
struct Index {
  build() {
    RootScreen()
    // .statusBarHidden(true)
  }
}
