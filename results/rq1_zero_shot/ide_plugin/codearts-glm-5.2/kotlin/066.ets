const AppColors = {
  primary: '#214E34',
  secondary: '#2D6A4F',
  tertiary: '#6C757D',
  background: '#F8F1E5',
  surface: '#FFFBF0',
  surfaceVariant: '#E9DFC7',
  outline: '#D2C6AA',
  success: '#2B9348',
  warning: '#F4A261',
  error: '#D62828',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#1B1F22',
  onBackground: '#1B1F22',
  onSurface: '#1B1F22',
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  xxl: 28,
  xxxl: 40,
}

const AppShapes = {
  small: 6,
  medium: 10,
  large: 14,
}

class DayTab {
  id: number = 0
  label: string = ''
  constructor(id: number, label: string) {
    this.id = id
    this.label = label
  }
}

class StockRow {
  code: string = ''
  name: string = ''
  price: string = ''
  change: string = ''
  positive: boolean = false
  constructor(code: string, name: string, price: string, change: string, positive: boolean) {
    this.code = code
    this.name = name
    this.price = price
    this.change = change
    this.positive = positive
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1
  @State currentSector: string = 'All'
  private days: DayTab[] = [
    new DayTab(1, 'Mon'),
    new DayTab(2, 'Tue'),
    new DayTab(3, 'Wed'),
    new DayTab(4, 'Thu'),
    new DayTab(5, 'Fri'),
  ]
  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance']
  private items: StockRow[] = [
    new StockRow('600519', 'Kweichow Moutai', '1687.3', '+1.24%', true),
    new StockRow('000001', 'Ping An Bank', '12.54', '-0.62%', false),
    new StockRow('300750', 'CATL', '192.8', '+0.87%', true),
    new StockRow('601318', 'Ping An Ins.', '44.2', '-1.12%', false),
    new StockRow('600036', 'CMBC', '36.9', '+0.15%', true),
    new StockRow('688981', 'SMIC', '56.4', '-0.48%', false),
  ]

  @Builder
  DayTabBuilder(d: DayTab) {
    Column() {
      Text(d.label)
        .fontSize(d.id === this.selectedDayId ? 16 : 13)
        .fontWeight(d.id === this.selectedDayId ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(d.id === this.selectedDayId ? AppColors.onPrimary : AppColors.onSurface)
    }
    .layoutWeight(1)
    .height(36)
    .backgroundColor(d.id === this.selectedDayId ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(AppShapes.small)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedDayId = d.id
    })
  }

  @Builder
  SectorChipBuilder(s: string) {
    Text(s)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentSector === s ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.currentSector === s ? AppColors.secondary : AppColors.surface)
      .borderRadius(AppShapes.small)
      .borderWidth(1)
      .borderColor(AppColors.outline)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: 6, bottom: 6 })
      .onClick(() => {
        this.currentSector = s
      })
  }

  @Builder
  StockRowBuilder(itx: StockRow) {
    Row() {
      Row() {
        Column() {}
          .width(28)
          .height(28)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        Column() {
          Text(itx.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(itx.code)
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ left: AppSpacing.md })
      }
      .alignItems(VerticalAlign.Center)

      Row() {
        Column() {
          Text(itx.price)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Row() {
            Column() {}
              .width(8)
              .height(8)
              .backgroundColor(itx.positive ? AppColors.success : AppColors.error)
              .borderRadius(AppShapes.small)
            Text(itx.change)
              .fontSize(11)
              .fontWeight(FontWeight.Medium)
              .fontColor(itx.positive ? AppColors.success : AppColors.error)
              .margin({ left: AppSpacing.xs })
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(HorizontalAlign.End)

        Button('Detail') {
          Text('Detail')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
          .type(ButtonType.Normal)
          .height(36)
          .width(76)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
          .margin({ left: AppSpacing.lg })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .borderWidth(1)
    .borderColor(AppColors.outline)
  }

  build() {
    Column() {
      Text('Stock Calendar')
        .fontSize(26)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.md })

      Column() {
        Row() {
          ForEach(this.days, (d: DayTab) => {
            this.DayTabBuilder(d)
          }, (d: DayTab) => d.id.toString())
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Row() {
          ForEach(this.sectors, (s: string) => {
            this.SectorChipBuilder(s)
          }, (s: string) => s)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: AppSpacing.sm })
      }
      .width('100%')
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .borderWidth(1)
      .borderColor(AppColors.outline)

      List({ space: AppSpacing.sm }) {
        ForEach(this.items, (itx: StockRow) => {
          ListItem() {
            this.StockRowBuilder(itx)
          }
        }, (itx: StockRow) => itx.code)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: AppSpacing.xxxl })
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.background)
  }
}