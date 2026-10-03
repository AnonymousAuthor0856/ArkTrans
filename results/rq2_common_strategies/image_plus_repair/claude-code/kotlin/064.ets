namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF111111'
    export const secondary: string = '#FF2A2A2A'
    export const tertiary: string = '#FF444444'
    export const background: string = '#FFF7F7F7'
    export const surface: string = '#FFFFFFFF'
    export const surfaceVariant: string = '#FFEDEDED'
    export const outline: string = '#FFD6D6D6'
    export const success: string = '#FF1E7D4C'
    export const warning: string = '#FFB98400'
    export const error: string = '#FFB3261E'
    export const onPrimary: string = '#FFFFFFFF'
    export const onSecondary: string = '#FFFFFFFF'
    export const onTertiary: string = '#FFFFFFFF'
    export const onBackground: string = '#FF0A0A0A'
    export const onSurface: string = '#FF0A0A0A'
  }
  export namespace TypographyTokens {
    export const display: Font = { size: 28, weight: FontWeight.Bold }
    export const headline: Font = { size: 20, weight: FontWeight.Medium }
    export const title: Font = { size: 16, weight: FontWeight.Medium }
    export const body: Font = { size: 14, weight: FontWeight.Normal }
    export const label: Font = { size: 12, weight: FontWeight.Medium }
  }
  export namespace Shapes {
    export const small: number = 8
    export const medium: number = 12
    export const large: number = 16
  }
  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
  }
}

interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_: number, index: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppTokens.Colors.surfaceVariant)
        }, (index: number): string => 'h_' + index.toString())
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(AppTokens.Spacing.lg)

      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_: number, index: number) => {
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(AppTokens.Colors.surfaceVariant)
        }, (index: number): string => 'v_' + index.toString())
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapPin {
  title: string = ''
  status: string = ''
  selected: boolean = false
  onPinClick: () => void = () => {}

  private getBaseColor(): string {
    if (this.status === 'Approved') {
      return AppTokens.Colors.success
    }
    if (this.status === 'Pending') {
      return AppTokens.Colors.warning
    }
    return AppTokens.Colors.error
  }

  build() {
    Row() {
      Stack() { }
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.getBaseColor())
        .borderRadius(999)
        .border({
          width: 2,
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface
        })

      Text(this.title)
        .font(AppTokens.TypographyTokens.label)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs
        })
        .margin({ left: -6, top: -12 })
    }
    .onClick((): void => {
      this.onPinClick()
    })
  }
}

@Component
struct FilterChip {
  label: string = ''
  isOn: boolean = false
  onChipClick: () => void = () => {}

  build() {
    Text(this.label)
      .font(this.isOn ? AppTokens.TypographyTokens.title : AppTokens.TypographyTokens.body)
      .fontColor(this.isOn ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: 8,
        bottom: 8
      })
      .onClick((): void => {
        this.onChipClick()
      })
  }
}

@Entry
@Component
struct ApprovalFlow {
  @State filters: string[] = ['Pending', 'Approved']
  @State active: string[] = ['Pending']
  @State pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]
  @State selectedId: number | null = null

  private filterPins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin): boolean => {
      switch (p.status) {
        case 'Pending':
          return this.active.indexOf('Pending') >= 0
        case 'Approved':
          return this.active.indexOf('Approved') >= 0
        case 'Rejected':
          return true
        default:
          return true
      }
    })
  }

  private toggleFilter(f: string): void {
    const idx: number = this.active.indexOf(f)
    if (idx >= 0) {
      this.active.splice(idx, 1)
    } else {
      this.active.push(f)
    }
  }

  private handlePinClick(id: number): void {
    this.selectedId = this.selectedId === id ? null : id
  }

  private getSelectedPin(): ApprovalPin | null {
    if (this.selectedId === null) {
      return null
    }
    const found: ApprovalPin[] = this.pins.filter((p: ApprovalPin): boolean => p.id === this.selectedId)
    return found.length > 0 ? found[0] : null
  }

  build() {
    Column() {
      Text('Approval Flow')
        .font(AppTokens.TypographyTokens.display)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 12, bottom: 12 })

      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          Row() {
            ForEach(this.filters, (f: string) => {
              FilterChip({
                label: f,
                isOn: this.active.indexOf(f) >= 0,
                onChipClick: (): void => {
                  this.toggleFilter(f)
                }
              })
              .margin({ right: AppTokens.Spacing.sm })
            }, (f: string): string => f)
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md })

          Stack({ alignContent: Alignment.TopStart }) {
            MapGridOverlay()

            ForEach(this.filterPins(), (pin: ApprovalPin) => {
              MapPin({
                title: pin.title,
                status: pin.status,
                selected: this.selectedId === pin.id,
                onPinClick: (): void => {
                  this.handlePinClick(pin.id)
                }
              })
              .position({ x: pin.x * 100 + '%', y: pin.y * 100 + '%' })
            }, (pin: ApprovalPin): string => pin.id.toString())

            if (this.selectedId !== null && this.getSelectedPin() !== null) {
              Row() {
                Column() {
                  Text(this.getSelectedPin()!.title)
                    .font(AppTokens.TypographyTokens.title)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text(this.getSelectedPin()!.status)
                    .font(AppTokens.TypographyTokens.label)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.xs })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Button('Details')
                  .type(ButtonType.Normal)
                  .height(40)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .fontColor(AppTokens.Colors.onSurface)
                  .fontSize(AppTokens.TypographyTokens.label.size)
                  .fontWeight(AppTokens.TypographyTokens.label.weight)
                  .borderRadius(AppTokens.Shapes.medium)
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .margin(AppTokens.Spacing.md)
              .shadow({ radius: 12, color: 'rgba(0,0,0,0.16)', offsetY: 6 })
            }
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })

        Button('+')
          .type(ButtonType.Circle)
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .shadow({ radius: 12, color: 'rgba(0,0,0,0.3)', offsetY: 4 })
          .position({ right: AppTokens.Spacing.lg, bottom: 72 })
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        Button('Reject')
          .type(ButtonType.Normal)
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .borderRadius(AppTokens.Shapes.medium)
          .enabled(this.selectedId !== null)

        Blank()
          .width(AppTokens.Spacing.md)

        Button('Approve')
          .type(ButtonType.Normal)
          .height(48)
          .layoutWeight(1)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .borderRadius(AppTokens.Shapes.medium)
          .enabled(this.selectedId !== null)
      }
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.md,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
