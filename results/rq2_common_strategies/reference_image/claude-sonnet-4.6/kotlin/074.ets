// SmartOrbitPanel.ets
// ArkTS / ArkUI conversion of the "205_SmartOrbitPanel_en" Compose screen.

const C_PRIMARY: string = '#D95F02';
const C_SECONDARY: string = '#1B9AAA';
const C_TERTIARY: string = '#FEC601';
const C_BACKGROUND: string = '#F9F4EB';
const C_SURFACE: string = '#FFFFFF';
const C_SURFACE_VARIANT: string = '#F0E3D1';
const C_OUTLINE: string = '#E1CDB2';
const C_ON_SURFACE: string = '#2E2924';
const C_ON_SURFACE_SOFT: string = '#B32E2924';
const C_PRIMARY_SOFT: string = '#26D95F02';
const C_SLIDER_TRACK: string = '#E4DCF6';
const C_BOTTOM_BAR: string = '#FDF6EC';
const C_ZONE_FILL: string = '#80F0E3D1';

const S_XS: number = 4;
const S_SM: number = 8;
const S_MD: number = 12;
const S_LG: number = 16;

const F_HEADLINE: number = 20;
const F_TITLE: number = 16;
const F_BODY: number = 13;
const F_LABEL: number = 11;

const R_SMALL: number = 12;
const R_MEDIUM: number = 16;
const R_LARGE: number = 20;

interface Zone {
  name: string;
  humidity: number;
  temp: string;
}

interface MeterItem {
  label: string;
  value: number;
  accent: string;
}

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit';
  @State solarLevel: number = 0.6;
  @State ambientGlow: number = 0.35;

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual'];
  private zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ];

  @Builder
  modeChip(label: string) {
    Text(label)
      .fontSize(F_LABEL)
      .fontWeight(FontWeight.Medium)
      .fontColor(C_ON_SURFACE)
      .padding({ left: S_LG, right: S_LG, top: S_SM, bottom: S_SM })
      .backgroundColor(this.activeMode === label ? C_PRIMARY_SOFT : C_SURFACE)
      .border({ width: 1, color: C_OUTLINE })
      .borderRadius(R_SMALL)
      .onClick(() => {
        this.activeMode = label;
      })
  }

  @Builder
  meterRow(item: MeterItem) {
    Column({ space: S_XS }) {
      Row() {
        Text(item.label)
          .fontSize(F_BODY)
          .fontColor(C_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Start)
        Text(`${Math.round(item.value * 100)}%`)
          .fontSize(F_LABEL)
          .fontColor(item.accent)
      }
      .width('100%')

      Progress({ value: item.value, total: 1, type: ProgressType.Linear })
        .color(item.accent)
        .backgroundColor(C_SURFACE)
        .style({ strokeWidth: 6 })
        .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  zoneRow(zone: Zone) {
    Column({ space: S_XS }) {
      Row() {
        Text(zone.name)
          .fontSize(F_TITLE)
          .fontColor(C_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Start)
        Text(zone.temp)
          .fontSize(F_LABEL)
          .fontColor(C_PRIMARY)
      }
      .width('100%')

      Progress({ value: zone.humidity, total: 1, type: ProgressType.Linear })
        .color(C_SECONDARY)
        .backgroundColor(C_SURFACE)
        .style({ strokeWidth: 6 })
        .width('100%')
    }
    .width('100%')
    .padding(S_SM)
    .backgroundColor(C_ZONE_FILL)
    .borderRadius(R_SMALL)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // ---- Top app bar ----
      Row() {
        Text('Dock')
          .fontSize(F_LABEL)
          .fontColor(C_ON_SURFACE)
          .onClick(() => {})
        Text('Smart Orbit Panel')
          .fontSize(F_TITLE)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text('Alerts')
          .fontSize(F_LABEL)
          .fontColor(C_SECONDARY)
          .onClick(() => {})
      }
      .width('100%')
      .height(56)
      .padding({ left: S_LG, right: S_LG })
      .backgroundColor(C_SURFACE)

      // ---- Scrollable body ----
      Scroll() {
        Column({ space: S_MD }) {
          // Mode filter chips
          Row({ space: S_SM }) {
            ForEach(this.modes, (mode: string) => {
              this.modeChip(mode)
            }, (mode: string) => mode)
          }
          .width('100%')

          // Solar wash card
          Column({ space: S_SM }) {
            Text('Solar wash')
              .fontSize(F_HEADLINE)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)
            Text('Adjust orbital window glow')
              .fontSize(F_BODY)
              .fontColor(C_ON_SURFACE_SOFT)

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .selectedColor(C_PRIMARY)
              .trackColor(C_SLIDER_TRACK)
              .blockColor(C_PRIMARY)
              .trackThickness(8)
              .width('100%')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.solarLevel = value;
              })

            Row() {
              Text('0%')
                .fontSize(F_LABEL)
                .fontColor(C_ON_SURFACE)
              Blank()
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(F_TITLE)
                .fontColor(C_PRIMARY)
            }
            .width('100%')

            Text('Ambient glow')
              .fontSize(F_HEADLINE)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .selectedColor(C_SECONDARY)
              .trackColor(C_SLIDER_TRACK)
              .blockColor(C_SECONDARY)
              .trackThickness(8)
              .width('100%')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.ambientGlow = value;
              })

            Progress({ value: this.ambientGlow, total: 1, type: ProgressType.Linear })
              .color(C_SECONDARY)
              .backgroundColor(C_SURFACE_VARIANT)
              .style({ strokeWidth: 6 })
              .width('100%')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(S_LG)
          .backgroundColor(C_SURFACE)
          .borderRadius(R_LARGE)

          // Orbit health card
          Column({ space: S_SM }) {
            Text('Orbit health')
              .fontSize(F_HEADLINE)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)
              .textAlign(TextAlign.Start)
              .width('100%')

            this.meterRow({ label: 'Atmos mix', value: 0.74, accent: C_SECONDARY })
            this.meterRow({ label: 'Hull temp', value: 0.42, accent: C_PRIMARY })
            this.meterRow({ label: 'Shield sync', value: 0.88, accent: C_TERTIARY })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(S_LG)
          .backgroundColor(C_SURFACE_VARIANT)
          .borderRadius(R_LARGE)

          // Deck zones card
          Column({ space: S_SM }) {
            Text('Deck zones')
              .fontSize(F_HEADLINE)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)
              .textAlign(TextAlign.Start)
              .width('100%')

            ForEach(this.zones, (zone: Zone) => {
              this.zoneRow(zone)
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(S_LG)
          .backgroundColor(C_SURFACE)
          .borderRadius(R_LARGE)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: S_LG, right: S_LG, top: S_SM, bottom: S_SM })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)

      // ---- Bottom bar ----
      Row() {
        Column({ space: S_XS }) {
          Text('Grid draw')
            .fontSize(F_LABEL)
            .fontColor(C_ON_SURFACE)
          Text('18.4 kWh')
            .fontSize(F_TITLE)
            .fontColor(C_PRIMARY)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Engage eco hold')
          .fontSize(F_LABEL)
          .fontColor('#FFFFFF')
          .backgroundColor(C_PRIMARY)
          .borderRadius(R_MEDIUM)
          .height(48)
          .padding({ left: S_LG, right: S_LG })
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: S_LG, right: S_LG, top: S_SM, bottom: S_SM })
      .backgroundColor(C_BOTTOM_BAR)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}