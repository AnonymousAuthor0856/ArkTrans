import { LengthMetrics } from '@kit.ArkUI'

interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

interface SpacingTokens {
  sm: number
  md: number
  lg: number
  xl: number
}

const Colors: ColorTokens = {
  primary: '#2563EB',
  secondary: '#38BDF8',
  tertiary: '#60A5FA',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  onPrimary: '#FFFFFF',
  onSecondary: '#0F172A',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#1E293B'
}

const Spacing: SpacingTokens = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20
}

@Component
struct MarkerBox {
  unit: string = ''
  value: string = ''
  active: boolean = false

  build() {
    Row() {
      Column() {
        Text(this.unit)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text(this.value)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? '#4DB8F826' : Colors.surface)
    .borderRadius(10)
    .border({ width: 1, color: Colors.outline })
    .padding(Spacing.md)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MapArea {
  selected: string = ''

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
      Blank().height(Spacing.md)
      Text('Active Unit: ' + this.selected)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .height(240)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(14)
    .border({ width: 1, color: Colors.outline })
    .padding(Spacing.lg)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed']
  @State active: string = 'Length'

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        Text('Unit Converter')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)

        MapArea({ selected: this.active })

        ForEach(this.markers, (item: string) => {
          MarkerBox({
            unit: item,
            value: 'Tap to convert',
            active: this.active === item
          })
        })

        Blank().height(Spacing.md)

        Row({ space: Spacing.md }) {
          ForEach(this.markers, (item: string) => {
            Button(item)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.active === item ? Colors.onPrimary : Colors.onSurface)
              .backgroundColor(this.active === item ? Colors.primary : Colors.surfaceVariant)
              .borderRadius(6)
              .padding({ left: 10, right: 10, top: 6, bottom: 6 })
              .onClick(() => {
                this.active = item
              })
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#26B8F826', 0.0], ['#262563EB', 1.0]]
    })
  }
}