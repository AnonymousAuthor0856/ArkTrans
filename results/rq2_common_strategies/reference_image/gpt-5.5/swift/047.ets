class AppColors {
  static primary: string = '#FF8C00'
  static secondary: string = '#FFC107'
  static tertiary: string = '#FFE082'
  static background: string = '#FFF8E1'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#FFECB3'
  static outline: string = '#D7CCC8'
  static success: string = '#4CAF50'
  static warning: string = '#FFB300'
  static error: string = '#E53935'
  static onPrimary: string = '#3E2723'
  static onSecondary: string = '#3E2723'
  static onBackground: string = '#3E2723'
  static onSurface: string = '#3E2723'
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 16
  static xl: number = 24
}

class Pin {
  id: number
  x: number
  y: number
  label: string

  constructor(id: number, x: number, y: number, label: string) {
    this.id = id
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State private pins: Pin[] = [
    new Pin(1, 150, 250, 'Group A'),
    new Pin(2, 350, 420, 'Group B'),
    new Pin(3, 520, 310, 'Group C')
  ]

  private nextId: number = 4

  private randomInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min)) + min
  }

  private addGroup(): void {
    const randomX: number = this.randomInt(100, 550)
    const randomY: number = this.randomInt(150, 450)
    this.pins = [...this.pins, new Pin(this.nextId, randomX, randomY, 'New')]
    this.nextId++
  }

  build() {
    Column({ space: AppSpacing.lg }) {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      Column({ space: AppSpacing.md }) {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)

        Stack({ alignContent: Alignment.TopStart }) {
          ForEach(this.pins, (pin: Pin) => {
            Circle({ width: 28, height: 28 })
              .fill(AppColors.primary)
              .position({
                x: pin.x - 14,
                y: pin.y - 14
              })
          }, (pin: Pin) => pin.id.toString())
        }
        .width('100%')
        .height(220)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(10)
        .clip(true)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppColors.surface)
      .borderRadius(16)
      .shadow({
        radius: 6,
        color: '#263E2723',
        offsetX: 0,
        offsetY: 4
      })

      Blank()
        .height(AppSpacing.sm)

      Row({ space: AppSpacing.md }) {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .textAlign(TextAlign.Center)
        }
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppColors.secondary)
        .borderRadius(10)
        .onClick(() => {
          this.addGroup()
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .textAlign(TextAlign.Center)
        }
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppColors.primary)
        .borderRadius(10)
        .onClick(() => {
          this.pins = []
        })
      }
      .width('100%')

      Column({ space: AppSpacing.sm }) {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)

            Blank()
              .layoutWeight(1)

            Circle({ width: 14, height: 14 })
              .fill(AppColors.primary)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }, (pin: Pin) => pin.id.toString())
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppColors.surface)
      .borderRadius(16)
      .shadow({
        radius: 2,
        color: '#1A3E2723',
        offsetX: 0,
        offsetY: 2
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
  }
}