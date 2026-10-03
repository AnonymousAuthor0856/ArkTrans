import { router } from '@kit.ArkUI'

// Color tokens
const Colors = {
  primary: '#FFD95F02',
  secondary: '#FF1B9AAA',
  tertiary: '#FFFEC601',
  background: '#FFF9F4EB',
  surface: '#FFFFFFFF',
  surfaceVariant: '#FFF0E3D1',
  outline: '#FFE1CDB2',
  success: '#FF56C271',
  warning: '#FFF4A259',
  error: '#FFD7263D',
  onPrimary: '#FF1B1B1B',
  onSecondary: '#FF041012',
  onTertiary: '#FF1E1200',
  onBackground: '#FF2C2A29',
  onSurface: '#FF2E2924',
}

interface ZoneData {
  name: string
  humidity: number
  temp: string
}

@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: string = Colors.secondary

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
        Text(`${Math.floor(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(this.accent)
        .backgroundColor(Colors.surface)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ZoneRow {
  zone: ZoneData = { name: '', humidity: 0, temp: '' }

  build() {
    Column({ space: 4 }) {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(Colors.secondary)
        .backgroundColor(Colors.surface)
    }
    .width('100%')
    .padding(8)
    .backgroundColor('#80F0E3D1')
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct Index {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: ZoneData[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' },
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button('Dock', { type: ButtonType.Normal })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Button('Alerts', { type: ButtonType.Normal })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 8, right: 8 })

      // Scrollable content
      Scroll() {
        Column({ space: 12 }) {
          // Mode chips
          Row({ space: 8 }) {
            ForEach(this.modes, (mode: string) => {
              Button(mode, { type: ButtonType.Normal })
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .backgroundColor(this.activeMode === mode ? '#26D95F02' : Colors.surface)
                .borderRadius(12)
                .border({ width: 1, color: Colors.outline })
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .onClick(() => {
                  this.activeMode = mode
                })
            })
          }
          .width('100%')

          // Solar wash card
          Column({ space: 8 }) {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontWeight(FontWeight.Normal)
              .fontColor('#B32E2924')
              .alignSelf(ItemAlign.Start)

            Slider({
              value: this.solarLevel * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .trackColor(Colors.surfaceVariant)
              .selectedColor(Colors.primary)
              .blockColor(Colors.primary)
              .onChange((value: number) => {
                this.solarLevel = value / 100
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text(`${Math.floor(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            Slider({
              value: this.ambientGlow * 100,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .trackColor(Colors.surfaceVariant)
              .selectedColor(Colors.secondary)
              .blockColor(Colors.secondary)
              .onChange((value: number) => {
                this.ambientGlow = value / 100
              })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(6)
              .color(Colors.secondary)
              .backgroundColor(Colors.surfaceVariant)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Colors.surface)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)

          // Orbit health card
          Column({ space: 8 }) {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: Colors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: Colors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: Colors.tertiary })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)

          // Deck zones card
          Column({ space: 8 }) {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            ForEach(this.zones, (zone: ZoneData) => {
              ZoneRow({ zone: zone })
            })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(Colors.surface)
          .borderRadius(20)
          .alignItems(HorizontalAlign.Start)
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      // Bottom bar
      Row() {
        Column({ space: 4 }) {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.primary)
        }
        .alignItems(HorizontalAlign.Start)

        Button('Engage eco hold', { type: ButtonType.Normal })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}